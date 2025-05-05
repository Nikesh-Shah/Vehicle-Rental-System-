<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Vehicle Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="row">
        <div class="col-md-6">
            <img src="${vehicle.image}" class="img-fluid rounded" alt="${vehicle.brand} ${vehicle.model}">
        </div>
        <div class="col-md-6">
            <h1>${vehicle.brand} ${vehicle.model}</h1>
            <p class="lead">$${vehicle.pricePerDay} per day</p>
            <p>Status: <span class="badge bg-${vehicle.status == 'Available' ? 'success' : 'danger'}">${vehicle.status}</span></p>

            <c:if test="${not empty sessionScope.user}">
                <form action="bookings" method="post" class="mt-4">
                    <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">
                    <div class="mb-3">
                        <label for="startDate" class="form-label">Start Date</label>
                        <input type="date" class="form-control" id="startDate" name="startDate" required>
                    </div>
                    <div class="mb-3">
                        <label for="endDate" class="form-label">End Date</label>
                        <input type="date" class="form-control" id="endDate" name="endDate" required>
                    </div>
                    <button type="submit" class="btn btn-primary" ${vehicle.status != 'Available' ? 'disabled' : ''}>
                            ${vehicle.status == 'Available' ? 'Book Now' : 'Not Available'}
                    </button>
                </form>
            </c:if>
            <c:if test="${empty sessionScope.user}">
                <div class="alert alert-info mt-4">
                    Please <a href="login.jsp">login</a> to book this vehicle.
                </div>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>