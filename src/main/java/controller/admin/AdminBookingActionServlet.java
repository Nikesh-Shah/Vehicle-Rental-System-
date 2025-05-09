package controller.admin;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import dao.BookingDAO;
import model.User;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/booking-action")
public class AdminBookingActionServlet extends HttpServlet {
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("[DEBUG] AdminBookingActionServlet: doPost() called");

        HttpSession session = request.getSession(false);
        if (session == null) {
            System.out.println("[DEBUG] Session is null. Redirecting to login.");
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != 1) {
            System.out.println("[DEBUG] User is not admin or user is null. Redirecting to login.");
            response.sendRedirect("login");
            return;
        }

        try {
            String bookingIdParam = request.getParameter("bookingId");
            String action = request.getParameter("action");

            System.out.println("[DEBUG] bookingIdParam: " + bookingIdParam);
            System.out.println("[DEBUG] action: " + action);

            if (bookingIdParam == null || action == null) {
                throw new Exception("Missing bookingId or action");
            }

            int bookingId = Integer.parseInt(bookingIdParam);

            switch (action) {
                case "update":
                    String newStatus = request.getParameter("status");
                    System.out.println("[DEBUG] Updating booking ID " + bookingId + " with status: " + newStatus);
                    bookingDAO.updateBookingStatus(bookingId, newStatus);
                    break;

                case "cancel":
                    System.out.println("[DEBUG] Cancelling booking ID " + bookingId);
                    bookingDAO.cancelBooking(bookingId);
                    break;

                case "delete":
                    System.out.println("[DEBUG] Deleting booking ID " + bookingId);
                    bookingDAO.deleteBooking(bookingId);
                    break;

                default:
                    throw new Exception("Invalid action: " + action);
            }

            System.out.println("[DEBUG] Action '" + action + "' completed successfully.");
            response.sendRedirect("bookings");

        } catch (NumberFormatException e) {
            System.out.println("[ERROR] Invalid booking ID format: " + e.getMessage());
            request.setAttribute("error", "Invalid booking ID format");
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);

        } catch (SQLException e) {
            System.out.println("[ERROR] Database error: " + e.getMessage());
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println("[ERROR] General error: " + e.getMessage());
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        }
    }
}
