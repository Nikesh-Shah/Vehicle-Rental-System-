package dao;

import model.*;
import util.DbConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static util.DbConnectionUtil.getConnection;

public class AdminDAO {
    private final VehicleDAO vehicleDAO = new VehicleDAO();
    private final BookingDAO bookingDAO = new BookingDAO();
    private final UserDAO userDAO = new UserDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final PaymentDAO paymentDAO = new PaymentDAO();

    // User Management
    public List<User> getAllUsers(int limit, int offset) throws SQLException {
        String sql = "SELECT * FROM users ORDER BY created_at DESC LIMIT ? OFFSET ?";
        List<User> users = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);
            stmt.setInt(2, offset);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    User user = mapResultSetToUser(rs);
                    users.add(user);
                }
            }
        }
        return users;
    }
    public static int countUsers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users"; // Adjust table name if needed

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        }

        return 0;
    }

    public static int countBookings() throws SQLException {
        String sql = "SELECT COUNT(*) FROM booking";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;

    }
    public static int countVehicle() throws SQLException{
        String sql = "SELECT COUNT(*) FROM vehicle";
        try (Connection conn = getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }


//    public boolean updateUserRole(int userId, int newRole) throws SQLException {
//        String sql = "UPDATE users SET role = ? WHERE user_id = ?";
//        try (Connection conn = DbConnectionUtil.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//
//            stmt.setInt(1, newRole);
//            stmt.setInt(2, userId);
//            return stmt.executeUpdate() > 0;
//        }
//    }

    // Booking Management
    public List<Booking> getAllBookings(int limit, int offset) throws SQLException {
        String sql = "SELECT b.*, u.fname, u.lname FROM booking b " +
                "JOIN user_booking ub ON b.bookingId = ub.bookingId " +
                "JOIN users u ON ub.user_id = u.user_id " +
                "ORDER BY b.booking_start_date DESC LIMIT ? OFFSET ?";
        List<Booking> bookings = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);
            stmt.setInt(2, offset);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Booking booking = mapResultSetToBooking(rs);
                    bookings.add(booking);
                }
            }
        }
        return bookings;
    }

    // Vehicle Management
    public List<Vehicle> getAllVehicles(int limit, int offset) throws SQLException {
        return vehicleDAO.getAllVehicles();
    }

    // Category Management
    public List<Category> getAllCategories() throws SQLException {
        return categoryDAO.getAllCategories();
    }

    // Payment Management
//    public List<Payment> getAllPayments(int limit, int offset) throws SQLException {
//        return paymentDAO.getAllPayments(limit, offset);
//    }

    public Map<String, Object> getDashboardStatistics() throws SQLException {
        Map<String, Object> stats = new HashMap<>();

        // Total counts
        stats.put("totalUsers", getCount("users"));
        stats.put("totalBookings", getCount("booking"));
        stats.put("totalVehicles", getCount("vehicle"));
        stats.put("totalRevenue", getTotalRevenue());

        // Recent activity
        stats.put("recentBookings", getRecentBookings(5));
//        stats.put("recentPayments", getRecentPayments(5));

        return stats;
    }

    // Helper methods
    private int getCount(String table) throws SQLException {
        String sql = "SELECT COUNT(*) FROM " + table;
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private double getTotalRevenue() throws SQLException {
        String sql = "SELECT SUM(payment_amount) FROM payment WHERE payment_status = 'Completed'";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            return rs.next() ? rs.getDouble(1) : 0;
        }
    }
    public List<Booking> getRecentBookings(int limit) throws SQLException {
        String sql = "SELECT b.bookingId, b.booking_status as status, " +
                "b.booking_start_date as startDate, b.booking_end_date as endDate, " +
                "b.booking_total_amount as totalAmount, ub.user_id as userId, " +
                "u.fname, u.lname, v.vehicleId, v.vehicle_brand, v.vehicle_model " +
                "FROM booking b " +
                "JOIN user_booking ub ON b.bookingId = ub.bookingId " +
                "JOIN users u ON ub.user_id = u.user_id " +
                "LEFT JOIN booking_vehicle bv ON b.bookingId = bv.bookingId " +
                "LEFT JOIN vehicle v ON bv.vehicleId = v.vehicleId " +
                "ORDER BY b.booking_start_date DESC LIMIT ?";

        List<Booking> bookings = new ArrayList<>();
        Map<Integer, Booking> bookingMap = new HashMap<>();

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int bookingId = rs.getInt("bookingId");
                    Booking booking;

                    if (bookingMap.containsKey(bookingId)) {
                        booking = bookingMap.get(bookingId);
                    } else {
                        booking = new Booking();
                        booking.setBookingId(bookingId);
                        booking.setStatus(rs.getString("status"));
                        booking.setStartDate(rs.getDate("startDate"));
                        booking.setEndDate(rs.getDate("endDate"));
                        booking.setTotalAmount(rs.getDouble("totalAmount"));
                        booking.setUserId(rs.getInt("userId"));
                        booking.setVehicles(new ArrayList<>());
                        bookingMap.put(bookingId, booking);
                        bookings.add(booking);
                    }

                    // Add vehicle if exists
                    if (rs.getObject("vehicleId") != null) {
                        Vehicle vehicle = new Vehicle();
                        vehicle.setVehicleId(rs.getInt("vehicleId"));
                        vehicle.setBrand(rs.getString("vehicle_brand"));
                        vehicle.setModel(rs.getString("vehicle_model"));
                        booking.getVehicles().add(vehicle);
                    }
                }
            }
        }

        return bookings;
    }

    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setFname(rs.getString("fname"));
        user.setLname(rs.getString("lname"));
        user.setEmail(rs.getString("email"));
        user.setRole(rs.getInt("role"));
        user.setPhone(rs.getString("phone"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        return user;
    }

    private Booking mapResultSetToBooking(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setBookingId(rs.getInt("bookingId"));
        booking.setStatus(rs.getString("booking_status"));
        booking.setStartDate(rs.getDate("booking_start_date"));
        booking.setEndDate(rs.getDate("booking_end_date"));
        booking.setTotalAmount(rs.getDouble("booking_total_amount"));
        return booking;
    }
}