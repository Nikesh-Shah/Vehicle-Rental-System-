package service;

import dao.UserDAO;
import model.User;
import util.PasswordHashUtil;
import java.sql.SQLException;
import java.util.regex.Pattern;
import java.sql.Connection;
import util.DbConnectionUtil;
import java.sql.*;

public class AuthService {
    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    private static final int MIN_PASSWORD_LENGTH = 6;

    public static class AuthResult {
        private final boolean success;
        private final String message;
        private final User user;

        public AuthResult(boolean success, String message, User user) {
            this.success = success;
            this.message = message;
            this.user = user;
        }

        public boolean isSuccess() { return success; }
        public String getMessage() { return message; }
        public User getUser() { return user; }
    }

    // Register a new user
    public static AuthResult registerUser(String fname, String lname, String email,
                                          String password, String confirmPassword, String phone) {
        try {
            if (fname == null || fname.trim().isEmpty()) {
                return new AuthResult(false, "First name is required", null);
            }
            if (lname == null || lname.trim().isEmpty()) {
                return new AuthResult(false, "Last name is required", null);
            }
            if (email == null || email.trim().isEmpty()) {
                return new AuthResult(false, "Email is required", null);
            }
            if (!EMAIL_PATTERN.matcher(email).matches()) {
                return new AuthResult(false, "Invalid email format", null);
            }
            if (password == null || password.length() < MIN_PASSWORD_LENGTH) {
                return new AuthResult(false,
                        "Password must be at least " + MIN_PASSWORD_LENGTH + " characters", null);
            }
            if (UserDAO.emailExists(email)) {
                return new AuthResult(false, "Email already registered", null);
            }
            System.out.println("Registering user: " + fname + " " + lname);

            // Confirm password check
            if (!password.equals(confirmPassword)) {
                return new AuthResult(false, "Passwords do not match", null);
            }

            // Hash password and create user
            String hashedPassword = PasswordHashUtil.hashPassword(password);
            User user = new User(fname.trim(), lname.trim(), email.trim(),
                    hashedPassword, phone.trim());



            int userId = UserDAO.createUser(user);
            user.setUserId(userId);

            return new AuthResult(true, "Registration successful", user);
        } catch (SQLException e) {
            return new AuthResult(false, "Registration failed. Please try again.", null);
        }
    }


    // Authenticate user
    public static AuthResult authenticate(String email, String password) {
        try {
            if (email == null || email.trim().isEmpty()) {
                return new AuthResult(false, "Email is required", null);
            }
            if (password == null || password.isEmpty()) {
                return new AuthResult(false, "Password is required", null);
            }

            User user = UserDAO.getUserByEmail(email.trim());
            if (user == null) {
                return new AuthResult(false, "Invalid email or password", null);
            }

            if (!PasswordHashUtil.checkPassword(password, user.getPassword())) {
                return new AuthResult(false, "Invalid email or password", null);
            }

            return new AuthResult(true, "Login successful", user);
        } catch (SQLException e) {
            return new AuthResult(false, "Login failed. Please try again.", null);
        }
    }
    public static boolean updateUser(User user) {
        return UserDAO.updateUser(user);
    }


    public static User getUserByEmail(String email) throws SQLException {
        try {
            return UserDAO.getUserByEmail(email);
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    }



