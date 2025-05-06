package controller.admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Booking;
import service.AdminService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminBookingServlet", value = "/admin-booking")
public class AdminBookingServlet extends HttpServlet {

    private AdminService adminService;

    @Override
    public void init() {
        adminService = new AdminService();
        System.out.println("AdminBookingServlet initialized.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        int pageSize = 10;

        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }
            System.out.println("Fetching bookings - Page: " + page + ", PageSize: " + pageSize);

            List<Booking> bookings = adminService.getBookings(page, pageSize);
            System.out.println("Bookings fetched: " + (bookings != null ? bookings.size() : "null"));

            request.setAttribute("bookings", bookings);
            request.setAttribute("currentPage", page);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/admin/admin-bookings.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            System.err.println("Error fetching bookings: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error fetching bookings", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String bookingIdStr = request.getParameter("bookingId");
            String status = request.getParameter("status");

            System.out.println("Received POST request - BookingID: " + bookingIdStr + ", Status: " + status);

            int bookingId = Integer.parseInt(bookingIdStr);

            boolean updated = adminService.updateBookingStatus(bookingId, status);

            if (updated) {
                System.out.println("Booking status updated successfully.");
                response.sendRedirect(request.getContextPath() + "/admin-bookings?success=true");
            } else {
                System.out.println("Failed to update booking status.");
                response.sendRedirect(request.getContextPath() + "/admin-bookings?error=true");
            }

        } catch (Exception e) {
            System.err.println("Error updating booking status: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error updating booking status", e);
        }
    }
}
