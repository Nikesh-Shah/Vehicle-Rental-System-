package controller.admin;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Booking;
import model.User;
import dao.BookingDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/bookings")
public class AdminBookingsServlet extends HttpServlet {
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("[DEBUG] AdminBookingsServlet: doGet() called");

        HttpSession session = request.getSession(false);

        if (!isAdmin(session)) {
            System.out.println("[DEBUG] User is not admin or session is null. Redirecting to login page.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        System.out.println("[DEBUG] User is an admin. Access granted.");

        try {
            String statusFilter = request.getParameter("status");
            System.out.println("[DEBUG] Status filter received: " + statusFilter);

            List<Booking> bookings = bookingDAO.getAllBookings(statusFilter);

            System.out.println("[DEBUG] Number of bookings retrieved: " + bookings.size());
            if (!bookings.isEmpty()) {
                System.out.println("[DEBUG] First booking details: " + bookings.get(0));
            }

            request.setAttribute("bookings", bookings);
            request.setAttribute("statusFilter", statusFilter == null ? "all" : statusFilter);
            System.out.println("[DEBUG] Forwarding to adminBookings.jsp");
            request.getRequestDispatcher("/WEB-INF/view/admin/adminBookings.jsp").forward(request, response);

        } catch (SQLException e) {
            System.out.println("[ERROR] Error loading bookings: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error loading bookings: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        }
    }

    private boolean isAdmin(HttpSession session) {
        if (session == null) {
            System.out.println("[DEBUG] Session is null.");
            return false;
        }
        User user = (User) session.getAttribute("user");
        if (user == null) {
            System.out.println("[DEBUG] User not found in session.");
            return false;
        }
        System.out.println("[DEBUG] User role is: " + user.getRole());
        return user.getRole() == 1;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("[DEBUG] AdminBookingActionServlet: doPost() called");

        String action       = request.getParameter("action");
        String bookingIdStr = request.getParameter("bookingId");
        String status       = request.getParameter("status");

        if (action == null || bookingIdStr == null || bookingIdStr.isEmpty()) {
            request.setAttribute("error", "Missing required parameters.");
            request.getRequestDispatcher("/WEB-INF/view/error.jsp")
                    .forward(request, response);
            return;
        }

        try {
            int bookingId = Integer.parseInt(bookingIdStr);

            switch (action) {
                case "update":
                    if (status == null || status.isEmpty()) {
                        request.setAttribute("error", "Status is required for update.");
                        request.getRequestDispatcher("/WEB-INF/view/error.jsp")
                                .forward(request, response);
                        return;
                    }
                    System.out.printf("[DEBUG] Updating booking %d → %s\n", bookingId, status);
                    bookingDAO.updateBookingStatus(bookingId, status);
                    break;

                case "delete":
                    System.out.printf("[DEBUG] Deleting booking %d\n", bookingId);
                    boolean deleted = bookingDAO.deleteBookingByAdmin(bookingId);
                    if (!deleted) {
                        request.setAttribute("error", "Failed to delete booking.");
                        request.getRequestDispatcher("/WEB-INF/view/error.jsp")
                                .forward(request, response);
                        return;
                    }
                    break;

                default:
                    throw new IllegalArgumentException("Unknown action: " + action);
            }

            // Redirect back to the bookings list
            response.sendRedirect(request.getContextPath() + "/admin/bookings");

        } catch (NumberFormatException e) {
            System.out.println("[ERROR] Invalid bookingId format: " + e.getMessage());
            request.setAttribute("error", "Invalid booking ID.");
            request.getRequestDispatcher("/WEB-INF/view/error.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            System.out.println("[ERROR] DB error: " + e.getMessage());
            request.setAttribute("error", "Database error occurred.");
            request.getRequestDispatcher("/WEB-INF/view/error.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            System.out.println("[ERROR] Unexpected error: " + e.getMessage());
            request.setAttribute("error", "An unexpected error occurred.");
            request.getRequestDispatcher("/WEB-INF/view/error.jsp")
                    .forward(request, response);
        }
    }
}
