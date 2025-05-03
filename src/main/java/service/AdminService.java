package service;

import dao.AdminDAO;
import dao.BookingDAO;
import model.*;


import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class AdminService {
    private final AdminDAO adminDAO;
    private final VehicleService vehicleService;
    private final BookingService bookingService;
    private final AuthService userService;
    private final CategoryService categoryService;
    private final PaymentService paymentService;

    public AdminService() {
        this.adminDAO = new AdminDAO();
        this.vehicleService = new VehicleService();
        this.bookingService = new BookingService();
        this.userService = new AuthService();
        this.categoryService = new CategoryService();
        this.paymentService = new PaymentService();
    }

    // Dashboard
    public Map<String, Object> getDashboardStats() {
        try {
            return adminDAO.getDashboardStatistics();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to load dashboard stats", e);
        }
    }

    // User Management
    public List<User> getUsers(int page, int pageSize) {
        try {
            return adminDAO.getAllUsers(pageSize, (page - 1) * pageSize);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to fetch users", e);
        }
    }

    public boolean updateUserRole(int userId, int newRole) {
        try {
            return adminDAO.updateUserRole(userId, newRole);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to update user role", e);
        }
    }

    // Booking Management
    public List<Booking> getBookings(int page, int pageSize) {
        try {
            return adminDAO.getAllBookings(pageSize, (page - 1) * pageSize);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to fetch bookings", e);
        }
    }

    public boolean updateBookingStatus(int bookingId, String status) throws SQLException {
        return BookingDAO.updateBookingStatus(bookingId, status);
    }

    // Vehicle Management
    public List<Vehicle> getVehicles(int page, int pageSize) {
        return vehicleService.getAllVehicles(pageSize, (page - 1) * pageSize);
    }

    public int addVehicle(Vehicle vehicle) {
        return vehicleService.addVehicle(vehicle);
    }

    public boolean updateVehicle(Vehicle vehicle) {
        return vehicleService.updateVehicle(vehicle);
    }

    public boolean deleteVehicle(int vehicleId) {
        return vehicleService.deleteVehicle(vehicleId);
    }

    // Category Management
    public List<Category> getCategories() {
        return categoryService.getAllCategories();
    }

    public boolean addCategory(Category category) {
        return categoryService.addCategory(category) > 0;
    }

    public boolean updateCategory(Category category) {
        return categoryService.updateCategory(category);
    }

    public boolean deleteCategory(int categoryId) {
        return categoryService.deleteCategory(categoryId);
    }

    // Payment Management
    public List<Payment> getPayments(int page, int pageSize) {
        try {
            return adminDAO.getAllPayments(pageSize, (page - 1) * pageSize);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to fetch payments", e);
        }
    }
}