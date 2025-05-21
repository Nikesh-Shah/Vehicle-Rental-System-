package dao;

import model.Category;
import model.Vehicle;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.DbConnectionUtil;

public class VehicleDAO {
    public static final String STATUS_AVAILABLE = "Available";
    public static final String STATUS_BOOKED = "Booked";
    public static final String STATUS_MAINTENANCE = "Maintenance";

    public List<Vehicle> getAllVehicles() throws SQLException {
        List<Vehicle> vehicles = new ArrayList<>();
        String sql = "SELECT * FROM vehicle";
        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {


            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    vehicles.add(mapResultSetToVehicle(rs));
                }
            }
        }
        return vehicles;
    }


    public Vehicle getVehicleById(int id) throws SQLException {
        String sql = "SELECT * FROM vehicle WHERE vehicleId = ?";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToVehicle(rs);
                }
            }
        }
        return null;
    }

    public int addVehicle(Vehicle vehicle) throws SQLException {
        String sql = "INSERT INTO vehicle (vehicle_brand, vehicle_model, vehicle_price_per_day, " +
                "vehicle_status, categoryId, vehicle_image, quantity) VALUES (?, ?, ?, ?, ?, ?,?)";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, vehicle.getBrand());
            stmt.setString(2, vehicle.getModel());
            stmt.setDouble(3, vehicle.getPricePerDay());
            stmt.setString(4, vehicle.getStatus());
            stmt.setInt(5, vehicle.getCategoryId());
            stmt.setString(6, vehicle.getImage());
            stmt.setInt(7, vehicle.getQuantity());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                return 0;
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
            return 0;
        }
    }

    public boolean updateVehicle(Vehicle vehicle) throws SQLException {
        String sql = "UPDATE vehicle SET vehicle_brand = ?, vehicle_model = ?, " +
                "vehicle_price_per_day = ?, vehicle_status = ?, categoryId = ?, " +
                "vehicle_image = ? , quantity = ? WHERE vehicleId = ?";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, vehicle.getBrand());
            stmt.setString(2, vehicle.getModel());
            stmt.setDouble(3, vehicle.getPricePerDay());
            stmt.setString(4, vehicle.getStatus());
            stmt.setInt(5, vehicle.getCategoryId());
            stmt.setString(6, vehicle.getImage());
            stmt.setInt(7, vehicle.getQuantity());
            stmt.setInt(8, vehicle.getVehicleId());

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteVehicle(int id) throws SQLException {
        String sql = "DELETE FROM vehicle WHERE vehicleId = ?";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public List<Vehicle> getAvailableVehicles(Date startDate, Date endDate) throws SQLException {
        String sql = "SELECT v.* FROM vehicle v WHERE v.vehicle_status = ? " +
                "AND v.vehicleId NOT IN (SELECT bv.vehicleId FROM booking_vehicle bv " +
                "JOIN booking b ON bv.bookingId = b.bookingId " +
                "WHERE (b.booking_start_date <= ? AND b.booking_end_date >= ?))";

        List<Vehicle> vehicles = new ArrayList<>();

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, STATUS_AVAILABLE);
            stmt.setDate(2, new java.sql.Date(endDate.getTime()));
            stmt.setDate(3, new java.sql.Date(startDate.getTime()));

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    vehicles.add(mapResultSetToVehicle(rs));
                }
            }
        }
        return vehicles;
    }
    public boolean isVehicleAvailable(int vehicleId, Date startDate, Date endDate) throws SQLException {
        String sql = "SELECT COUNT(*) FROM booking_vehicle bv " +
                "JOIN booking b ON bv.bookingId = b.bookingId " +
                "WHERE bv.vehicleId = ? AND b.booking_status NOT IN ('Cancelled') " +
                "AND ((b.booking_start_date <= ? AND b.booking_end_date >= ?) " +
                "OR (b.booking_start_date BETWEEN ? AND ?))";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, vehicleId);
            stmt.setDate(2, new java.sql.Date(endDate.getTime()));
            stmt.setDate(3, new java.sql.Date(startDate.getTime()));
            stmt.setDate(4, new java.sql.Date(startDate.getTime()));
            stmt.setDate(5, new java.sql.Date(endDate.getTime()));

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) == 0;
            }
        }
    }

    public boolean updateVehicleStatus(int vehicleId, String status) throws SQLException {
        String sql = "UPDATE vehicle SET vehicle_status = ? WHERE vehicleId = ?";
        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, vehicleId);
            return stmt.executeUpdate() > 0;
        }
    }

    private Vehicle mapResultSetToVehicle(ResultSet rs) throws SQLException {
        Vehicle vehicle = new Vehicle();
        vehicle.setVehicleId(rs.getInt("vehicleId"));
        vehicle.setBrand(rs.getString("vehicle_brand"));
        vehicle.setModel(rs.getString("vehicle_model"));
        vehicle.setPricePerDay(rs.getDouble("vehicle_price_per_day"));
        vehicle.setStatus(rs.getString("vehicle_status"));
        vehicle.setQuantity(rs.getInt("quantity"));
        vehicle.setImage(rs.getString("vehicle_image"));
        return vehicle;
    }
        public double getVehiclePricePerDay(int vehicleId) {
            double pricePerDay = 0.0;
            String query = "SELECT vehicle_price_per_day FROM vehicle WHERE vehicleId = ?";

            try (Connection conn = DbConnectionUtil.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(query)) {

                stmt.setInt(1, vehicleId);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    pricePerDay = rs.getDouble("vehicle_price_per_day");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return pricePerDay;


    }

    public List<Vehicle> searchVehicles(String query) {
        List<Vehicle> vehicleList = new ArrayList<>();
        String sql = "SELECT * FROM vehicle WHERE LOWER(vehicle_brand) LIKE ? OR LOWER(vehicle_model) LIKE ?";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + query.toLowerCase() + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Vehicle vehicle = new Vehicle();
                vehicle.setVehicleId(rs.getInt("vehicleId"));
                vehicle.setBrand(rs.getString("vehicle_brand"));
                vehicle.setModel(rs.getString("vehicle_model"));
                vehicle.setPricePerDay(rs.getDouble("vehicle_price_per_day"));
                vehicle.setQuantity(rs.getInt("quantity"));
                vehicle.setImage(rs.getString("vehicle_image"));
                vehicle.setStatus(rs.getString("vehicle_status"));
                vehicleList.add(vehicle);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicleList;
    }
//    public Map<Category, Vehicle> getOneVehicle() throws SQLException {
//        Map<Category, Vehicle> vehicleMap = new HashMap<>();
//        String query = """
//        SELECT c.categoryId,
//               v.vehicleId, v.vehicle_brand, v.vehicle_model,
//               v.vehicle_price_per_day, v.vehicle_status, v.vehicle_image, v.quantity
//        FROM category c
//        JOIN vehicle v ON c.categoryId = v.categoryId
//        ORDER BY c.categoryId, v.vehicleId
//        LIMIT 4
//    """;
//        try (Connection conn = DbConnectionUtil.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(query);
//             ResultSet rs = stmt.executeQuery()) {
//
//            while (rs.next()) {
//                Category category = new Category();
//                category.setCategoryId(rs.getInt("categoryId"));
//
//                Vehicle vehicle = new Vehicle();
//                vehicle.setVehicleId(rs.getInt("vehicleId"));
//                vehicle.setBrand(rs.getString("vehicle_brand"));
//                vehicle.setModel(rs.getString("vehicle_model"));
//                vehicle.setPricePerDay(rs.getDouble("vehicle_price_per_day"));
//                vehicle.setStatus(rs.getString("vehicle_status"));
//                vehicle.setQuantity(rs.getInt("quantity"));
//                vehicle.setImage(rs.getString("vehicle_image"));
//
//                // Only add one vehicle per category
//                if (!vehicleMap.containsKey(category)) {
//                    vehicleMap.put(category, vehicle);
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//            throw new SQLException("SQLException: " + e.getMessage());
//        }
//        return vehicleMap;
//    }
public Map<Category, Vehicle> getOneVehicle() throws SQLException {
    Map<Category, Vehicle> vehicleMap = new HashMap<>();
    String query = """
        WITH first_four_categories AS (
            SELECT categoryId
            FROM category
            ORDER BY categoryId
            LIMIT 4
        ),
        ranked_vehicles AS (
            SELECT 
                c.categoryId,
                v.vehicleId, 
                v.vehicle_brand, 
                v.vehicle_model,
                v.vehicle_price_per_day,
                v.vehicle_status,
                v.vehicle_image,
                v.quantity,
                ROW_NUMBER() OVER (PARTITION BY c.categoryId ORDER BY v.vehicleId) AS rn
            FROM first_four_categories c
            JOIN vehicle v ON c.categoryId = v.categoryId
        )
        SELECT *
        FROM ranked_vehicles
        WHERE rn = 1
        ORDER BY categoryId;
    """;

    try (Connection conn = DbConnectionUtil.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query);
         ResultSet rs = stmt.executeQuery()) {

        System.out.println("Executing getOneVehicle query...");

        while (rs.next()) {
            int categoryId = rs.getInt("categoryId");
            System.out.println("Processing categoryId: " + categoryId);

            Category category = new Category();
            category.setCategoryId(categoryId);

            Vehicle vehicle = new Vehicle();
            vehicle.setVehicleId(rs.getInt("vehicleId"));
            vehicle.setBrand(rs.getString("vehicle_brand"));
            vehicle.setModel(rs.getString("vehicle_model"));
            vehicle.setPricePerDay(rs.getDouble("vehicle_price_per_day"));
            vehicle.setStatus(rs.getString("vehicle_status"));
            vehicle.setQuantity(rs.getInt("quantity"));
            vehicle.setImage(rs.getString("vehicle_image"));

            System.out.println("Mapped vehicle: " + vehicle.getBrand() + " " + vehicle.getModel());

            vehicleMap.put(category, vehicle);
        }

        System.out.println("Total categories processed: " + vehicleMap.size());

    } catch (SQLException e) {
        e.printStackTrace();
        throw new SQLException("SQLException: " + e.getMessage());
    }

    return vehicleMap;
}

    public int getCategoryIdByVehicleId(int vehicleId) throws SQLException {
        String sql = "SELECT categoryId FROM vehicle WHERE vehicleId = ?";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, vehicleId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("categoryId");
                } else {
                    throw new SQLException("[ERROR] Category ID not found for Vehicle ID: " + vehicleId);
                }
            }
        }
    }
    public boolean reduceVehicleQuantity(int vehicleId, int quantity) throws SQLException {
        String sql = "UPDATE vehicle SET quantity = quantity - ? WHERE vehicleId = ? AND quantity >= ?";

        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, quantity);
            stmt.setInt(2, vehicleId);
            stmt.setInt(3, quantity);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    public int getVehicleQuantity(int vehicleId) throws SQLException {
        String sql = "SELECT quantity FROM vehicle WHERE vehicleId = ?";
        try (Connection conn = DbConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, vehicleId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("quantity");
                } else {
                    throw new SQLException("Vehicle not found for ID: " + vehicleId);
                }
            }
        }
    }




}