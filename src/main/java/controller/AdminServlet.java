//package controller;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import model.*;
//import service.AdminService;
//
//import java.io.IOException;
//import java.net.URLEncoder;
//import java.nio.charset.StandardCharsets;
//import java.sql.SQLException;
//import java.util.List;
//import java.util.Map;
//
//@WebServlet(name = "AdminServlet", value = "/admin")
//public class AdminServlet extends HttpServlet {
//    private static final int DEFAULT_PAGE_SIZE = 10;
//    private AdminService adminService;
//
//    @Override
//    public void init() {
//        this.adminService = new AdminService();
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        if (!isAdmin(request)) {
//            response.sendError(HttpServletResponse.SC_FORBIDDEN);
//            return;
//        }
//
//        try {
//            String path = request.getPathInfo() != null ? request.getPathInfo() : "/";
//            int page = getPageNumber(request);
//
//            switch (path) {
//                case "/":
//                    showDashboard(request, response);
//                    break;
//                case "/users":
//                    showUsers(request, response, page);
//                    break;
//                case "/bookings":
//                    showBookings(request, response, page);
//                    break;
//                case "/vehicles":
//                    showVehicles(request, response, page);
//                    break;
//                case "/categories":
//                    showCategories(request, response);
//                    break;
//                case "/payments":
//                    showPayments(request, response, page);
//                    break;
//                case "/reports":
//                    showReports(request, response);
//                    break;
//                default:
//                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
//            }
//        } catch (Exception e) {
//            handleError(request, response, e);
//        }
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        if (!isAdmin(request)) {
//            response.sendError(HttpServletResponse.SC_FORBIDDEN);
//            return;
//        }
//
//        try {
//            String path = request.getPathInfo();
//
//            switch (path) {
//                case "/update-user":
//                    updateUserRole(request, response);
//                    break;
//                case "/update-booking":
//                    updateBookingStatus(request, response);
//                    break;
//                case "/add-vehicle":
//                    addVehicle(request, response);
//                    break;
//                case "/update-vehicle":
//                    updateVehicle(request, response);
//                    break;
//                case "/delete-vehicle":
//                    deleteVehicle(request, response);
//                    break;
//                case "/add-category":
//                    addCategory(request, response);
//                    break;
//                case "/update-category":
//                    updateCategory(request, response);
//                    break;
//                case "/delete-category":
//                    deleteCategory(request, response);
//                    break;
//                default:
//                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
//            }
//        } catch (Exception e) {
//            handleError(request, response, e);
//        }
//    }
//
//
//    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        Map<String, Object> stats = adminService.getDashboardStats();
//        request.setAttribute("stats", stats);
//        request.getRequestDispatcher("WEB-INF/view/admin/admin-dashboard.jsp").forward(request, response);
//    }
//
//    private void showUsers(HttpServletRequest request, HttpServletResponse response, int page)
//            throws ServletException, IOException {
//        List<User> users = adminService.getUsers(page, DEFAULT_PAGE_SIZE);
//        request.setAttribute("users", users);
//        request.setAttribute("currentPage", page);
//        request.getRequestDispatcher("WEB-INF/view/admin/admin-users.jsp").forward(request, response);
//    }
//
//    private void showBookings(HttpServletRequest request, HttpServletResponse response, int page)
//            throws ServletException, IOException {
//        List<Booking> bookings = adminService.getBookings(page, DEFAULT_PAGE_SIZE);
//        request.setAttribute("bookings", bookings);
//        request.setAttribute("currentPage", page);
//        request.getRequestDispatcher("/admin-bookings.jsp").forward(request, response);
//    }
//
//    private void showVehicles(HttpServletRequest request, HttpServletResponse response, int page)
//            throws ServletException, IOException {
//        List<Vehicle> vehicles = adminService.getVehicles(page, DEFAULT_PAGE_SIZE);
//        List<Category> categories = adminService.getCategories();
//        request.setAttribute("vehicles", vehicles);
//        request.setAttribute("categories", categories);
//        request.setAttribute("currentPage", page);
//        request.getRequestDispatcher("/admin-vehicles.jsp").forward(request, response);
//    }
//
//    private void showCategories(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        List<Category> categories = adminService.getCategories();
//        request.setAttribute("categories", categories);
//        request.getRequestDispatcher("/admin-categories.jsp").forward(request, response);
//    }
//
//    private void showPayments(HttpServletRequest request, HttpServletResponse response, int page)
//            throws ServletException, IOException {
//        List<Payment> payments = adminService.getPayments(page, DEFAULT_PAGE_SIZE);
//        request.setAttribute("payments", payments);
//        request.setAttribute("currentPage", page);
//        request.getRequestDispatcher("/admin-payments.jsp").forward(request, response);
//    }
//
//    private void showReports(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        Map<String, Object> stats = adminService.getDashboardStats();
//        request.setAttribute("stats", stats);
//        request.getRequestDispatcher("/admin-reports.jsp").forward(request, response);
//    }
//
//    // Helper methods for POST requests
//    private void updateUserRole(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//        int userId = Integer.parseInt(request.getParameter("userId"));
//        int newRole = Integer.parseInt(request.getParameter("role"));
//
//        boolean success = adminService.updateUserRole(userId, newRole);
//        redirectWithStatus(request, response, "/admin/users", success, "User role updated");
//    }
//
//    private void updateBookingStatus(HttpServletRequest request, HttpServletResponse response)
//            throws IOException, SQLException {
//        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
//        String status = request.getParameter("status");
//
//        boolean success = adminService.updateBookingStatus(bookingId, status);
//        redirectWithStatus(request, response, "/admin/bookings", success, "Booking status updated");
//    }
//
//    private void addVehicle(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//        Vehicle vehicle = createVehicleFromRequest(request);
//        int vehicleId = adminService.addVehicle(vehicle);
//        boolean success = vehicleId > 0;
//        redirectWithStatus(request, response, "/admin/vehicles", success,
//                success ? "Vehicle added successfully with ID: " + vehicleId
//                        : "Failed to add vehicle");
//    }
//
//    private void updateVehicle(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//        Vehicle vehicle = createVehicleFromRequest(request);
//        vehicle.setVehicleId(Integer.parseInt(request.getParameter("vehicleId")));
//        boolean success = adminService.updateVehicle(vehicle);
//        redirectWithStatus(request, response, "/admin/vehicles", success, "Vehicle updated");
//    }
//
//    private void deleteVehicle(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//        int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
//        boolean success = adminService.deleteVehicle(vehicleId);
//        redirectWithStatus(request, response, "/admin/vehicles", success, "Vehicle deleted");
//    }
//
//    private void addCategory(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//        Category category = createCategoryFromRequest(request);
//        boolean success = adminService.addCategory(category);
//        redirectWithStatus(request, response, "/admin/categories", success, "Category added");
//    }
//
//    private void updateCategory(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//        Category category = createCategoryFromRequest(request);
//        category.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
//        boolean success = adminService.updateCategory(category);
//        redirectWithStatus(request, response, "/admin/categories", success, "Category updated");
//    }
//
//    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
//        boolean success = adminService.deleteCategory(categoryId);
//        redirectWithStatus(request, response, "/admin/categories", success, "Category deleted");
//    }
//
//    // Utility methods
//    private boolean isAdmin(HttpServletRequest request) {
//        HttpSession session = request.getSession(false);
//        User user = session != null ? (User) session.getAttribute("user") : null;
//        return user != null && user.isAdmin();
//    }
//
//    private int getPageNumber(HttpServletRequest request) {
//        String pageParam = request.getParameter("page");
//        try {
//            return pageParam != null ? Integer.parseInt(pageParam) : 1;
//        } catch (NumberFormatException e) {
//            return 1;
//        }
//    }
//
//    private Vehicle createVehicleFromRequest(HttpServletRequest request) {
//        Vehicle vehicle = new Vehicle();
//        vehicle.setBrand(request.getParameter("brand"));
//        vehicle.setModel(request.getParameter("model"));
//        vehicle.setPricePerDay(Double.parseDouble(request.getParameter("price")));
//        vehicle.setStatus(request.getParameter("status"));
//        vehicle.setImage(request.getParameter("image"));
//        vehicle.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
//        return vehicle;
//    }
//
//    private Category createCategoryFromRequest(HttpServletRequest request) {
//        Category category = new Category();
//        category.setName(request.getParameter("name"));
//        category.setImage(request.getParameter("image"));
//        category.setDescription(request.getParameter("description"));
//        return category;
//    }
//
//    private void redirectWithStatus(HttpServletRequest request, HttpServletResponse response,
//                                    String path, boolean success, String successMessage)
//            throws IOException {
//        String param = success ? "success" : "error";
//        String message = success ? successMessage : "Operation failed";
//        response.sendRedirect(request.getContextPath() + path + "?" + param + "=" +
//                URLEncoder.encode(message, StandardCharsets.UTF_8));
//    }
//
//    private void handleError(HttpServletRequest request, HttpServletResponse response,
//                             Exception e) throws ServletException, IOException {
//        request.setAttribute("error", e.getMessage());
//        request.getRequestDispatcher("/admin-error.jsp").forward(request, response);
//    }
//}