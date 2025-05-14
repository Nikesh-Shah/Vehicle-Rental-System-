package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Booking;
import model.Payment;
import model.User;
import service.AdminService;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminDashboardServlet", value = "/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private AdminService adminService;

    @Override
    public void init() {
        this.adminService = new AdminService();
        System.out.println("AdminDashboardServlet initialized.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("doGet() triggered in AdminDashboardServlet");

        String limitParam = request.getParameter("limit");
        int limit = 5;

        try {
            if (limitParam != null) {
                limit = Integer.parseInt(limitParam);
                if (limit <= 0) {
                    limit = 5;
                }
            }
        } catch (NumberFormatException e) {
            limit = 5;
        }

        // Fetch stats
        int totalUsers = adminService.getTotalUsers();
        int totalVehicles = adminService.getTotalVehicles();
        int totalBookings = adminService.getTotalBookings();
        double totalRevenue = adminService.getTotalRevenue();
        List<Booking> recentBookings = adminService.getRecentBookings(limit);
        List<Payment> recentPayments = adminService.getRecentPayments(limit);

        // Set attributes
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalVehicles", totalVehicles);
        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("recentBookings", recentBookings);
        System.out.println("recentPaments"+recentPayments);
        request.setAttribute("recentPayments", recentPayments);

        // Forward to dashboard view
        request.getRequestDispatcher("/WEB-INF/view/admin/admin-dashboard.jsp").forward(request, response);
    }

    private boolean isAccessDenied(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;
        boolean isAdmin = user != null && user.isAdmin();
        System.out.println("User isAdmin check: " + isAdmin);
        return !isAdmin;
    }
}
