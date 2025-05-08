<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Rent ${vehicle.brand} ${vehicle.model}</title>
    <style>
        .vehicle-details { border: 1px solid #ddd; padding: 20px; margin-bottom: 20px; }
        .vehicle-details img { max-width: 300px; }
    </style>
</head>
<body>
<div class="vehicle-details">
    <h2>You're renting:</h2>
    <img src="${vehicle.image}" alt="${vehicle.brand} ${vehicle.model}">
    <h3>${vehicle.brand} ${vehicle.model}</h3>
    <p>Price per day: NRs${vehicle.pricePerDay}</p>
    <p>Current status: ${vehicle.status}</p>
</div>

<form action="calculate-total" method="post">
    <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">

    <h3>Select Rental Period</h3>
    <label>Start Date: <input type="date" name="startDate" required></label><br>
    <label>Return Date: <input type="date" name="endDate" required></label><br>

    <button type="submit">Calculate Total</button>
</form>
</body>
</html>