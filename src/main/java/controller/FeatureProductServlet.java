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
import java.util.Map;


@WebServlet("/feature")
public class FeatureProductServlet extends HttpServlet {
    private VehicleDAO vehicleDAO;

    @Override
    public void init(){
        vehicleDAO = new VehicleDAO();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            System.out.println("[DEBUG] Attempting to fetch vehicles from database...");

            Map<Category, Vehicle> categoryVehicleMap = vehicleDAO.getOneVehicle();

            if (categoryVehicleMap == null || categoryVehicleMap.isEmpty()) {
                System.out.println("[DEBUG] categoryVehicleMap is EMPTY!");
            } else {
                System.out.println("[DEBUG] categoryVehicleMap fetched successfully:");
                categoryVehicleMap.forEach((categoryId, vehicle) ->
                        System.out.println("Category ID: " + categoryId + " | Vehicle: " + vehicle.getBrand() + " " + vehicle.getModel())
                );
            }

            request.setAttribute("categoryVehicleMap", categoryVehicleMap);

            System.out.println("[DEBUG] Forwarding to index.jsp");
            request.getRequestDispatcher("/WEB-INF/view/featuredproduct.jsp").forward(request, response);
            System.out.println("[DEBUG] Forwarding done successfully!");

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }}



