package controller.admin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Category;
import model.User;
import model.Vehicle;
import service.AdminService;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet(name = "AdminVehicleServlet", value = "/admin/vehicles/*")
public class AdminVehicleServlet extends HttpServlet {
    private static final int DEFAULT_PAGE_SIZE = 10;
    private AdminService adminService;

    @Override
    public void init() {
        this.adminService = new AdminService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        try {
            int page = getPageNumber(request);
            showVehicles(request, response, page);
        } catch (Exception e) {
            handleError(request, response, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        try {
            String action = request.getPathInfo();
            if (action == null) {
                action = "/";
            }

            switch (action) {
                case "/add":
                    addVehicle(request, response);
                    break;
                case "/update":
                    updateVehicle(request, response);
                    break;
                case "/delete":
                    deleteVehicle(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            handleError(request, response, e);
        }
    }

    private void showVehicles(HttpServletRequest request, HttpServletResponse response, int page)
            throws ServletException, IOException {
        List<Vehicle> vehicles = adminService.getVehicles(page, DEFAULT_PAGE_SIZE);
        List<Category> categories = adminService.getCategories();
        request.setAttribute("vehicles", vehicles);
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("/admin-vehicles.jsp").forward(request, response);
    }

    private void addVehicle(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Vehicle vehicle = createVehicleFromRequest(request);
        int vehicleId = adminService.addVehicle(vehicle);
        boolean success = vehicleId > 0;
        redirectWithStatus(request, response, "/admin/vehicles", success,
                success ? "Vehicle added successfully with ID: " + vehicleId
                        : "Failed to add vehicle");
    }

    private void updateVehicle(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Vehicle vehicle = createVehicleFromRequest(request);
        vehicle.setVehicleId(Integer.parseInt(request.getParameter("vehicleId")));
        boolean success = adminService.updateVehicle(vehicle);
        redirectWithStatus(request, response, "/admin/vehicles", success, "Vehicle updated");
    }

    private void deleteVehicle(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
        boolean success = adminService.deleteVehicle(vehicleId);
        redirectWithStatus(request, response, "/admin/vehicles", success, "Vehicle deleted");
    }

    private Vehicle createVehicleFromRequest(HttpServletRequest request) {
        Vehicle vehicle = new Vehicle();
        vehicle.setBrand(request.getParameter("brand"));
        vehicle.setModel(request.getParameter("model"));
        vehicle.setPricePerDay(Double.parseDouble(request.getParameter("price")));
        vehicle.setStatus(request.getParameter("status"));
        vehicle.setImage(request.getParameter("image"));
        vehicle.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
        return vehicle;
    }

    // Utility methods
    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;
        return user != null && user.isAdmin();
    }

    private int getPageNumber(HttpServletRequest request) {
        String pageParam = request.getParameter("page");
        try {
            return pageParam != null ? Integer.parseInt(pageParam) : 1;
        } catch (NumberFormatException e) {
            return 1;
        }
    }

    private void redirectWithStatus(HttpServletRequest request, HttpServletResponse response,
                                    String path, boolean success, String successMessage)
            throws IOException {
        String param = success ? "success" : "error";
        String message = success ? successMessage : "Operation failed";
        response.sendRedirect(request.getContextPath() + path + "?" + param + "=" +
                URLEncoder.encode(message, StandardCharsets.UTF_8));
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response,
                             Exception e) throws ServletException, IOException {
        request.setAttribute("error", e.getMessage());
        request.getRequestDispatcher("/admin-error.jsp").forward(request, response);
    }
}