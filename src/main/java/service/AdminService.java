package service;

import dao.AdminDAO;
import dao.BookingDAO;
import dao.UserDAO;
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
    private final UserDAO userDAO;

    public AdminService() {
        this.adminDAO = new AdminDAO();
        this.vehicleService = new VehicleService();
        this.bookingService = new BookingService();
        this.userService = new AuthService();
        this.categoryService = new CategoryService();
        this.paymentService = new PaymentService();
        this.userDAO = new UserDAO();

    }



    public List<User> getUsers(int page, int pageSize) {
        try {
            return adminDAO.getAllUsers(pageSize, (page - 1) * pageSize);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to fetch users", e);
        }
    }


    public int getTotalUsers() {
        try {
            return adminDAO.countUsers();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to count users", e);
        }
    }
    public int getTotalBookings() {
        try {
            return adminDAO.countBookings();
        }catch (SQLException e){
            throw new RuntimeException("Failed to count bookings", e);

        }
    }
    public int getTotalVehicles(){
        try {
            return adminDAO.countVehicle();
        }catch (SQLException e){

            throw new RuntimeException("Failed to count vehicles", e);
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

//    public boolean updateBookingStatus(int bookingId, String status) throws SQLException {
//        return BookingDAO.updateBookingStatus(bookingId, status);
//    }

    // Vehicle Management
    public List<Vehicle> getVehicles(int page, int pageSize) {
        return vehicleService.getAllVehicles();
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
    public Vehicle getVehicleById(int vehicleId) {
        return vehicleService.getVehicleById(vehicleId);
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
//    public List<Payment> getPayments(int page, int pageSize) {
//        try {
//            return adminDAO.getAllPayments(pageSize, (page - 1) * pageSize);
//        } catch (SQLException e) {
//            throw new RuntimeException("Failed to fetch payments", e);
//        }
//    }
    public boolean deleteUser(int userId) {
        return userDAO.deleteUserById(userId);
    }

    public List<Booking> getRecentBookings(int limit) {
        try {
            return adminDAO.getRecentBookings(limit);
        }catch (SQLException e){
            throw new RuntimeException("Failed to fetch recent bookings", e);
        }
    }
}