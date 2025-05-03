package dao;

import model.Category;
import util.DbConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    public static List<Category> getAllCategories() throws SQLException {
        String sql = "SELECT * FROM category";

        List<Category> categories = new ArrayList<>();

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("categoryId"));
                category.setName(rs.getString("category_name"));
                category.setImage(rs.getString("category_image"));
                category.setDescription(rs.getString("category_description"));
                categories.add(category);
            }
        }
        return categories;
    }

    public static Category getCategoryById(int id) throws SQLException {
        String sql = "SELECT * FROM category WHERE categoryId = ?";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Category category = new Category();
                    category.setCategoryId(rs.getInt("categoryId"));
                    category.setName(rs.getString("category_name"));
                    category.setImage(rs.getString("category_image"));
                    category.setDescription(rs.getString("category_description"));
                    return category;
                }
            }
        }
        return null;
    }

    public static int addCategory(Category category) throws SQLException {
        String sql = "INSERT INTO category (category_name, category_image, category_description) " +
                "VALUES (?, ?, ?)";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, category.getName());
            stmt.setString(2, category.getImage());
            stmt.setString(3, category.getDescription());

            stmt.executeUpdate();
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
            return 0;
        }
    }

    public static boolean updateCategory(Category category) throws SQLException {
        String sql = "UPDATE category SET category_name = ?, category_image = ?, " +
                "category_description = ? WHERE categoryId = ?";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, category.getName());
            stmt.setString(2, category.getImage());
            stmt.setString(3, category.getDescription());
            stmt.setInt(4, category.getCategoryId());

            return stmt.executeUpdate() > 0;
        }
    }

    public static boolean deleteCategory(int id) throws SQLException {
        // First check if category is used by any vehicles
        String checkSql = "SELECT COUNT(*) FROM vehicle WHERE categoryId = ?";
        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(checkSql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    throw new SQLException("Cannot delete category - vehicles are assigned to it");
                }
            }
        }

        // If no vehicles, proceed with deletion
        String sql = "DELETE FROM category WHERE categoryId = ?";
        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }
}