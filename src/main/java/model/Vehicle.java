package model;

public class Vehicle {
    private int vehicleId;
    private String vehicleBrand;
    private String vehicleModel;
    private double vehiclePricePerDay;
    private String vehicleStatus;

    public Vehicle(String vehicleStatus, double vehiclePricePerDay, String vehicleModel, String vehicleBrand) {
        this.vehicleStatus = vehicleStatus;
        this.vehiclePricePerDay = vehiclePricePerDay;
        this.vehicleModel = vehicleModel;
        this.vehicleBrand = vehicleBrand;
    }

    public Vehicle(String vehicleStatus, double vehiclePricePerDay, String vehicleModel, String vehicleBrand, int vehicleId) {
        this.vehicleStatus = vehicleStatus;
        this.vehiclePricePerDay = vehiclePricePerDay;
        this.vehicleModel = vehicleModel;
        this.vehicleBrand = vehicleBrand;
        this.vehicleId = vehicleId;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getVehicleStatus() {
        return vehicleStatus;
    }

    public void setVehicleStatus(String vehicleStatus) {
        this.vehicleStatus = vehicleStatus;
    }

    public double getVehiclePricePerDay() {
        return vehiclePricePerDay;
    }

    public void setVehiclePricePerDay(double vehiclePricePerDay) {
        this.vehiclePricePerDay = vehiclePricePerDay;
    }

    public String getVehicleModel() {
        return vehicleModel;
    }

    public void setVehicleModel(String vehicleModel) {
        this.vehicleModel = vehicleModel;
    }

    public String getVehicleBrand() {
        return vehicleBrand;
    }

    public void setVehicleBrand(String vehicleBrand) {
        this.vehicleBrand = vehicleBrand;
    }
}
