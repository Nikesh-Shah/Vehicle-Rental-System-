package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import service.AdminService;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet(name = "AdminUserServlet", value = "/admin-users")
public class AdminUserServlet extends HttpServlet {
    private static final int DEFAULT_PAGE_SIZE = 10;
    private AdminService adminService;

    @Override
    public void init() throws ServletException {
        adminService = new AdminService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("doGet() triggered in AdminUserServlet");


        // Handle pagination
        int page = getPageNumber(request);
        List<User> users = adminService.getUsers(page, DEFAULT_PAGE_SIZE);
        int totalUsers = adminService.getTotalUsers();

        // Set attributes
        request.setAttribute("users", users);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("currentPage", page);

        // Forward to user list view
        request.getRequestDispatcher("/WEB-INF/view/admin/admin-users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        System.out.println("doPost() triggered in AdminUserServlet");


        try {
            String action = request.getParameter("action");

            if ("delete".equals(action)) {
                // Delete user
                int userId = Integer.parseInt(request.getParameter("userId"));
                boolean success = adminService.deleteUser(userId);
                System.out.println("Delete user success: " + success);
                redirectWithStatus(request, response, success, "User deleted successfully");
            }

        } catch (NumberFormatException e) {
            System.out.println("Invalid number format for userId.");
            redirectWithStatus(request, response, false, "Invalid input data");
        }
    }

    private int getPageNumber(HttpServletRequest request) {
        String pageParam = request.getParameter("page");
        try {
            return pageParam != null ? Integer.parseInt(pageParam) : 1;
        } catch (NumberFormatException e) {
            System.out.println("Invalid page number format: " + pageParam);
            return 1;
        }
    }

    private void redirectWithStatus(HttpServletRequest request, HttpServletResponse response,
                                    boolean success, String successMessage) throws IOException {
        String param = success ? "success" : "error";
        String message = success ? successMessage : "Operation failed";
        System.out.println("Redirecting with status: " + param + " - " + message);
        response.sendRedirect(request.getContextPath() + "/admin-users?" + param + "=" +
                URLEncoder.encode(message, StandardCharsets.UTF_8));
    }


}
