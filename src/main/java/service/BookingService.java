package service;

import dao.*;
import model.Booking;
import model.Category;
import model.Payment;
import model.Vehicle;

import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.List;

public class BookingService {
    public double calculateTotalAmount(int vehicleId, LocalDate startDate, LocalDate endDate) {
        VehicleDAO vehicleDAO = new VehicleDAO();
        double pricePerDay = vehicleDAO.getVehiclePricePerDay(vehicleId);
        long daysBetween = ChronoUnit.DAYS.between(startDate, endDate) + 1;
        return pricePerDay * daysBetween;
    }


}
