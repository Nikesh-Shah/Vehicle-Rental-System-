package controller.admin;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Category;
import model.Vehicle;
import service.AdminService;
import service.CategoryService;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryService categoryService = new CategoryService(); // Assuming you have this

    private Gson gson = new Gson();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("getAll".equals(action)) {
            List<Category> categories = getCategories();
            String jsonResponse = gson.toJson(categories);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        Category category = gson.fromJson(request.getReader(), Category.class);

        boolean result = false;

        if ("add".equals(action)) {
            result = addCategory(category);
        } else if ("update".equals(action)) {
            result = updateCategory(category);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"success\": " + result + "}");
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryIdParam = request.getParameter("id");

        if (categoryIdParam == null || categoryIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Category ID is required");
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdParam);
            boolean result = deleteCategory(categoryId);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": " + result + "}");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Category ID format");
        }
    }

    // Your original methods
    private List<Category> getCategories() {
        return categoryService.getAllCategories();
    }

    private boolean addCategory(Category category) {
        return categoryService.addCategory(category) > 0;
    }

    private boolean updateCategory(Category category) {
        return categoryService.updateCategory(category);
    }

    private boolean deleteCategory(int categoryId) {
        return categoryService.deleteCategory(categoryId);
    }
}