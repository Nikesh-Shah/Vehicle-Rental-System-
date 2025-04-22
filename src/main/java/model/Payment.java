package model;

import java.util.Date;

public class Payment {
    private int paymentId;
    private Date paymentDate;
    private double amount;
    private String method;
    private String status;
    private int bookingId;

    // Constructors
    public Payment() {}

    public Payment(int paymentId, Date paymentDate, double amount,
                   String method, String status, int bookingId) {
        this.paymentId = paymentId;
        this.paymentDate = paymentDate;
        this.amount = amount;
        this.method = method;
        this.status = status;
        this.bookingId = bookingId;
    }

    // Getters and Setters
    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }
}