package service;

import dao.CategoryDAO;
import model.Category;

import java.sql.SQLException;
import java.util.List;

public class CategoryService {
    private final CategoryDAO categoryDAO;

    public CategoryService() {
        this.categoryDAO = new CategoryDAO();
    }

    public List<Category> getAllCategories() {
        try {
            return categoryDAO.getAllCategories();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to fetch categories", e);
        }
    }

    public Category getCategoryById(int id) {
        try {
            return categoryDAO.getCategoryById(id);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to fetch category with ID: " + id, e);
        }
    }

    public int addCategory(Category category) {
        validateCategory(category);
        try {
            return categoryDAO.addCategory(category);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to add category", e);
        }
    }

    public boolean updateCategory(Category category) {
        validateCategory(category);
        try {
            return categoryDAO.updateCategory(category);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to update category with ID: " + category.getCategoryId(), e);
        }
    }

    public boolean deleteCategory(int id) {
        try {
            return categoryDAO.deleteCategory(id);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to delete category with ID: " + id, e);
        }
    }

    private void validateCategory(Category category) {
        if (category.getName() == null || category.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Category name is required");
        }
        if (category.getName().length() > 100) {
            throw new IllegalArgumentException("Category name cannot exceed 100 characters");
        }
    }
}