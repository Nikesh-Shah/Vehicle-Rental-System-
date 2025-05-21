package controller;

import dao.VehicleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Vehicle;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/rent-form")
public class RentFormServlet extends HttpServlet {
    private VehicleDAO vehicleDAO = new VehicleDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            System.out.println("[DEBUG] No session or userId; redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        System.out.println("RentFormServlet: doGet() called");

        // Retrieve the vehicle ID from the request parameter and log it
        String vehicleIdParam = request.getParameter("vehicleId");
        System.out.println("Vehicle ID parameter: " + vehicleIdParam);

        try {
            int vehicleId = Integer.parseInt(vehicleIdParam);
            System.out.println("Parsed Vehicle ID: " + vehicleId);

            // Attempt to fetch the vehicle and log the attempt
            System.out.println("Fetching vehicle details from database...");
            Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);
            System.out.println("Vehicle fetched: " + vehicle);

            // Set the vehicle attribute and forward to JSP
            request.setAttribute("vehicle", vehicle);
            System.out.println("Forwarding to rentForm.jsp...");
            request.getRequestDispatcher("/WEB-INF/view/rentForm.jsp").forward(request, response);
            System.out.println("Forwarding complete.");

        } catch (NumberFormatException e) {
            System.out.println("Error: Vehicle ID is not a valid integer: " + vehicleIdParam);
            e.printStackTrace();
            throw new ServletException("Invalid vehicle ID format.", e);
        } catch (SQLException e) {
            System.out.println("Error loading vehicle details from the database.");
            e.printStackTrace();
            throw new ServletException("Error loading vehicle details", e);
        } catch (Exception e) {
            System.out.println("Unexpected error occurred.");
            e.printStackTrace();
            throw new ServletException("An unexpected error occurred.", e);
        }
    }
}
