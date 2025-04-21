package dao;

import model.User;
import util.DbConnectionUtil;
import java.sql.*;

public class UserDAO {
    private static final String TABLE_NAME = "users";


    public static int createUser(User user) throws SQLException {
        String sql = "INSERT INTO users (fname, lname, email, password, role, phone) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getFname());
            ps.setString(2, user.getLname());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());
            ps.setInt(5, user.getRole());
            ps.setString(6, user.getPhone());

            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                } else {
                    throw new SQLException("Creating user failed, no ID obtained.");
                }
            }
        }
    }

    // Get user by email
    public static User getUserByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("user_id"),
                            rs.getString("fname"),
                            rs.getString("lname"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getInt("role"),
                            rs.getString("phone")
                    );
                }
            }
        }
        return null;
    }

    // Check if email exists
    public static boolean emailExists(String email) throws SQLException {
        String sql = "SELECT 1 FROM " + TABLE_NAME + " WHERE email = ? LIMIT 1";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }
}