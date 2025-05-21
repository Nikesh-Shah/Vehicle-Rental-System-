package controller;

import dao.VehicleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Vehicle;


import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.List;
@WebServlet("/calculate-total")
public class BookingServlet extends HttpServlet {
    private VehicleDAO vehicleDAO = new VehicleDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
        Date startDate = Date.valueOf(request.getParameter("startDate"));
        Date endDate = Date.valueOf(request.getParameter("endDate"));

        System.out.println("[DEBUG] Received booking request");
        System.out.println("[DEBUG] Vehicle ID: " + vehicleId);
        System.out.println("[DEBUG] Start Date: " + startDate);
        System.out.println("[DEBUG] End Date: " + endDate);

        try {
            Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);
            System.out.println("[DEBUG] Vehicle fetched: " + vehicle);

//            if (!vehicleDAO.isVehicleAvailable(vehicleId, startDate, endDate)) {
//                System.out.println("[DEBUG] Vehicle is not available for the selected dates.");
//                request.setAttribute("error", "Vehicle is no longer available");
//                request.setAttribute("vehicle", vehicle);
//                request.getRequestDispatcher("/WEB-INF/view/rentForm.jsp").forward(request, response);
//                return;
//            }

            long days = ChronoUnit.DAYS.between(
                    startDate.toLocalDate(),
                    endDate.toLocalDate()
            );
            System.out.println("[DEBUG] Number of rental days: " + days);

            double total = vehicle.getPricePerDay() * days;
            System.out.println("[DEBUG] Total rental cost: NRs " + total);

            int reduceQuantity = 1;
            boolean isReduced = vehicleDAO.reduceVehicleQuantity(vehicleId, reduceQuantity);
            System.out.println("[DEBUG] Quantity reduced: " + isReduced);

            if (!isReduced) {
                System.out.println("[DEBUG] Quantity could not be reduced. Forwarding to rent form.");
                request.setAttribute("vehicle", vehicle);
                request.getRequestDispatcher("/WEB-INF/view/rentForm.jsp").forward(request, response);
                return;
            }

            System.out.println("[DEBUG] Booking processing successful. Forwarding to payment page.");

            request.setAttribute("vehicle", vehicle);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            request.setAttribute("total", total);
            request.getRequestDispatcher("/WEB-INF/view/payment.jsp").forward(request, response);

        } catch (SQLException e) {
            System.out.println("[ERROR] SQLException during booking process: " + e.getMessage());
            throw new ServletException("Error processing booking", e);
        }
    }
}
