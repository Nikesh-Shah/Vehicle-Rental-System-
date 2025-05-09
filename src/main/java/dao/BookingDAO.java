package dao;

import model.Booking;
import model.User;
import model.Vehicle;
import util.DbConnectionUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.sql.Date;
import java.util.Map;

public class BookingDAO {
    public int createBooking(Booking booking) throws SQLException {
        String sql = "INSERT INTO booking (booking_status, booking_start_date, booking_end_date, booking_total_amount) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, booking.getStatus());
            stmt.setDate(2, new java.sql.Date(booking.getStartDate().getTime()));
            stmt.setDate(3, new java.sql.Date(booking.getEndDate().getTime()));
            stmt.setDouble(4, booking.getTotalAmount());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) throw new SQLException("Creating booking failed");

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
                else throw new SQLException("Creating booking failed");
            }
        }
    }

    public void linkUserToBooking(int bookingId, int userId) throws SQLException {
        String sql = "INSERT INTO user_booking (bookingId, user_id) VALUES (?, ?)";
        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookingId);
            stmt.setInt(2, userId);
            stmt.executeUpdate();
        }
    }

    public void addVehicleToBooking(int bookingId, int vehicleId) throws SQLException {
        String sql = "INSERT INTO booking_vehicle (bookingId, vehicleId) VALUES (?, ?)";
        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookingId);
            stmt.setInt(2, vehicleId);
            stmt.executeUpdate();
        }
    }
    public List<Booking> getBookingsByUserId(int userId) throws SQLException {
        String sql =
                "SELECT b.bookingId, b.booking_start_date, b.booking_end_date, " +
                        "       b.booking_total_amount, b.booking_status, " +
                        "       v.vehicleId, v.vehicle_brand, v.vehicle_model, " +
                        "       v.vehicle_price_per_day, v.vehicle_image " +
                        "  FROM booking b " +
                        "  JOIN user_booking ub ON b.bookingId = ub.bookingId " +
                        "  JOIN booking_vehicle bv ON b.bookingId = bv.bookingId " +
                        "  JOIN vehicle v ON bv.vehicleId = v.vehicleId " +
                        " WHERE ub.user_id = ? " +
                        " ORDER BY b.booking_start_date DESC";

        Map<Integer,Booking> bookingsMap = new LinkedHashMap<>();

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int bookingId = rs.getInt("bookingId");

                Booking booking = bookingsMap.get(bookingId);
                if (booking == null) {
                    booking = new Booking();
                    booking.setBookingId(bookingId);
                    booking.setStartDate(rs.getDate("booking_start_date"));
                    booking.setEndDate(rs.getDate("booking_end_date"));
                    booking.setTotalAmount(rs.getDouble("booking_total_amount"));
                    booking.setStatus(rs.getString("booking_status"));
                    bookingsMap.put(bookingId, booking);
                }

                Vehicle vehicle = new Vehicle();
                vehicle.setVehicleId(rs.getInt("vehicleId"));
                vehicle.setBrand(rs.getString("vehicle_brand"));
                vehicle.setModel(rs.getString("vehicle_model"));
                vehicle.setPricePerDay(rs.getDouble("vehicle_price_per_day"));
                vehicle.setImage(rs.getString("vehicle_image"));

                booking.getVehicles().add(vehicle);
            }
        }

        return new ArrayList<>(bookingsMap.values());
    }

    public void updateBookingStatus(int bookingId, String status) throws SQLException {
        String sql = "UPDATE booking SET booking_status = ? WHERE bookingId = ?";
        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, bookingId);
            stmt.executeUpdate();
        }
    }

    public void cancelBooking(int bookingId) throws SQLException {
        updateBookingStatus(bookingId, "Cancelled");
    }

    public boolean deleteBooking(int bookingId) throws SQLException {
        Connection conn = null;
        try {
            conn = DbConnectionUtil.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // 1. Delete from booking_vehicle first
            String deleteVehicleSQL = "DELETE FROM booking_vehicle WHERE bookingId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteVehicleSQL)) {
                stmt.setInt(1, bookingId);
                stmt.executeUpdate();
            }

            // 2. Delete from user_booking (if exists)
            String deleteUserBookingSQL = "DELETE FROM user_booking WHERE bookingId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteUserBookingSQL)) {
                stmt.setInt(1, bookingId);
                stmt.executeUpdate();
            }

            // 3. Delete from payment (if exists)
            String deletePaymentSQL = "DELETE FROM payment WHERE bookingId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deletePaymentSQL)) {
                stmt.setInt(1, bookingId);
                stmt.executeUpdate();
            }

            // 4. Finally delete from booking
            String deleteBookingSQL = "DELETE FROM booking WHERE bookingId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteBookingSQL)) {
                stmt.setInt(1, bookingId);
                int affectedRows = stmt.executeUpdate();
                conn.commit(); // Commit transaction
                return affectedRows > 0;
            }
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) conn.close();
        }
    }
    public List<Booking> getAllBookings(String statusFilter) throws SQLException {
        String sql = "SELECT b.*, u.user_id, u.fname, u.lname, u.email, " +
                "GROUP_CONCAT(CONCAT(v.vehicle_brand, ' ', v.vehicle_model) SEPARATOR '|') AS vehicles " +
                "FROM booking b " +
                "JOIN user_booking ub ON b.bookingId = ub.bookingId " +
                "JOIN users u ON ub.user_id = u.user_id " +
                "JOIN booking_vehicle bv ON b.bookingId = bv.bookingId " +
                "JOIN vehicle v ON bv.vehicleId = v.vehicleId " +
                (statusFilter != null ? "WHERE b.booking_status = ? " : "") +
                "GROUP BY b.bookingId " +
                "ORDER BY b.booking_start_date DESC";

        List<Booking> bookings = new ArrayList<>();

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            if (statusFilter != null) {
                stmt.setString(1, statusFilter);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                // Set basic booking info
                booking.setBookingId(rs.getInt("bookingId"));
                booking.setStartDate(rs.getDate("booking_start_date"));
                booking.setEndDate(rs.getDate("booking_end_date"));
                booking.setTotalAmount(rs.getDouble("booking_total_amount"));
                booking.setStatus(rs.getString("booking_status"));

                // Set user info
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFname(rs.getString("fname"));
                user.setLname(rs.getString("lname"));
                user.setEmail(rs.getString("email"));
                booking.setUser(user);

                // Process vehicles
                String vehiclesString = rs.getString("vehicles");
                List<Vehicle> vehicles = new ArrayList<>();
                if (vehiclesString != null) {
                    for (String vehicleStr : vehiclesString.split("\\|")) {
                        String[] parts = vehicleStr.split(" ", 2);
                        if (parts.length == 2) {
                            Vehicle vehicle = new Vehicle();
                            vehicle.setBrand(parts[0]);
                            vehicle.setModel(parts[1]);
                            vehicles.add(vehicle);
                        }
                    }
                }
                booking.setVehicles(vehicles);

                bookings.add(booking);
            }
        }
        return bookings;
    }




}
