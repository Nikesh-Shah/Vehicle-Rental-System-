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
    public void linkUserToBooking(int bookingId,int vehicleId, int userId, int paymentId) throws SQLException {
        String sql = "INSERT INTO user_booking (bookingId,vehicleId, user_id, paymentId) VALUES (?, ?, ?,?)";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookingId);
            stmt.setInt(2, vehicleId);
            stmt.setInt(3, userId);
            stmt.setInt(4, paymentId);

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                System.out.println("[DEBUG] User linked to booking successfully with payment (Booking ID: " + bookingId + ", User ID: " + userId + ", Payment ID: " + paymentId + ")");
            } else {
                System.out.println("[ERROR] Failed to link user to booking.");
            }
        }
    }


    public void addVehicleToBooking(int bookingId, int vehicleId, int categoryId, int userId) throws SQLException {
        String sql = "INSERT INTO booking_vehicle (bookingId, vehicleId, categoryId, user_id) VALUES (?, ?, ?, ?)";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookingId);
            stmt.setInt(2, vehicleId);
            stmt.setInt(3, categoryId);
            stmt.setInt(4, userId);

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                System.out.println("[DEBUG] Vehicle added to booking successfully (Booking ID: " + bookingId + ", Vehicle ID: " + vehicleId + ")");
            } else {
                System.out.println("[ERROR] Failed to add vehicle to booking.");
            }
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


    public boolean deleteBookingByAdmin(int bookingId) throws SQLException {
        Connection conn = null;
        try {
            conn = DbConnectionUtil.getConnection();
            conn.setAutoCommit(false); // Start transaction
            System.out.println("[DEBUG] Connection established successfully");

            // 1. Delete from booking_vehicle first
            System.out.println("[DEBUG] Deleting from booking_vehicle with ID: " + bookingId);
            String deleteVehicleSQL = "DELETE FROM booking_vehicle WHERE bookingId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteVehicleSQL)) {
                stmt.setInt(1, bookingId);
                int rows = stmt.executeUpdate();
                System.out.println("[DEBUG] Rows deleted from booking_vehicle: " + rows);
            }

            // 2. Delete from user_booking (if exists)
            System.out.println("[DEBUG] Deleting from user_booking with ID: " + bookingId);
            String deleteUserBookingSQL = "DELETE FROM user_booking WHERE bookingId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteUserBookingSQL)) {
                stmt.setInt(1, bookingId);
                int rows = stmt.executeUpdate();
                System.out.println("[DEBUG] Rows deleted from user_booking: " + rows);
            }


            // 4. Finally delete from booking
            System.out.println("[DEBUG] Deleting from booking with ID: " + bookingId);
            String deleteBookingSQL = "DELETE FROM booking WHERE bookingId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteBookingSQL)) {
                stmt.setInt(1, bookingId);
                int affectedRows = stmt.executeUpdate();
                System.out.println("[DEBUG] Rows deleted from booking: " + affectedRows);
                conn.commit(); // Commit transaction
                return affectedRows > 0;
            }
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            System.out.println("[ERROR] SQL Exception during deletion: " + e.getMessage());
            throw e;
        } finally {
            if (conn != null) conn.close();
        }
    }
public boolean deleteBooking(int bookingId) throws SQLException {
    Connection conn = null;
    try {
        conn = DbConnectionUtil.getConnection();
        System.out.println("[DEBUG] Connection established successfully");

        // Soft delete: Update booking status to 'Archived'
        System.out.println("[DEBUG] Updating booking status to 'Archived' for ID: " + bookingId);
        String updateBookingSQL = "UPDATE booking SET booking_status = ? WHERE bookingId = ?";
        try (PreparedStatement stmt = conn.prepareStatement(updateBookingSQL)) {
            stmt.setString(1, "Archived");
            stmt.setInt(2, bookingId);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("[DEBUG] Rows updated in booking: " + rowsAffected);
            return rowsAffected > 0;
        }
    } catch (SQLException e) {
        System.out.println("[ERROR] SQL Exception during soft delete: " + e.getMessage());
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
    public boolean cancelBookingByUser(int bookingId) throws SQLException {
        Connection conn = null;
        try {
            System.out.println("Starting cancellation process for bookingId: " + bookingId);

            conn = DbConnectionUtil.getConnection();
            conn.setAutoCommit(false);

            // 1. Set booking status to 'Cancelled'
            System.out.println("Updating booking status to 'Cancelled'...");
            String updateBookingSQL = "UPDATE booking SET booking_status = 'Cancelled' WHERE bookingId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateBookingSQL)) {
                stmt.setInt(1, bookingId);
                int rowsUpdated = stmt.executeUpdate();
                System.out.println("Booking table updated. Rows affected: " + rowsUpdated);
            }

            // 2. Get vehicles associated with booking
            System.out.println("Fetching associated vehicles...");
            String getVehiclesSQL = "SELECT vehicleId FROM booking_vehicle WHERE bookingId = ?";
            List<Integer> vehicleIds = new ArrayList<>();
            try (PreparedStatement stmt = conn.prepareStatement(getVehiclesSQL)) {
                stmt.setInt(1, bookingId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    int vehicleId = rs.getInt("vehicleId");
                    vehicleIds.add(vehicleId);
                    System.out.println("Found vehicleId: " + vehicleId);
                }
            }

            // 3. Update vehicle quantities (+1 for each)
            System.out.println("Updating vehicle quantities...");
            String updateVehicleQtySQL = "UPDATE vehicle SET quantity = quantity + 1 WHERE vehicleId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateVehicleQtySQL)) {
                for (int vehicleId : vehicleIds) {
                    stmt.setInt(1, vehicleId);
                    int rowsAffected = stmt.executeUpdate();
                    System.out.println("VehicleId " + vehicleId + " quantity updated. Rows affected: " + rowsAffected);
                }
            }

            // 4. Optional: Update payment table if needed
            System.out.println("Updating payment status to 'Refunded'...");
            String updatePaymentSQL = "UPDATE payment SET payment_status = 'Refunded' WHERE paymentId = (SELECT paymentId FROM user_booking WHERE bookingId = ?)";
            try (PreparedStatement stmt = conn.prepareStatement(updatePaymentSQL)) {
                stmt.setInt(1, bookingId);
                int paymentRowsUpdated = stmt.executeUpdate();
                System.out.println("Payment table updated. Rows affected: " + paymentRowsUpdated);
            }

            conn.commit();
            System.out.println("Cancellation process completed successfully for bookingId: " + bookingId);
            return true;
        } catch (SQLException e) {
            System.err.println("Error occurred during cancellation: " + e.getMessage());
            if (conn != null) {
                conn.rollback();
                System.out.println("Transaction rolled back.");
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
                System.out.println("Database connection closed.");
            }
        }
    }

    public void updateBookingDatesAndPayment(int bookingId, java.util.Date newStartDate, java.util.Date newEndDate) throws SQLException {
        Connection conn = null;
        try {
            conn = DbConnectionUtil.getConnection();
            conn.setAutoCommit(false);

            // 1. Update booking dates
            String updateBookingSQL = "UPDATE booking SET booking_start_date = ?, booking_end_date = ? WHERE bookingId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateBookingSQL)) {
                stmt.setDate(1, new java.sql.Date(newStartDate.getTime()));
                stmt.setDate(2, new java.sql.Date(newEndDate.getTime()));
                stmt.setInt(3, bookingId);
                stmt.executeUpdate();
            }

            // 2. Get vehicle IDs and price per day
            String getVehiclesSQL = "SELECT v.vehicle_price_per_day FROM booking_vehicle bv JOIN vehicle v ON bv.vehicleId = v.vehicleId WHERE bv.bookingId = ?";
            double totalPerDay = 0;
            try (PreparedStatement stmt = conn.prepareStatement(getVehiclesSQL)) {
                stmt.setInt(1, bookingId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    totalPerDay += rs.getDouble("vehicle_price_per_day");
                }
            }

            // 3. Calculate new total amount
            long days = (newEndDate.getTime() - newStartDate.getTime()) / (1000 * 60 * 60 * 24) + 1;
            double newTotal = totalPerDay * days;

            // 4. Update booking total amount
            String updateTotalSQL = "UPDATE booking SET booking_total_amount = ? WHERE bookingId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateTotalSQL)) {
                stmt.setDouble(1, newTotal);
                stmt.setInt(2, bookingId);
                stmt.executeUpdate();
            }

            // 5. Optional: Update payment table
            String updatePaymentSQL = "UPDATE payment SET payment_amount = ? WHERE paymentId = (SELECT paymentId FROM user_booking WHERE bookingId = ?)";
            try (PreparedStatement stmt = conn.prepareStatement(updatePaymentSQL)) {
                stmt.setDouble(1, newTotal);
                stmt.setInt(2, bookingId);
                stmt.executeUpdate();
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) conn.close();
        }
    }
    public void updateEndedBookings() throws SQLException {
        Connection conn = null;
        try {
            conn = DbConnectionUtil.getConnection();
            conn.setAutoCommit(false);

            // Step 1: Find all bookings that have ended but status is still 'Booked' or 'Ongoing'
            String selectSQL = "SELECT bookingId FROM booking WHERE booking_end_date <= CURRENT_DATE AND booking_status IN ('Booked', 'Ongoing')";
            List<Integer> endedBookingIds = new ArrayList<>();
            try (PreparedStatement stmt = conn.prepareStatement(selectSQL);
                 ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    endedBookingIds.add(rs.getInt("bookingId"));
                }
            }

            // Step 2: For each ended booking
            for (int bookingId : endedBookingIds) {
                // a) Update booking status to 'Booking Ended'
                String updateStatusSQL = "UPDATE booking SET booking_status = 'Booking Ended' WHERE bookingId = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updateStatusSQL)) {
                    stmt.setInt(1, bookingId);
                    stmt.executeUpdate();
                }

                // b) Get all vehicleIds linked to this booking
                String getVehiclesSQL = "SELECT vehicleId FROM booking_vehicle WHERE bookingId = ?";
                List<Integer> vehicleIds = new ArrayList<>();
                try (PreparedStatement stmt = conn.prepareStatement(getVehiclesSQL)) {
                    stmt.setInt(1, bookingId);
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        vehicleIds.add(rs.getInt("vehicleId"));
                    }
                }

                // c) Update vehicle quantities (+1 for each)
                String updateQtySQL = "UPDATE vehicle SET quantity = quantity + 1 WHERE vehicleId = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updateQtySQL)) {
                    for (int vehicleId : vehicleIds) {
                        stmt.setInt(1, vehicleId);
                        stmt.executeUpdate();
                    }
                }
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) conn.close();
        }
    }






}
