package service;

import dao.BookingDAO;
import dao.PaymentDAO;
import model.Booking;
import model.Payment;

import java.sql.SQLException;
import java.util.List;
public class PaymentService {
    private final PaymentDAO paymentDAO;
    private final BookingDAO bookingDAO;

    public PaymentService() {
        this.paymentDAO = new PaymentDAO();
        this.bookingDAO = new BookingDAO();
    }

    /**
     * Process a COD payment for a booking
     */
    public boolean processCODPayment(int bookingId) {
        try {
            // Get booking details
            Booking booking = bookingDAO.getBookingById(bookingId);
            if (booking == null) {
                throw new IllegalArgumentException("Booking not found");
            }

            // Create payment record
            int paymentId = paymentDAO.createCODPayment(bookingId, booking.getTotalAmount());
            if (paymentId == 0) {
                throw new RuntimeException("Failed to create payment record");
            }

            // Link payment to booking
            if (!paymentDAO.linkPaymentToBooking(bookingId, paymentId)) {
                throw new RuntimeException("Failed to link payment to booking");
            }

            // Confirm the booking
            return bookingDAO.updateBookingStatus(bookingId, "Confirmed");

        } catch (SQLException e) {
            throw new RuntimeException("Database error during COD processing", e);
        }
    }

    /**
     * Mark a COD payment as completed (when cash is collected)
     */
    public boolean completeCODPayment(int paymentId) {
        try {
            return paymentDAO.updatePaymentStatus(paymentId, PaymentDAO.STATUS_COMPLETED);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to complete COD payment", e);
        }
    }

    /**
     * Get all pending COD payments (for admin)
     */
    public List<Payment> getPendingCODPayments() {
        try {
            return paymentDAO.getPendingCODPayments();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to fetch pending COD payments", e);
        }
    }
}