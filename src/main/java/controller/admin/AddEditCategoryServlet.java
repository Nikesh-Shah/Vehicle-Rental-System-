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

@WebServlet("/admin/category-form")
public class AddEditCategoryServlet extends HttpServlet {
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("[DEBUG] AddEditCategoryServlet: doGet() called");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            System.out.println("[DEBUG] Session is null or user not found. Redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user.getRole() != 1) {
            System.out.println("[DEBUG] User is not an admin. Redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        System.out.println("[DEBUG] User authenticated as admin.");

        try {
            String idParam = request.getParameter("id");

            if (idParam != null) {
                int categoryId = Integer.parseInt(idParam);
                System.out.println("[DEBUG] Fetching category with ID: " + categoryId);

                Category category = categoryDAO.getCategoryById(categoryId);
                request.setAttribute("category", category);
            }
            request.getRequestDispatcher("/WEB-INF/view/admin/categoryForm.jsp").forward(request, response);
        } catch (NumberFormatException | SQLException e) {
            System.out.println("[ERROR] Invalid category request: " + e.getMessage());
            request.setAttribute("error", "Invalid category request");
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("[DEBUG] AddEditCategoryServlet: doPost() called");

        try {
            // Creating Category object from request parameters
            Category category = new Category();
            category.setName(request.getParameter("name"));
            category.setDescription(request.getParameter("description"));

            String idParam = request.getParameter("id");

            if (idParam != null && !idParam.isEmpty()) {
                category.setCategoryId(Integer.parseInt(idParam));
                System.out.println("[DEBUG] Updating existing category with ID: " + idParam);
                categoryDAO.updateCategory(category);
            } else {
                System.out.println("[DEBUG] Adding new category");
                categoryDAO.addCategory(category);
            }
            response.sendRedirect(request.getContextPath() + "/admin/categories");

        } catch (SQLException | NumberFormatException e) {
            System.out.println("[ERROR] Error saving category: " + e.getMessage());
            request.setAttribute("error", "Error saving category: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        }
    }
}
