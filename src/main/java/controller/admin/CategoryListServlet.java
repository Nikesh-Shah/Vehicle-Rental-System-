package controller.admin;

import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Category;
import model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/categories")
public class CategoryListServlet extends HttpServlet {
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || user.getRole() != 1) {
            System.out.println("[DEBUG] ✘ Unauthorized access attempt. Redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            System.out.println("[DEBUG] → Fetching all categories...");
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/view/admin/categories.jsp").forward(request, response);
            System.out.println("[DEBUG] ✔ Categories displayed successfully.");
        } catch (SQLException e) {
            System.out.println("[ERROR] ✘ SQL Exception during category retrieval: " + e.getMessage());
            request.setAttribute("error", "Error loading categories: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("[DEBUG] → Entering DeleteCategoryServlet doPost...");

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || user.getRole() != 1) {
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
}
