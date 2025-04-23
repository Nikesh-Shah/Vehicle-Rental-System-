package model;

public class BookingVehicle {
    private int bookingId;
    private int vehicleId;
    private int categoryId;
    private int userId;

    public BookingVehicle(int bookingId, int userId, int categoryId, int vehicleId) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.categoryId = categoryId;
        this.vehicleId = vehicleId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }
}
