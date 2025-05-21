package dao;

import model.Category;
import util.DbConnectionUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    // Remove 'static' keyword for proper DAO instance usage
    public List<Category> getAllCategories() throws SQLException {
        String sql = "SELECT * FROM category";
        List<Category> categories = new ArrayList<>();

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                categories.add(mapResultSetToCategory(rs));
            }
        }
        return categories;
    }

    public Category getCategoryById(int id) throws SQLException {
        String sql = "SELECT * FROM category WHERE categoryId = ?";
        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? mapResultSetToCategory(rs) : null;
            }
        }
    }

    public int addCategory(Category category) throws SQLException {
        String sql = "INSERT INTO category (category_name,  category_description) " +
                "VALUES (?, ?)";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, category.getName());
            stmt.setString(2, category.getDescription());
            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
                else throw new SQLException("Failed to create category: No ID generated");
            }
        }
    }

    public boolean updateCategory(Category category) throws SQLException {
        String sql = "UPDATE category SET category_name = ?,category_description = ? WHERE categoryId = ?";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, category.getName());
            stmt.setString(2, category.getDescription());
            stmt.setInt(3, category.getCategoryId());

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteCategory(int id) throws SQLException {
        Connection conn = null;
        try {
            conn = DbConnectionUtil.getConnection();
            conn.setAutoCommit(false); // Transaction start

            // Check for linked vehicles
            String checkSql = "SELECT COUNT(*) FROM vehicle WHERE categoryId = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, id);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        throw new SQLException("Cannot delete category with assigned vehicles");
                    }
                }
            }

            // Delete category
            String deleteSql = "DELETE FROM category WHERE categoryId = ?";
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                deleteStmt.setInt(1, id);
                deleteStmt.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

    // Helper to map ResultSet to Category (matches existing model)
    private Category mapResultSetToCategory(ResultSet rs) throws SQLException {
        Category category = new Category();
        category.setCategoryId(rs.getInt("categoryId"));
        category.setName(rs.getString("category_name")); // Matches DB column to model's setName()
        category.setDescription(rs.getString("category_description"));
        return category;
    }
}