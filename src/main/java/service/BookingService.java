package service;
import dao.BookingDAO;
import dao.PaymentDAO;
import dao.UserDAO;
import dao.VehicleDAO;
import model.Booking;
import model.Category;
import model.Payment;
import model.Vehicle;

import java.sql.Date;

import java.sql.SQLException;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.List;


public class BookingService {
    private BookingDAO bookingDAO;
    private VehicleDAO vehicleDAO;
    private UserDAO userDAO;

    public BookingService() {
        this.bookingDAO = new BookingDAO();
        this.vehicleDAO = new VehicleDAO();
        this.userDAO = new UserDAO();
    }

    // Create a new booking
    public Booking createBooking(int userId, List<Integer> vehicleIds, Date startDate, Date endDate) {
        validateBookingParameters(userId, vehicleIds, startDate, endDate);

        try {
            // Calculate total amount
            double totalAmount = calculateTotalAmount(vehicleIds, startDate, endDate);

            // Verify all vehicles are available
            verifyVehicleAvailability(vehicleIds, startDate, endDate);

            // Create booking record
            Booking booking = new Booking();
            booking.setUserId(userId);
            booking.setStartDate(startDate);
            booking.setEndDate(endDate);
            booking.setTotalAmount(totalAmount);
            booking.setStatus(BookingDAO.STATUS_PENDING);

            int bookingId = bookingDAO.createBooking(booking);
            if (bookingId > 0) {
                // Link vehicles to booking
                for (int vehicleId : vehicleIds) {
                    bookingDAO.addVehicleToBooking(bookingId, vehicleId);
                }

                // Link user to booking
                bookingDAO.linkUserToBooking(bookingId, userId);

                return bookingDAO.getBookingById(bookingId);
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException("Failed to create booking: " + e.getMessage(), e);
        }
    }

    // Get booking by ID
    public Booking getBookingById(int bookingId) {
        try {
            return bookingDAO.getBookingById(bookingId);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to get booking: " + e.getMessage(), e);
        }
    }

    // Get bookings by user
    public List<Booking> getUserBookings(int userId) {
        try {
            return bookingDAO.getBookingsByUserId(userId);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to get user bookings: " + e.getMessage(), e);
        }
    }

    // Cancel booking
    public boolean cancelBooking(int bookingId, int userId) {
        try {
            Booking booking = bookingDAO.getBookingById(bookingId);
            if (booking == null || booking.getUserId() != userId) {
                return false;
            }

            return bookingDAO.updateBookingStatus(bookingId, BookingDAO.STATUS_CANCELLED);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to cancel booking: " + e.getMessage(), e);
        }
    }

    // Helper methods
    private void validateBookingParameters(int userId, List<Integer> vehicleIds, Date startDate, Date endDate) {
        if (userId <= 0) {
            throw new IllegalArgumentException("Invalid user ID");
        }
        if (vehicleIds == null || vehicleIds.isEmpty()) {
            throw new IllegalArgumentException("At least one vehicle must be selected");
        }
        if (startDate == null || endDate == null) {
            throw new IllegalArgumentException("Both start and end dates are required");
        }
        if (startDate.after(endDate)) {
            throw new IllegalArgumentException("Start date must be before end date");
        }
        java.util.Date currentDate = new java.util.Date();
        Date today = new Date(currentDate.getTime());

        if (startDate.before(today)) {
            throw new IllegalArgumentException("Start date cannot be in the past");
        }

    }

    private double calculateTotalAmount(List<Integer> vehicleIds, Date startDate, Date endDate) throws SQLException {
        double total = 0;
        long days = ChronoUnit.DAYS.between(
                startDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate(),
                endDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate()
        ) + 1; // Inclusive of both start and end dates

        for (int vehicleId : vehicleIds) {
            Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);
            if (vehicle == null) {
                throw new IllegalArgumentException("Vehicle not found with ID: " + vehicleId);
            }
            total += vehicle.getPricePerDay() * days;
        }
        return total;
    }

    private void verifyVehicleAvailability(List<Integer> vehicleIds, Date startDate, Date endDate) throws SQLException {
        for (int vehicleId : vehicleIds) {
            Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);
            if (vehicle == null || !VehicleDAO.STATUS_AVAILABLE.equals(vehicle.getStatus())) {
                throw new IllegalArgumentException("Vehicle not available with ID: " + vehicleId);
            }

            // Check if vehicle is already booked for these dates
            List<Vehicle> conflicts = vehicleDAO.getAvailableVehicles(startDate, endDate);
            if (conflicts.stream().noneMatch(v -> v.getVehicleId() == vehicleId)) {
                throw new IllegalArgumentException("Vehicle already booked for selected dates: " + vehicleId);
            }
        }
    }


}