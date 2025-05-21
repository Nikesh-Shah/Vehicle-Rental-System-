package controller;

import dao.BookingDAO;
import dao.PaymentDAO;
import dao.VehicleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Booking;

import java.sql.Date;
import java.sql.SQLException;
import java.io.IOException;
@WebServlet("/confirm-booking")
public class PaymentServlet extends HttpServlet {
    private BookingDAO bookingDAO = new BookingDAO();
    private PaymentDAO paymentDAO = new PaymentDAO();
    private VehicleDAO vehicleDAO = new VehicleDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("[DEBUG] PaymentServlet: doPost() called.");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            System.out.println("[DEBUG] No active session found or user not logged in. Redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        System.out.println("[DEBUG] User ID retrieved from session: " + userId);

        try {
            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
            Date startDate = Date.valueOf(request.getParameter("startDate"));
            Date endDate = Date.valueOf(request.getParameter("endDate"));
            double total = Double.parseDouble(request.getParameter("total"));

            System.out.println("[DEBUG] Parameters retrieved:");
            System.out.println("        Vehicle ID: " + vehicleId);
            System.out.println("        Start Date: " + startDate);
            System.out.println("        End Date: " + endDate);
            System.out.println("        Total Amount: " + total);

            System.out.println("[DEBUG] Creating booking...");
            Booking booking = new Booking();
            booking.setStartDate(startDate);
            booking.setEndDate(endDate);
            booking.setTotalAmount(total);
            booking.setStatus("Confirmed");

            int bookingId = bookingDAO.createBooking(booking);
            System.out.println("[DEBUG] Booking created with ID: " + bookingId);

            System.out.println("[DEBUG] Creating payment entry...");
            int paymentId = paymentDAO.createPayment(bookingId, total);
            System.out.println("[DEBUG] Payment entry created with ID: " + paymentId);

            System.out.println("[DEBUG] Linking booking to user and vehicle...");
            bookingDAO.linkUserToBooking(bookingId,vehicleId, userId, paymentId);
            System.out.println("[DEBUG] User linked to booking successfully.");

            int categoryId = vehicleDAO.getCategoryIdByVehicleId(vehicleId);
            bookingDAO.addVehicleToBooking(bookingId, vehicleId, categoryId,userId);
            System.out.println("[DEBUG] Vehicle linked to booking successfully.");

//            System.out.println("[DEBUG] Updating vehicle status to 'Booked'...");
//            vehicleDAO.updateVehicleStatus(vehicleId, "Booked");
//            System.out.println("[DEBUG] Vehicle status updated successfully.");
            System.out.println("[DEBUG] Checking vehicle availability before updating status...");
            int quantity = vehicleDAO.getVehicleQuantity(vehicleId);
            System.out.println("[DEBUG] Current quantity: " + quantity);

            if (quantity <= 0) {
                System.out.println("[DEBUG] Quantity is 0. Updating vehicle status to 'Booked'...");
                vehicleDAO.updateVehicleStatus(vehicleId, "Booked");
            } else {
                System.out.println("[DEBUG] Quantity is still available. Skipping status update.");
            }


            System.out.println("[DEBUG] Redirecting to confirmation.jsp...");
            request.getRequestDispatcher("/WEB-INF/view/confirmation.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.out.println("[ERROR] Invalid number format in request parameters.");
            e.printStackTrace();
            throw new ServletException("Invalid input format.", e);

        } catch (IllegalArgumentException e) {
            System.out.println("[ERROR] Invalid date format or null value in date parsing.");
            e.printStackTrace();
            throw new ServletException("Invalid date format or missing date value.", e);

        } catch (SQLException e) {
            System.out.println("[ERROR] Database error occurred.");
            e.printStackTrace();
            throw new ServletException("Database error.", e);

        } catch (Exception e) {
            System.out.println("[ERROR] Unexpected error occurred.");
            e.printStackTrace();
            throw new ServletException("An unexpected error occurred.", e);
        }
    }
}
