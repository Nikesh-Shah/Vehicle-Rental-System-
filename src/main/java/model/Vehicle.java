package model;

public class Vehicle {
    private int vehicleId;
    private String brand;
    private String model;
    private double pricePerDay;
    private String status;
    private int categoryId;
    private String image;
    private String categoryName;
    private int quantity;

    // Constructors
    public Vehicle() {}

    public Vehicle(int vehicleId, String brand, String model, double pricePerDay,
                   String status, int categoryId, String image, String categoryName) {
        this.vehicleId = vehicleId;
        this.brand = brand;
        this.model = model;
        this.pricePerDay = pricePerDay;
        this.status = status;
        this.categoryId = categoryId;
        this.image = image;
        this.categoryName = categoryName;
        this.quantity = quantity;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Getters and Setters
    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public double getPricePerDay() {
        return pricePerDay;
    }

    public void setPricePerDay(double pricePerDay) {
        this.pricePerDay = pricePerDay;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setCategoryName(String categoryName) {
    }
    public String getCategoryName() {
        return categoryName;
    }
}