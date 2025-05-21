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
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        int userId = (Integer) session.getAttribute("userId");

        try {
            if (action == null || "getByUserId".equals(action)) {
                List<Booking> bookings = bookingDAO.getBookingsByUserId(userId);
                Date today = new Date();
                List<Booking> currentBookings = new ArrayList<>();
                List<Booking> previousBookings = new ArrayList<>();

                for (Booking booking : bookings) {
                    if (booking.getEndDate() != null && booking.getEndDate().before(today)) {
                        previousBookings.add(booking);
                    } else {
                        currentBookings.add(booking);
                    }
                }

                request.setAttribute("currentBookings", currentBookings);
                request.setAttribute("previousBookings", previousBookings);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                return;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }

        request.getRequestDispatcher("/WEB-INF/view/my-bookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String bookingIdParam = request.getParameter("bookingId");

        if (bookingIdParam == null || bookingIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Booking ID is missing.");
            return;
        }

        int bookingId = Integer.parseInt(bookingIdParam);

        try {
            boolean success = false;

            if ("cancel".equals(action)) {
                success = bookingDAO.cancelBookingByUser(bookingId);
            } else if ("delete".equals(action)) {
                success = bookingDAO.deleteBooking(bookingId);
            } else if ("update".equals(action)) {
                String newStart = request.getParameter("startDate");
                String newEnd = request.getParameter("endDate");

                if (newStart == null || newEnd == null) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing new dates.");
                    return;
                }

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date newStartDate = sdf.parse(newStart);
                Date newEndDate = sdf.parse(newEnd);

                bookingDAO.updateBookingDatesAndPayment(bookingId, newStartDate, newEndDate);
                success = true;
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action: " + action);
                return;
            }

            if (success) {
                response.sendRedirect(request.getContextPath() + "/booking");
            } else {
                response.getWriter().write("Failed to process booking action.");
            }

        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
