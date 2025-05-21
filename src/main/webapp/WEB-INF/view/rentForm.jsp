<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Rent ${vehicle.brand} ${vehicle.model}</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/rent-form.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%@ include file="/WEB-INF/view/common/navbar.jsp" %>

<section class="section">
<div class="container">
    <div class="vehicle-details">
        <h2>You're renting:</h2>
        <img src="${vehicle.image}" alt="${vehicle.brand} ${vehicle.model}">
        <h3>${vehicle.brand} ${vehicle.model}</h3>
        <p>Price per day: <span>NRs ${vehicle.pricePerDay}</span></p>
        <p>Current status: <span>${vehicle.status}</span></p>
    </div>

    <form action="calculate-total" method="post">
        <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">

        <h3>Select Rental Period</h3>
        <label>Start Date:
            <input type="date" name="startDate" required>
        </label>
        <label>Return Date:
            <input type="date" name="endDate" required>
        </label>



            <button type="submit" class="confirm-button">Calculate Total</button>
            <a href="javascript:history.back()" class="back-link">← Back</a>

    </form>
</div>
</section>

<jsp:include page="/WEB-INF/view/common/footer.jsp" />
</body>
</html>



