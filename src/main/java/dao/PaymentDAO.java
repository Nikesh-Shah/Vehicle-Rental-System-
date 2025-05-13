package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Payment;
import model.Vehicle;
import util.DbConnectionUtil;
public class PaymentDAO {
    public void createPayment(int bookingId, double amount) throws SQLException {
        String sql = "INSERT INTO payment (payment_date, payment_amount, payment_method, payment_status) " +
                "VALUES (CURRENT_DATE, ?, 'COD', 'Pending')";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setDouble(1, amount);
            stmt.executeUpdate();
        }
    }
    public List<Payment> getAllPayments() throws SQLException {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM payment ORDER t ";

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
    public List<Payment> getRecentPayments() throws SQLException {
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



}