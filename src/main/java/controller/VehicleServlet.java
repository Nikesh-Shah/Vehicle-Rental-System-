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

@WebServlet(name = "VehicleServlet", value = "/vehicles")
public class VehicleServlet extends HttpServlet {
    private VehicleService vehicleService;

    @Override
    public void init() throws ServletException {
        vehicleService = new VehicleService();
        System.out.println("[DEBUG] VehicleService initialized.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the search query parameter
            String query = request.getParameter("query");

            // Initialize the list of vehicles
            List<Vehicle> vehicles;

            if (query != null && !query.trim().isEmpty()) {
                // If search query is provided, search for matching vehicles
                System.out.println("[DEBUG] Searching vehicles with query: " + query);
                vehicles = vehicleService.searchVehicles(query);
            } else {
                // If no search query, fetch all vehicles
                System.out.println("[DEBUG] Fetching all vehicles.");
                vehicles = vehicleService.getAllVehicles();
            }

            System.out.println("[DEBUG] Retrieved " + vehicles.size() + " vehicles.");
            request.setAttribute("vehicles", vehicles);

            // Forward request to JSP
            request.getRequestDispatcher("/WEB-INF/view/vehicles.jsp").forward(request, response);
            System.out.println("[DEBUG] Request forwarded to vehicles.jsp.");
        } catch (Exception e) {
            System.err.println("[ERROR] Exception occurred while fetching vehicles: " + e.getMessage());
            request.setAttribute("errorMessage", "An error occurred while loading vehicles.");
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        }
    }
}
