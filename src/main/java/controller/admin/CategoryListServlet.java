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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request.getSession(false))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/view/admin/categories.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Error loading categories: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        }
    }

    private boolean isAdmin(HttpSession session) {
        return session != null && ((User) session.getAttribute("user")).getRole() == 1;
    }
}
