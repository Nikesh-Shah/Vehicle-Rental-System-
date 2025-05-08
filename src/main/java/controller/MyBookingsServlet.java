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
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/my-bookings")
public class MyBookingsServlet extends HttpServlet {
    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("[DEBUG] MyBookingsServlet: doGet() called");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            System.out.println("[DEBUG] No session or userId; redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        System.out.println("[DEBUG] Retrieved userId from session: " + userId);

        try {
            List<Booking> allBookings = bookingDAO.getBookingsByUserId(userId);
            System.out.println("[DEBUG] Retrieved " + allBookings.size() + " bookings from DAO");

            LocalDate today = LocalDate.now();
            List<Booking> current = new ArrayList<>();
            List<Booking> previous = new ArrayList<>();

            for (Booking booking : allBookings) {
                System.out.println("[DEBUG] Checking booking: " + booking);

                // Wrap in java.sql.Date to get toLocalDate()
                LocalDate endLocal = new java.sql.Date(
                        booking.getEndDate().getTime()
                ).toLocalDate();

                System.out.println("[DEBUG]   End date as LocalDate: " + endLocal);
                if (endLocal.isBefore(today)) {
                    System.out.println("[DEBUG]   → Past");
                    previous.add(booking);
                } else {
                    System.out.println("[DEBUG]   → Current/Upcoming");
                    current.add(booking);
                }
            }

            System.out.println("[DEBUG] Current bookings: " + current.size());
            System.out.println("[DEBUG] Previous bookings: " + previous.size());

            request.setAttribute("currentBookings", current);
            request.setAttribute("previousBookings", previous);
            request.getRequestDispatcher("/WEB-INF/view/my-bookings.jsp")
                    .forward(request, response);
            System.out.println("[DEBUG] Forward complete");

        } catch (SQLException e) {
            System.err.println("[ERROR] Unable to load bookings for userId " + userId);
            e.printStackTrace();
            throw new ServletException("Database error while fetching bookings", e);
        }
    }
}
