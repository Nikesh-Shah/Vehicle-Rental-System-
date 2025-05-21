package controller;

import dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Booking;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@WebServlet("/booking")
public class MyBookingsServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Received GET request at /booking");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            System.out.println("Session is invalid or user not logged in. Redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        int userId = (Integer) session.getAttribute("userId");
        System.out.println("Action: " + action + ", UserId: " + userId);

        try {
            if (action == null || "getByUserId".equals(action)) {
                System.out.println("Fetching bookings for userId: " + userId);
                List<Booking> bookings = bookingDAO.getBookingsByUserId(userId);
                Date today = new Date();
                List<Booking> currentBookings = new ArrayList<>();
                List<Booking> previousBookings = new ArrayList<>();

                for (Booking booking : bookings) {
                    System.out.println("Checking booking: " + booking.getBookingId());
                    if ("Cancelled".equalsIgnoreCase(booking.getStatus()) ||
                            (booking.getEndDate() != null && booking.getEndDate().before(today))) {
                        System.out.println("Booking is previous.");
                        previousBookings.add(booking);
                    } else {
                        System.out.println("Booking is current.");
                        currentBookings.add(booking);
                    }
                }

                request.setAttribute("currentBookings", currentBookings);
                request.setAttribute("previousBookings", previousBookings);
            } else {
                System.out.println("Invalid action passed: " + action);
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                return;
            }
        } catch (SQLException e) {
            System.err.println("SQLException in doGet: " + e.getMessage());
            throw new ServletException("Database error", e);
        }

        System.out.println("Forwarding to my-bookings.jsp");
        request.getRequestDispatcher("/WEB-INF/view/my-bookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Received POST request at /booking");

        String action = request.getParameter("action");
        String bookingIdParam = request.getParameter("bookingId");

        System.out.println("Action: " + action + ", bookingIdParam: " + bookingIdParam);

        if (bookingIdParam == null || bookingIdParam.isEmpty()) {
            System.out.println("Booking ID is missing.");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Booking ID is missing.");
            return;
        }

        int bookingId = Integer.parseInt(bookingIdParam);

        try {
            boolean success = false;

            if ("cancel".equals(action)) {
                System.out.println("Cancelling booking with ID: " + bookingId);
                success = bookingDAO.cancelBookingByUser(bookingId);
            } else if ("delete".equals(action)) {
                System.out.println("Deleting booking with ID: " + bookingId);
                success = bookingDAO.deleteBooking(bookingId);
            } else if ("update".equals(action)) {
                System.out.println("Updating booking with ID: " + bookingId);
                String newStart = request.getParameter("startDate");
                String newEnd = request.getParameter("endDate");

                if (newStart == null || newEnd == null) {
                    System.out.println("Missing new start or end date.");
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing new dates.");
                    return;
                }

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date newStartDate = sdf.parse(newStart);
                Date newEndDate = sdf.parse(newEnd);

                System.out.println("New Start Date: " + newStartDate + ", New End Date: " + newEndDate);

                bookingDAO.updateBookingDatesAndPayment(bookingId, newStartDate, newEndDate);
                success = true;
            } else {
                System.out.println("Unknown action: " + action);
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action: " + action);
                return;
            }

            if (success) {
                System.out.println("Action '" + action + "' successful. Redirecting to /booking.");
                response.sendRedirect(request.getContextPath() + "/booking");
            } else {
                System.out.println("Failed to process booking action: " + action);
                response.getWriter().write("Failed to process booking action.");
            }

        } catch (Exception e) {
            System.err.println("Exception in doPost: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error: " + e.getMessage());
        }
    }
}
