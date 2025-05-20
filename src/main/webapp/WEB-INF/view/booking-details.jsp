<%--&lt;%&ndash;&lt;%&ndash;<%@ page import="model.Vehicle" %>&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>&ndash;%&gt;&ndash;%&gt;--%>

<%--&lt;%&ndash;&lt;%&ndash;&lt;%&ndash;%>&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;  String startDate = (String) request.getAttribute("startDate");&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;  String endDate = (String) request.getAttribute("endDate");&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;  long daysBetween = (long) request.getAttribute("daysBetween");&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;  double totalAmount = (double) request.getAttribute("totalAmount");&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;  Vehicle vehicle = (Vehicle) request.getAttribute("vehicle");&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;%>&ndash;%&gt;&ndash;%&gt;--%>

<%--&lt;%&ndash;&lt;%&ndash;<h2>Payment Information</h2>&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;<p>Vehicle Name: <%= vehicle.getBrand() %></p>&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;<p>Start Date: <%= startDate %></p>&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;<p>End Date: <%= endDate %></p>&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;<p>Days: <%= daysBetween %></p>&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;<p>Price Per Day: NRs <%= vehicle.getPricePerDay() %></p>&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;<h3>Total Amount: NRs <%= totalAmount %></h3>&ndash;%&gt;&ndash;%&gt;--%>

<%--&lt;%&ndash;&lt;%&ndash;<form action="BookingServlet" method="post">&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;  <input type="hidden" name="vehicleId" value="<%= vehicle.getVehicleId() %>">&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;  <input type="hidden" name="totalAmount" value="<%= totalAmount %>">&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;  <input type="hidden" name="startDate" value="<%= startDate %>">&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;  <input type="hidden" name="endDate" value="<%= endDate %>">&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;  <input type="radio" name="paymentMethod" value="COD" checked> Cash on Delivery (COD)<br><br>&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;  <button type="submit" class="btn btn-primary">Confirm Booking</button>&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;</form>&ndash;%&gt;&ndash;%&gt;--%>
<%--<%@ page contentType="text/html;charset=UTF-8" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--  <meta charset="UTF-8">--%>
<%--  <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--  <title>Confirm Booking</title>--%>
<%--  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">--%>
<%--  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/booking-confirmation.css" />--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--  <div class="booking-card">--%>
<%--    <h1 class="page-title">Booking Summary</h1>--%>

<%--    <div class="summary">--%>
<%--      <div class="vehicle-image">--%>
<%--        <img src="${vehicle.image}" alt="${vehicle.brand} ${vehicle.model}">--%>
<%--      </div>--%>

<%--      <div class="vehicle-info">--%>
<%--        <h2 class="vehicle-title">${vehicle.brand} ${vehicle.model}</h2>--%>

<%--        <div class="booking-details">--%>
<%--          <div class="detail-item">--%>
<%--            <span class="detail-icon"><i class="fas fa-calendar-alt"></i></span>--%>
<%--            <div class="detail-content">--%>
<%--              <h3>Rental Period</h3>--%>
<%--              <p>${startDate} to ${endDate}</p>--%>
<%--            </div>--%>
<%--          </div>--%>

<%--          <div class="detail-item">--%>
<%--            <span class="detail-icon"><i class="fas fa-money-bill-wave"></i></span>--%>
<%--            <div class="detail-content">--%>
<%--              <h3>Price Breakdown</h3>--%>
<%--              <p>NRs ${vehicle.pricePerDay} × ${days} days</p>--%>
<%--              <p class="total-price">Total: NRs ${total}</p>--%>
<%--            </div>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--      </div>--%>
<%--    </div>--%>

<%--    <div class="payment-section">--%>
<%--      <h2>Payment Method</h2>--%>

<%--      <form action="confirm-booking" method="post">--%>
<%--        <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">--%>
<%--        <input type="hidden" name="startDate" value="${startDate}">--%>
<%--        <input type="hidden" name="endDate" value="${endDate}">--%>
<%--        <input type="hidden" name="total" value="${total}">--%>

<%--        <div class="payment-options">--%>
<%--          <div class="payment-option">--%>
<%--            <input type="radio" id="cod" name="paymentMethod" value="COD" checked>--%>
<%--            <label for="cod">--%>
<%--              <span class="radio-custom"></span>--%>
<%--              <span class="payment-label">--%>
<%--                                    <i class="fas fa-money-bill-alt"></i>--%>
<%--                                    Cash on Delivery (COD)--%>
<%--                                </span>--%>
<%--            </label>--%>
<%--          </div>--%>
<%--        </div>--%>

<%--        <div class="action-buttons">--%>
<%--          <a href="javascript:history.back()" class="btn-secondary">Back</a>--%>
<%--          <button type="submit" class="btn-primary">Confirm Booking</button>--%>
<%--        </div>--%>
<%--      </form>--%>
<%--    </div>--%>
<%--  </div>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>