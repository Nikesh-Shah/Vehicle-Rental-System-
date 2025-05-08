<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Confirm Booking</title>
  <style>
    .summary { border: 1px solid #ddd; padding: 20px; margin-bottom: 20px; }
    .summary img { max-width: 200px; }
  </style>
</head>
<body>
<div class="summary">
  <h2>Booking Summary</h2>
  <img src="${vehicle.image}" alt="${vehicle.brand} ${vehicle.model}">
  <h3>${vehicle.brand} ${vehicle.model}</h3>

  <div class="details">
    <p><strong>Rental Period:</strong><br>
      ${startDate} to ${endDate}</p>

    <p><strong>Price Breakdown:</strong><br>
      Nrs${vehicle.pricePerDay} x ${days} days = $${total}</p>
  </div>
</div>

<form action="confirm-booking" method="post">
  <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">
  <input type="hidden" name="startDate" value="${startDate}">
  <input type="hidden" name="endDate" value="${endDate}">
  <input type="hidden" name="total" value="${total}">

  <h3>Payment Method</h3>
  <div class="payment-method">
    <input type="radio" name="paymentMethod" value="COD" checked>
    <label>Cash on Delivery (COD)</label>
  </div>

  <button type="submit">Confirm Booking</button>
</form>
</body>
</html>