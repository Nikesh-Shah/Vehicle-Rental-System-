<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>My Bookings</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 20px; }
    h2 { border-bottom: 2px solid #444; padding-bottom: 5px; }
    .booking { border: 1px solid #ccc; margin-bottom: 15px; padding: 10px; border-radius: 5px; }
    .vehicles { margin-top: 10px; }
    .vehicle { display: inline-block; width: 180px; margin-right: 10px; vertical-align: top; text-align: center; }
    .vehicle img { max-width: 100%; height: auto; border-radius: 4px; }
    .none { color: #888; font-style: italic; }
  </style>
</head>
<body>

<h1>My Bookings</h1>

<h2>Current & Upcoming Bookings</h2>
<h2>Current Bookings</h2>
<c:forEach var="booking" items="${currentBookings}">
  <p>
    <strong>Booking ID:</strong> ${booking.bookingId} <br>
    <strong>Start Date:</strong> ${booking.startDate} <br>
    <strong>End Date:</strong> ${booking.endDate} <br>
    <strong>Total Amount:</strong> ${booking.totalAmount} <br>
    <strong>Status:</strong> ${booking.status}
  </p>
  <hr>
</c:forEach>

<h2>Previous Bookings</h2>
<c:forEach var="booking" items="${previousBookings}">
  <p>
    <strong>Booking ID:</strong> ${booking.bookingId} <br>
    <strong>Start Date:</strong> ${booking.startDate} <br>
    <strong>End Date:</strong> ${booking.endDate} <br>
    <strong>Total Amount:</strong> ${booking.totalAmount} <br>
    <strong>Status:</strong> ${booking.status}
  </p>
  <hr>
</c:forEach>


</body>
</html>
