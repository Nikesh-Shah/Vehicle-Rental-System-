package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Booking {
    private int bookingId;
    private String status;
    private Date startDate;
    private Date endDate;
    private double totalAmount;
    private int userId;
    private List<Vehicle> vehicles;
    private User user;



    // Constructors
    public Booking() {
        this.vehicles = new ArrayList<>();
    }

    public Booking(int bookingId, String status, Date startDate, Date endDate,
                   double totalAmount, int userId) {
        this();
        this.bookingId = bookingId;
        this.status = status;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalAmount = totalAmount;
        this.userId = userId;
    }

    // Getters and Setters
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {

        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public List<Vehicle> getVehicles() {
        return vehicles;
    }

    public void setVehicles(List<Vehicle> vehicles) {
        this.vehicles = vehicles;
    }

    public void addVehicle(Vehicle vehicle) {
        this.vehicles.add(vehicle);
    }
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
        if(user != null) {
            this.userId = user.getUserId();
        }
    }
}