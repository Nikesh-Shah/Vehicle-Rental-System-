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

        // Step 1: Validate the session and user
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            System.out.println("[DEBUG] No active session found or user not logged in. Redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Step 2: Retrieve the user ID from the session
        int userId = (int) session.getAttribute("userId");
        System.out.println("[DEBUG] User ID retrieved from session: " + userId);

        // Step 3: Retrieve parameters from the request
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

            // Step 4: Create booking
            System.out.println("[DEBUG] Creating booking...");
            Booking booking = new Booking();
            booking.setStartDate(startDate);
            booking.setEndDate(endDate);
            booking.setTotalAmount(total);
            booking.setStatus("Confirmed");

            int bookingId = bookingDAO.createBooking(booking);
            System.out.println("[DEBUG] Booking created with ID: " + bookingId);

            // Step 5: Link entities
            System.out.println("[DEBUG] Linking booking to user and vehicle...");
            bookingDAO.linkUserToBooking(bookingId, userId);
            System.out.println("[DEBUG] User linked to booking.");

            bookingDAO.addVehicleToBooking(bookingId, vehicleId);
            System.out.println("[DEBUG] Vehicle linked to booking.");

            // Step 6: Create payment
            System.out.println("[DEBUG] Creating payment entry...");
            paymentDAO.createPayment(bookingId, total);
            System.out.println("[DEBUG] Payment entry created.");

            // Step 7: Update vehicle status
            System.out.println("[DEBUG] Updating vehicle status to 'Booked'...");
            vehicleDAO.updateVehicleStatus(vehicleId, "Booked");
            System.out.println("[DEBUG] Vehicle status updated successfully.");

            // Step 8: Redirect to confirmation page
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
