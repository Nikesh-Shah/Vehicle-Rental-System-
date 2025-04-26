package dao;

import model.Booking;
import model.Vehicle;
import util.DbConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class BookingDAO {
    // Booking status constants
    public static final String STATUS_PENDING = "Pending";
    public static final String STATUS_CONFIRMED = "Confirmed";
    public static final String STATUS_CANCELLED = "Cancelled";
    public static final String STATUS_COMPLETED = "Completed";

    // Create a new booking
    public int createBooking(Booking booking) throws SQLException {
        String sql = "INSERT INTO booking (booking_status, booking_start_date, " +
                "booking_end_date, booking_total_amount) VALUES (?, ?, ?, ?)";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, booking.getStatus());
            stmt.setDate(2, new java.sql.Date(booking.getStartDate().getTime()));
            stmt.setDate(3, new java.sql.Date(booking.getEndDate().getTime()));
            stmt.setDouble(4, booking.getTotalAmount());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating booking failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating booking failed, no ID obtained.");
                }
            }
        }
    }

    // Add vehicle to booking
    public void addVehicleToBooking(int bookingId, int vehicleId) throws SQLException {
        String sql = "INSERT INTO booking_vehicle (bookingId, vehicleId) VALUES (?, ?)";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookingId);
            stmt.setInt(2, vehicleId);
            stmt.executeUpdate();
        }
    }

    // Get booking by ID
    public Booking getBookingById(int bookingId) throws SQLException {
        String sql = "SELECT b.*, u.fname, u.lname FROM booking b " +
                "JOIN user_booking ub ON b.bookingId = ub.bookingId " +
                "JOIN users u ON ub.user_id = u.user_id " +
                "WHERE b.bookingId = ?";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookingId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Booking booking = new Booking();
                    booking.setBookingId(rs.getInt("bookingId"));
                    booking.setStatus(rs.getString("booking_status"));
                    booking.setStartDate(rs.getDate("booking_start_date"));
                    booking.setEndDate(rs.getDate("booking_end_date"));
                    booking.setTotalAmount(rs.getDouble("booking_total_amount"));
                    booking.setUserId(rs.getInt("user_id"));

                    // Get associated vehicles
                    booking.setVehicles(getVehiclesForBooking(bookingId));
                    return booking;
                }
            }
        }
        return null;
    }

    // Get vehicles for a booking
    private List<Vehicle> getVehiclesForBooking(int bookingId) throws SQLException {
        String sql = "SELECT v.* FROM vehicle v " +
                "JOIN booking_vehicle bv ON v.vehicleId = bv.vehicleId " +
                "WHERE bv.bookingId = ?";

        List<Vehicle> vehicles = new ArrayList<>();
        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookingId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Vehicle vehicle = new Vehicle();
                    vehicle.setVehicleId(rs.getInt("vehicleId"));
                    vehicle.setBrand(rs.getString("vehicle_brand"));
                    vehicle.setModel(rs.getString("vehicle_model"));
                    vehicle.setPricePerDay(rs.getDouble("vehicle_price_per_day"));
                    vehicles.add(vehicle);
                }
            }
        }
        return vehicles;
    }

    // Get bookings by user ID
    public List<Booking> getBookingsByUserId(int userId) throws SQLException {
        String sql = "SELECT b.* FROM booking b " +
                "JOIN user_booking ub ON b.bookingId = ub.bookingId " +
                "WHERE ub.user_id = ? ORDER BY b.booking_start_date DESC";

        List<Booking> bookings = new ArrayList<>();
        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setBookingId(rs.getInt("bookingId"));
                    booking.setStatus(rs.getString("booking_status"));
                    booking.setStartDate(rs.getDate("booking_start_date"));
                    booking.setEndDate(rs.getDate("booking_end_date"));
                    booking.setTotalAmount(rs.getDouble("booking_total_amount"));

                    // Get associated vehicles
                    booking.setVehicles(getVehiclesForBooking(booking.getBookingId()));
                    bookings.add(booking);
                }
            }
        }
        return bookings;
    }

    // Update booking status
    public boolean updateBookingStatus(int bookingId, String status) throws SQLException {
        String sql = "UPDATE booking SET booking_status = ? WHERE bookingId = ?";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, bookingId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Link user to booking
    public void linkUserToBooking(int bookingId, int userId) throws SQLException {
        String sql = "INSERT INTO user_booking (bookingId, user_id) VALUES (?, ?)";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookingId);
            stmt.setInt(2, userId);
            stmt.executeUpdate();
        }
    }
}