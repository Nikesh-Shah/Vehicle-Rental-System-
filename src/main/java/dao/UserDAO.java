package dao;

import model.User;
import org.mindrot.jbcrypt.BCrypt;
import util.DbConnectionUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static util.DbConnectionUtil.getConnection;

public class UserDAO {

    public static int createUser(User user) throws SQLException {
        String sql = "INSERT INTO users (fname, lname, email, password, role, phone) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            System.out.println("[DEBUG] Database connection established for createUser");

            System.out.println("[DEBUG] Setting parameters for insert:");
            System.out.println("  fname: " + user.getFname());
            System.out.println("  lname: " + user.getLname());
            System.out.println("  email: " + user.getEmail());
            System.out.println("  password: " + user.getPassword());
            System.out.println("  role: " + user.getRole());
            System.out.println("  phone: " + user.getPhone());

            ps.setString(1, user.getFname());
            ps.setString(2, user.getLname());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());
            ps.setInt(5, user.getRole());
            ps.setString(6, user.getPhone());

            int affectedRows = ps.executeUpdate();
            System.out.println("[DEBUG] Rows affected: " + affectedRows);

            if (affectedRows == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    int userId = rs.getInt(1);
                    System.out.println("[DEBUG] Generated user ID: " + userId);
                    return userId;
                } else {
                    throw new SQLException("Creating user failed, no ID obtained.");
                }
            }
        }
    }

    public static User getUserByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        System.out.println("[DEBUG] Retrieving user by email: " + email);

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    System.out.println("[DEBUG] User found in database");
                    return new User(
                            rs.getInt("user_id"),
                            rs.getString("fname"),
                            rs.getString("lname"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getInt("role"),
                            rs.getString("phone")
                    );
                } else {
                    System.out.println("[DEBUG] No user found with that email");
                }
            }
        }
        return null;
    }
    public static boolean updateUser(User user) {
        String sql = "UPDATE users SET fname = ?, lname = ?, phone = ? WHERE user_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getFname());
            stmt.setString(2, user.getLname());
            stmt.setString(3, user.getPhone());
            stmt.setInt(4, user.getUserId());

            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }



    public static boolean emailExists(String email) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE email = ? LIMIT 1";
        System.out.println("[DEBUG] Checking if email exists: " + email);

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                boolean exists = rs.next();
                System.out.println("[DEBUG] Email exists: " + exists);
                return exists;
            }
        }
    }
    public static boolean updatePassword(String email, String password) throws SQLException {
        try (Connection conn = getConnection()) {
            String hashed = BCrypt.hashpw(password, BCrypt.gensalt());
            PreparedStatement ps = conn.prepareStatement("UPDATE users SET password = ? WHERE email = ?");
            ps.setString(1, hashed);
            ps.setString(2, email);

            int rowsAffected = ps.executeUpdate();
            System.out.println("[DEBUG] updatePassword: Rows affected = " + rowsAffected);
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean deleteUserById(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }




}
