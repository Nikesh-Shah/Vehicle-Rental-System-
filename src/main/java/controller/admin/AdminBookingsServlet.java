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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request.getSession(false))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String statusFilter = request.getParameter("status");
            List<Booking> bookings = bookingDAO.getAllBookings(statusFilter);

            request.setAttribute("bookings", bookings);
            request.setAttribute("statusFilter", statusFilter == null ? "all" : statusFilter);
            request.getRequestDispatcher("/WEB-INF/view/admin/adminBookings.jsp").forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("error", "Error loading bookings: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        }
    }

    private boolean isAdmin(HttpSession session) {
        return session != null && ((User) session.getAttribute("user")).getRole() == 1;
    }
}