package controller;

import dao.VehicleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import model.Vehicle;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;


@WebServlet("/feature")
public class FeatureProductServlet extends HttpServlet {
    private VehicleDAO vehicleDAO;
    private Map<Category, Vehicle> categoryVehicleMap;

    @Override
    public void init() throws ServletException {
        vehicleDAO = new VehicleDAO();
        try {
            categoryVehicleMap = vehicleDAO.getOneVehicle();
            getServletContext().setAttribute("categoryVehicleMap", categoryVehicleMap);
            System.out.println("Category-Vehicle Map Initialized and stored in ServletContext: " + categoryVehicleMap);
        } catch (SQLException e) {
            System.out.println("Error in initializing ServletContext: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error initializing Category-Vehicle Map.", e);
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("[DEBUG] Attempting to fetch vehicles from database...");

        request.setAttribute("categoryVehicleMap", categoryVehicleMap);

        System.out.println("[DEBUG] Forwarding to index.jsp");
        request.getRequestDispatcher("/WEB-INF/view/featuredproduct.jsp").forward(request, response);
        System.out.println("[DEBUG] Forwarding done successfully!");

    }}



