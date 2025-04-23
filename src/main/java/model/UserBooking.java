package model;

public class UserBooking {
    private int bookingId;
    private int vehicleId;
    private int userId;
    private int paymentId;

    public UserBooking(int bookingId, int vehicleId, int userId, int paymentId) {
        this.bookingId = bookingId;
        this.vehicleId = vehicleId;
        this.userId = userId;
        this.paymentId = paymentId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }
}

