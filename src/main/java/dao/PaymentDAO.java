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

}