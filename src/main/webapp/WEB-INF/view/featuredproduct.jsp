<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Popular Vehicles</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/feature.css" />
</head>
<body>
<section class="vehicles-section">
    <h1>Popular Vehicles</h1>
    <p class="subtitle">Discover our most popular rental options loved by our customers.</p>

    <div class="vehicles-grid" id="vehicles-container">
        <c:forEach var="entry" items="${categoryVehicleMap}">
            <c:set var="category" value="${entry.key}" />
            <c:set var="vehicle" value="${entry.value}" />

            <div class="vehicle-card">
                <img src="${vehicle.image}" alt="${vehicle.brand} ${vehicle.model}" class="vehicle-image">
                <div class="vehicle-details">
                    <h3 class="vehicle-brand">${vehicle.brand}</h3>
                    <p class="vehicle-model">${vehicle.model}</p>
                    <p class="vehicle-price">NRs ${vehicle.pricePerDay} / day</p>

                    <!-- Status Display -->
                    <span id="status-${vehicle.vehicleId}"
                          class="vehicle-status
                        ${vehicle.status == 'Available' ? 'status-available' :
                         vehicle.status == 'Rented' ? 'status-rented' :
                         'status-maintenance'}">
                            ${vehicle.status}
                    </span>

                    <!-- Rent Now Button -->
                    <form action="booking-form.jsp" method="get">
                        <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">
                        <input type="hidden" name="vehicleBrand" value="${vehicle.brand}">
                        <input type="hidden" name="vehicleModel" value="${vehicle.model}">
                        <input type="hidden" name="pricePerDay" value="${vehicle.pricePerDay}">
                        <a href="rent-form?vehicleId=${vehicle.vehicleId}" class="btn-rent-now">Rent Now</a>
                    </form>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="view-all-container">
        <a href="${pageContext.request.contextPath}/vehicles" class="btn-view-all">View All Vehicles <span class="arrow-icon">→</span></a>
    </div>
</section>

</body>
</html>
