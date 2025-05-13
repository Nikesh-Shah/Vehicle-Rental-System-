package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import dao.CategoryDAO;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/delete-category")
public class DeleteCategoryServlet extends HttpServlet {
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        System.out.println("[DEBUG] → Entering DeleteCategoryServlet doPost...");

        HttpSession session = request.getSession(false);
        if (!isAdmin(session)) {
            System.out.println("[DEBUG] ✘ Unauthorized access attempt. Redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        } else {
            System.out.println("[DEBUG] ✔ User is authorized.");
        }

        try {
            String categoryIdParam = request.getParameter("id");
            System.out.println("[DEBUG] → Received category ID: " + categoryIdParam);

            int categoryId = Integer.parseInt(categoryIdParam);

            System.out.println("[DEBUG] → Attempting to delete category with ID: " + categoryId);
            categoryDAO.deleteCategory(categoryId);

            System.out.println("[DEBUG] ✔ Category deleted successfully. Redirecting to category list.");
            response.sendRedirect(request.getContextPath() + "/admin/categories");

        } catch (NumberFormatException e) {
            System.out.println("[ERROR] ✘ Invalid category ID format: " + e.getMessage());
            request.setAttribute("error", "Invalid category ID format.");
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);

        } catch (SQLException e) {
            System.out.println("[ERROR] ✘ SQL Exception during category deletion: " + e.getMessage());
            request.setAttribute("error", "Delete failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println("[ERROR] ✘ Unexpected error: " + e.getMessage());
            request.setAttribute("error", "An unexpected error occurred.");
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        }
    }

    private boolean isAdmin(HttpSession session) {
        if (session == null) {
            System.out.println("[DEBUG] ✘ Session is null.");
            return false;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            System.out.println("[DEBUG] ✘ No user found in session.");
            return false;
        }

        boolean isAdmin = user.getRole() == 1;
        System.out.println("[DEBUG] → User is admin: " + isAdmin);
        return isAdmin;
    }
}
