package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Category;
import model.Vehicle;
import service.AdminService;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@WebServlet(name = "AdminVehicleServlet", value = "/admin-vehicles")
@MultipartConfig
public class AdminVehicleServlet extends HttpServlet {
    private static final int DEFAULT_PAGE_SIZE = 10;
    private AdminService adminService;

    @Override
    public void init() {
        this.adminService = new AdminService();
        System.out.println("AdminVehicleServlet initialized.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String vehicleIdParam = request.getParameter("vehicleId");

        try {
            System.out.println("[DEBUG] doGet called with action="
                    + action + ", vehicleId=" + vehicleIdParam);
            if ("edit".equals(action)) {
                showEditPage(request, response);
                return;
            }else if ("add".equals(action)) {
                List<Category> categories = adminService.getCategories();
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("/WEB-INF/view/admin/admin-add-vehicle.jsp")
                        .forward(request, response);
                return;
            }


            int page = getPageNumber(request);
            System.out.println("GET request received. Page: " + page);
            showVehicles(request, response, page);
        } catch (Exception e) {
            System.out.println("Exception in doGet: " + e.getMessage());
            handleError(request, response, e);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                addVehicle(request, response);
                return;
            }
            if ("delete".equals(action)) {
                deleteVehicle(request, response);
                return;
            }
            if ("update".equals(action)) {
                Vehicle vehicle = createVehicleFromRequest(request);

                String idStr = request.getParameter("vehicleId");
                if (idStr == null || !idStr.matches("\\d+"))
                    throw new IllegalArgumentException("Invalid vehicle ID.");
                vehicle.setVehicleId(Integer.parseInt(idStr));

                adminService.updateVehicle(vehicle);

                response.sendRedirect(request.getContextPath() + "/admin-vehicles");
                return;
            }

            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Unknown action: " + action);

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());

        } catch (Exception e) {
            e.printStackTrace();
            handleError(request, response, e);
        }
    }


    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        updateVehicle(request, response);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        deleteVehicle(request, response);
    }

    private void showVehicles(HttpServletRequest request, HttpServletResponse response, int page)
            throws ServletException, IOException {
        List<Vehicle> vehicles = adminService.getVehicles(page, DEFAULT_PAGE_SIZE);
        List<Category> categories = adminService.getCategories();
        System.out.println("Loaded " + vehicles.size() + " vehicles and " + categories.size() + " categories.");
        request.setAttribute("vehicles", vehicles);
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("/WEB-INF/view/admin/admin-vehicles.jsp").forward(request, response);
    }


    private void addVehicle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Vehicle vehicle = createVehicleFromRequest(request);
            int vehicleId = adminService.addVehicle(vehicle);
            if (vehicleId > 0) {
                response.sendRedirect(request.getContextPath() + "/admin-vehicles");
            } else {
                throw new IllegalArgumentException("Failed to add vehicle.");
            }
        } catch (IllegalArgumentException e) {
            handleError(request, response, e);
        }
    }


    private void updateVehicle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            System.out.println("Updating vehicle...");
            Vehicle vehicle = createVehicleFromRequest(request);
            String vehicleIdStr = request.getParameter("vehicleId");

            if (vehicleIdStr == null || !vehicleIdStr.matches("\\d+")) {
                throw new IllegalArgumentException("Invalid vehicle ID.");
            }

            vehicle.setVehicleId(Integer.parseInt(vehicleIdStr));
            boolean success = adminService.updateVehicle(vehicle);
            String message = success ? "Vehicle updated successfully." : "Failed to update vehicle.";
            System.out.println("Update result: " + message);

            response.setContentType("application/json");
            response.getWriter().write("{\"success\": " + success + ", \"message\": \"" + message + "\"}");
        } catch (IllegalArgumentException e) {
            System.out.println("Validation error during update: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }

    private void deleteVehicle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String vehicleIdStr = request.getParameter("vehicleId");

            if (vehicleIdStr == null || !vehicleIdStr.matches("\\d+")) {
                throw new IllegalArgumentException("Invalid vehicle ID.");
            }

            int vehicleId = Integer.parseInt(vehicleIdStr);
            boolean success = adminService.deleteVehicle(vehicleId);
            String message = success ? "Vehicle deleted successfully." : "Failed to delete vehicle.";

            response.setContentType("application/json");
            response.getWriter().write("{\"success\": " + success + ", \"message\": \"" + message + "\"}");
        } catch (IllegalArgumentException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }


    private Vehicle createVehicleFromRequest(HttpServletRequest request) throws IOException, ServletException {
        System.out.println("Extracting vehicle data from request...");
        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        String priceStr = request.getParameter("price");
        String status = request.getParameter("status");
        String quantityStr = request.getParameter("quantity");
        String categoryIdStr = request.getParameter("categoryId");

        System.out.println("Received: brand=" + brand + ", model=" + model + ", price=" + priceStr + ", status=" + status + ", Quantity="+quantityStr+", categoryId=" + categoryIdStr);

        if (brand == null || brand.isEmpty() ||
                model == null || model.isEmpty() ||
                priceStr == null || !priceStr.matches("\\d+(\\.\\d+)?") ||
                status == null || status.isEmpty() ||
                quantityStr == null || !quantityStr.matches("\\d+(\\.\\d+)?") ||
                categoryIdStr == null || !categoryIdStr.matches("\\d+")) {
            throw new IllegalArgumentException("Missing or invalid input data.");
        }

        Part imagePart = request.getPart("image");
        String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
        System.out.println("Uploaded image file: " + fileName);

// Get the real path to the webapp/uploads directory
        String uploadPath = request.getServletContext().getRealPath("/uploads");

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdirs();
            System.out.println("Upload directory created: " + created);
        }

        String filePath = uploadPath + File.separator + fileName;
        imagePart.write(filePath);
        System.out.println("File saved to: " + filePath);

        Vehicle vehicle = new Vehicle();
        vehicle.setBrand(brand);
        vehicle.setModel(model);
        vehicle.setPricePerDay(Double.parseDouble(priceStr));
        vehicle.setStatus(status);
        vehicle.setCategoryId(Integer.parseInt(categoryIdStr));
        vehicle.setQuantity(Integer.parseInt(quantityStr));
        vehicle.setImage("uploads/" + fileName); // relative path for browser
        return vehicle;

    }

    private int getPageNumber(HttpServletRequest request) {
        String pageParam = request.getParameter("page");
        try {
            return (pageParam != null && pageParam.matches("\\d+")) ? Integer.parseInt(pageParam) : 1;
        } catch (NumberFormatException e) {
            System.out.println("Invalid page parameter: " + pageParam);
            return 1;
        }
    }
    private void getVehicleForUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String vehicleIdStr = request.getParameter("vehicleId");
            if (vehicleIdStr == null || !vehicleIdStr.matches("\\d+")) {
                throw new IllegalArgumentException("Invalid vehicle ID.");
            }

            int vehicleId = Integer.parseInt(vehicleIdStr);
            Vehicle vehicle = adminService.getVehicleById(vehicleId);
            if (vehicle == null) {
                throw new IllegalArgumentException("Vehicle not found.");
            }

            request.setAttribute("vehicle", vehicle);
            List<Category> categories = adminService.getCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/view/admin/admin-vehicle-update-popup.jsp").forward(request, response);
        } catch (Exception e) {
            handleError(request, response, e);
        }
    }


    private void handleError(HttpServletRequest request, HttpServletResponse response,
                             Exception e) throws ServletException, IOException {
        System.out.println("Error occurred: " + e.getMessage());
        e.printStackTrace();
        request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
        request.getRequestDispatcher("/WEB-INF/view/admin/admin-error.jsp").forward(request, response);
    }
    private void showEditPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("vehicleId");
        if (idStr == null || !idStr.matches("\\d+")) {
            throw new IllegalArgumentException("Invalid vehicle ID.");
        }
        int id = Integer.parseInt(idStr);

        Vehicle vehicle = adminService.getVehicleById(id);
        if (vehicle == null) {
            throw new IllegalArgumentException("Vehicle not found.");
        }

        List<Category> categories = adminService.getCategories();
        request.setAttribute("vehicle", vehicle);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/view/admin/admin-vehicle-edit.jsp")
                .forward(request, response);
    }


}