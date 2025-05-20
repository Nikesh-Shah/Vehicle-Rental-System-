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

        try {
            Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);

            if(!vehicleDAO.isVehicleAvailable(vehicleId, startDate, endDate)) {
                request.setAttribute("error", "Vehicle is no longer available");
                request.setAttribute("vehicle", vehicle);
                request.getRequestDispatcher("/WEB-INF/view/rentForm.jsp").forward(request, response);
                return;
            }

            long days = ChronoUnit.DAYS.between(
                    startDate.toLocalDate(),
                    endDate.toLocalDate()
            );
            double total = vehicle.getPricePerDay() * days;
            int reduceQuantity=1;
            boolean isReduced = vehicleDAO.reduceVehicleQuantity(vehicleId, reduceQuantity);

            if(!isReduced) {
                request.setAttribute("vehicle", vehicle);
                request.getRequestDispatcher("/WEB-INF/view/rentForm.jsp").forward(request, response);
                return;
            }

            request.setAttribute("vehicle", vehicle);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            request.setAttribute("total", total);
            request.getRequestDispatcher("/WEB-INF/view/payment.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error processing booking", e);
        }
    }
}