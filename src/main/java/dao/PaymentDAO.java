package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Payment;
import model.Vehicle;
import util.DbConnectionUtil;
public class PaymentDAO {
    // Constants for our COD-only system
    public static final String COD_METHOD = "COD";
    public static final String STATUS_PENDING = "Pending";
    public static final String STATUS_COMPLETED = "Completed";

    /**
     * Create a new COD payment record
     */
    public int createCODPayment(int bookingId, double amount) throws SQLException {
        String sql = "INSERT INTO payment (payment_date, payment_amount, payment_method, payment_status) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setDate(1, new java.sql.Date(System.currentTimeMillis()));
            stmt.setDouble(2, amount);
            stmt.setString(3, COD_METHOD);
            stmt.setString(4, STATUS_PENDING);

            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
            return 0;
        }
    }


    public boolean linkPaymentToBooking(int bookingId, int paymentId) throws SQLException {
        String sql = "UPDATE user_booking SET paymentId = ? WHERE bookingId = ?";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, paymentId);
            stmt.setInt(2, bookingId);
            return stmt.executeUpdate() > 0;
        }
    }


    public boolean updatePaymentStatus(int paymentId, String status) throws SQLException {
        String sql = "UPDATE payment SET payment_status = ? WHERE paymentId = ?";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, paymentId);
            return stmt.executeUpdate() > 0;
        }
    }


    public List<Payment> getPendingCODPayments() throws SQLException {
        String sql = "SELECT * FROM payment WHERE payment_method = ? AND payment_status = ?";
        List<Payment> payments = new ArrayList<>();

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, COD_METHOD);
            stmt.setString(2, STATUS_PENDING);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Payment payment = new Payment();
                    payment.setPaymentId(rs.getInt("paymentId"));
                    payment.setPaymentDate(rs.getDate("payment_date"));
                    payment.setAmount(rs.getDouble("payment_amount"));
                    payment.setMethod(rs.getString("payment_method"));
                    payment.setStatus(rs.getString("payment_status"));
                    payments.add(payment);
                }
            }
        }
        return payments;
    }
    public List<Payment> getAllPayments(int limit, int offset) throws SQLException {
        String sql = "SELECT * FROM payment LIMIT ? OFFSET ?";
        List<Payment> payments = new ArrayList<>();
        try (Connection conn = DbConnectionUtil.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                   Payment payment = new Payment();
                   payment.setPaymentId(rs.getInt("paymentId"));
                   payment.setPaymentDate(rs.getDate("payment_date"));
                   payment.setAmount(rs.getDouble("payment_amount"));
                   payment.setMethod(rs.getString("payment_method"));
                   payment.setStatus(rs.getString("payment_status"));
                   payments.add(payment);

                }
            }
        }
        return payments;
    }


}