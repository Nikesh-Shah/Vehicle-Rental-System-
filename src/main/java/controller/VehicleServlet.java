package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Vehicle;
import service.VehicleService;

import java.io.IOException;
import java.util.List;

@WebServlet(name ="VehicleServlet", value= "/vehicles")
public class VehicleServlet extends HttpServlet {
    private VehicleService vehicleService;

    @Override
    public void init() throws ServletException {
        vehicleService = new VehicleService();
        System.out.println("[DEBUG] VehicleService initialized.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Default pagination values
        int limit = 10;
        int offset = 0;

        // Get pagination parameters from the request
        try {
            String limitParam = request.getParameter("limit");
            String offsetParam = request.getParameter("offset");

            if (limitParam != null) {
                limit = Integer.parseInt(limitParam);
                System.out.println("[DEBUG] Pagination limit set to: " + limit);
            } else {
                System.out.println("[DEBUG] No limit parameter provided, using default: " + limit);
            }

            if (offsetParam != null) {
                offset = Integer.parseInt(offsetParam);
                System.out.println("[DEBUG] Pagination offset set to: " + offset);
            } else {
                System.out.println("[DEBUG] No offset parameter provided, using default: " + offset);
            }
        } catch (NumberFormatException e) {
            // Log error or handle invalid parameters
            System.err.println("[ERROR] Invalid pagination parameters.");
        }

        try {
            // Fetch vehicles from the service
            System.out.println("[DEBUG] Fetching vehicles from service with limit: " + limit + " and offset: " + offset);
            List<Vehicle> vehicles = vehicleService.getAllVehicles(limit, offset);
            System.out.println("[DEBUG] Retrieved " + vehicles.size() + " vehicles.");

            request.setAttribute("vehicles", vehicles);
            System.out.println("Vehicles list: " + vehicles);

            // Forward request to JSP
            request.getRequestDispatcher("/WEB-INF/view/vehicles.jsp").forward(request, response);
            System.out.println("[DEBUG] Request forwarded to vehicles.jsp.");
        } catch (Exception e) {
            // Handle any exceptions (e.g., database errors)
            System.err.println("[ERROR] Exception occurred while fetching vehicles: " + e.getMessage());
            request.setAttribute("errorMessage", "An error occurred while loading vehicles.");
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        }
    }
}
