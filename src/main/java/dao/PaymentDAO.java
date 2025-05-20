
package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Payment;
import util.DbConnectionUtil;

public class PaymentDAO {


    public int createPayment(int bookingId, double amount) throws SQLException {
        String sql = "INSERT INTO payment (payment_date, payment_amount, payment_method, payment_status) " +
                "VALUES (CURRENT_DATE, ?, 'COD', 'Pending')";

        int paymentId = -1;

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setDouble(1, amount);
            stmt.executeUpdate();

            // Get the generated payment ID
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    paymentId = generatedKeys.getInt(1);
                    System.out.println("[DEBUG] Payment created with ID: " + paymentId);
                } else {
                    throw new SQLException("[ERROR] Failed to retrieve payment ID.");
                }
            }
        }
        return paymentId;
    }



    public List<Payment> getAllPayments() throws SQLException {
        List<Payment> payments = new ArrayList<>();

        String sql = "SELECT p.*, u.fname, u.lname, b.booking_start_date, b.booking_end_date " +
                "FROM payment p " +
                "JOIN user_booking ub ON p.paymentId = ub.paymentId " +
                "JOIN users u ON ub.user_id = u.user_id " +
                "JOIN booking b ON ub.bookingId = b.bookingId " +
                "ORDER BY p.payment_date DESC";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Payment payment = mapPaymentWithDetails(rs);
                payments.add(payment);
            }
        }
        return payments;
    }

    public List<Payment> getRecentPayments(int limit) throws SQLException {
        List<Payment> payments = new ArrayList<>();

        String sql = "SELECT p.*, u.fname, u.lname, b.booking_start_date, b.booking_end_date " +
                "FROM payment p " +
                "JOIN user_booking ub ON p.paymentId = ub.paymentId " +
                "JOIN users u ON ub.user_id = u.user_id " +
                "JOIN booking b ON ub.bookingId = b.bookingId " +
                "ORDER BY p.payment_date DESC LIMIT 10";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Payment payment = mapPaymentWithDetails(rs);
                payments.add(payment);
            }
        }
        return payments;
    }


    private Payment mapPaymentWithDetails(ResultSet rs) throws SQLException {
        Payment payment = new Payment();
        payment.setPaymentId(rs.getInt("paymentId"));
        payment.setPaymentDate(rs.getDate("payment_date"));
        payment.setAmount(rs.getDouble("payment_amount"));
        payment.setMethod(rs.getString("payment_method"));
        payment.setStatus(rs.getString("payment_status"));

        // Additional fields from joins
        payment.setCustomerName(rs.getString("fname") + " " + rs.getString("lname"));
        payment.setBookingStartDate(rs.getDate("booking_start_date"));
        payment.setBookingEndDate(rs.getDate("booking_end_date"));

        return payment;
    }
    public boolean updatePaymentStatus(int paymentId, String newStatus) throws SQLException {
        String sql = "UPDATE payment SET payment_status = ? WHERE paymentId = ?";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newStatus);
            stmt.setInt(2, paymentId);

            int rowsAffected = stmt.executeUpdate();
            System.out.println("[DEBUG] Payment status updated for Payment ID: " + paymentId + ", New Status: " + newStatus);

            return rowsAffected > 0;
        }
    }
    public double calculateTotalRevenue() throws SQLException {
        String sql = "SELECT SUM(payment_amount) AS total_revenue FROM payment";

        double totalRevenue = 0.0;

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                totalRevenue = rs.getDouble("total_revenue");
            }
        }

        System.out.println("[DEBUG] Total Revenue Calculated: " + totalRevenue);
        return totalRevenue;
    }
    public double calculateTotalCompletedRevenue() throws SQLException {
        String sql = "SELECT SUM(payment_amount) AS totalcompletedRevenue FROM payment WHERE payment_status = 'Completed'";

        double totalcompletedRevenue = 0.0;

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                totalcompletedRevenue = rs.getDouble("totalcompletedRevenue");
            }
        }

        System.out.println("[DEBUG] Total Revenue Calculated: " + totalcompletedRevenue);
        return totalcompletedRevenue;
    }
    public double calculateTotalPendingRevenue() throws SQLException {
        String sql = "SELECT SUM(payment_amount) AS totalPendingRevenue FROM payment WHERE payment_status = 'Pending'";

        double totalPendingRevenue = 0.0;

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                totalPendingRevenue = rs.getDouble("totalPendingRevenue");
            }
        }

        System.out.println("[DEBUG] Total Revenue Calculated: " + totalPendingRevenue);
        return totalPendingRevenue;
    }


}
