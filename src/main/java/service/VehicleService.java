package service;

import dao.CategoryDAO;
import dao.VehicleDAO;
import model.Vehicle;

import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

public class VehicleService {
    private VehicleDAO vehicleDAO;
    private CategoryDAO categoryDAO;

    public VehicleService() {
        this.vehicleDAO = new VehicleDAO();
        this.categoryDAO = new CategoryDAO();
    }

    public List<Vehicle> getAllVehicles() {
        try {
            return vehicleDAO.getAllVehicles();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to retrieve vehicles", e);
        }
    }

//    public List<Vehicle> getAvailableVehicles(Date startDate, Date endDate) {
//        validateDates(startDate, endDate);
//
//        try {
//            return vehicleDAO.getAvailableVehicles(startDate, endDate);
//        } catch (SQLException e) {
//            throw new RuntimeException("Failed to retrieve available vehicles", e);
//        }
//    }

    public  Vehicle getVehicleById(int id) {
        try {
            Vehicle vehicle = vehicleDAO.getVehicleById(id);
            if (vehicle == null) {
                throw new IllegalArgumentException("Vehicle not found with ID: " + id);
            }
            return vehicle;
        } catch (SQLException e) {
            throw new RuntimeException("Failed to retrieve vehicle", e);
        }
    }

    public int addVehicle(Vehicle vehicle) {
        validateVehicle(vehicle);

        try {
            if (vehicle.getStatus() == null) {
                vehicle.setStatus(VehicleDAO.STATUS_AVAILABLE);
            }


            if (categoryDAO.getCategoryById(vehicle.getCategoryId()) == null) {
                throw new IllegalArgumentException("Invalid category ID");
            }

            return vehicleDAO.addVehicle(vehicle);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to add vehicle", e);
        }
    }

    public boolean updateVehicle(Vehicle vehicle) {
        validateVehicle(vehicle);

        try {
            if (vehicleDAO.getVehicleById(vehicle.getVehicleId()) == null) {
                throw new IllegalArgumentException("Vehicle not found with ID: " + vehicle.getVehicleId());
            }

            return vehicleDAO.updateVehicle(vehicle);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to update vehicle", e);
        }
    }

    public boolean deleteVehicle(int id) {
        try {
            // Check if vehicle exists
            if (vehicleDAO.getVehicleById(id) == null) {
                throw new IllegalArgumentException("Vehicle not found with ID: " + id);
            }

            return vehicleDAO.deleteVehicle(id);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to delete vehicle", e);
        }
    }

    private void validateVehicle(Vehicle vehicle) {
        if (vehicle.getBrand() == null || vehicle.getBrand().trim().isEmpty()) {
            throw new IllegalArgumentException("Brand is required");
        }
        if (vehicle.getModel() == null || vehicle.getModel().trim().isEmpty()) {
            throw new IllegalArgumentException("Model is required");
        }
        if (vehicle.getPricePerDay() <= 0) {
            throw new IllegalArgumentException("Price must be greater than 0");
        }
    }

    private void validateDates(Date startDate, Date endDate) {
        if (startDate == null || endDate == null) {
            throw new IllegalArgumentException("Both start and end dates are required");
        }
        if (startDate.after(endDate)) {
            throw new IllegalArgumentException("Start date must be before end date");
        }

        Date currentDate = new Date(System.currentTimeMillis());

        if (startDate.before(currentDate)) {
            throw new IllegalArgumentException("Start date cannot be in the past");
        }
    }
}
