package controller;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Booking;
import model.User;
import service.BookingService;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/bookings")
public class BookingServlet extends HttpServlet {
    private BookingService bookingService;

    @Override
    public void init() {
        this.bookingService = new BookingService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String action = request.getParameter("action");

            if (action == null) {
                // Show user's bookings
                List<Booking> bookings = bookingService.getUserBookings(user.getUserId());
                request.setAttribute("bookings", bookings);
                request.getRequestDispatcher("/my-bookings.jsp").forward(request, response);
            }
            else if ("details".equals(action)) {
                // Show booking details
                int bookingId = Integer.parseInt(request.getParameter("id"));
                Booking booking = bookingService.getBookingById(bookingId);

                if (booking != null && booking.getUserId() == user.getUserId()) {
                    request.setAttribute("booking", booking);
                    request.getRequestDispatcher("/booking-details.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String action = request.getParameter("action");

            if ("create".equals(action)) {
                // Create new booking
                String[] vehicleIds = request.getParameterValues("vehicleIds");
                String startDateStr = request.getParameter("startDate");
                String endDateStr = request.getParameter("endDate");

                Date startDate = (Date) new SimpleDateFormat("yyyy-MM-dd").parse(startDateStr);
                Date endDate = (Date) new SimpleDateFormat("yyyy-MM-dd").parse(endDateStr);

                List<Integer> ids = Arrays.stream(vehicleIds)
                        .map(Integer::parseInt)
                        .collect(Collectors.toList());

                Booking booking = bookingService.createBooking(
                        user.getUserId(), ids, startDate, endDate);

                if (booking != null) {
                    response.sendRedirect("bookings?action=details&id=" + booking.getBookingId());
                } else {
                    throw new RuntimeException("Failed to create booking");
                }
            }
            else if ("cancel".equals(action)) {
                // Cancel booking
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                boolean success = bookingService.cancelBooking(bookingId, user.getUserId());

                if (success) {
                    response.sendRedirect("bookings?cancelSuccess=true");
                } else {
                    throw new RuntimeException("Failed to cancel booking");
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/booking-error.jsp").forward(request, response);
        }
    }
}
