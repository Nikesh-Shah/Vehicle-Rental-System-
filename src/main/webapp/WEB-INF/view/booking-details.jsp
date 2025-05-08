<%@ page import="model.Vehicle" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
  String startDate = (String) request.getAttribute("startDate");
  String endDate = (String) request.getAttribute("endDate");
  long daysBetween = (long) request.getAttribute("daysBetween");
  double totalAmount = (double) request.getAttribute("totalAmount");
  Vehicle vehicle = (Vehicle) request.getAttribute("vehicle");
%>

<h2>Payment Information</h2>
<p>Vehicle Name: <%= vehicle.getBrand() %></p>
<p>Start Date: <%= startDate %></p>
<p>End Date: <%= endDate %></p>
<p>Days: <%= daysBetween %></p>
<p>Price Per Day: NRs <%= vehicle.getPricePerDay() %></p>
<h3>Total Amount: NRs <%= totalAmount %></h3>

<form action="BookingServlet" method="post">
  <input type="hidden" name="vehicleId" value="<%= vehicle.getVehicleId() %>">
  <input type="hidden" name="totalAmount" value="<%= totalAmount %>">
  <input type="hidden" name="startDate" value="<%= startDate %>">
  <input type="hidden" name="endDate" value="<%= endDate %>">
  <input type="radio" name="paymentMethod" value="COD" checked> Cash on Delivery (COD)<br><br>
  <button type="submit" class="btn btn-primary">Confirm Booking</button>
</form>
