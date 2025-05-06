<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Available Vehicles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h1 class="mb-4">Our Vehicle Fleet</h1>

    <form action="vehicles" method="get" class="mb-4">
        <input type="hidden" name="action" value="available">
        <div class="row g-3">
            <div class="col-md-4">
                <label for="startDate" class="form-label">Start Date</label>
                <input type="date" class="form-control" id="startDate" name="startDate" required>
            </div>
            <div class="col-md-4">
                <label for="endDate" class="form-label">End Date</label>
                <input type="date" class="form-control" id="endDate" name="endDate" required>
            </div>
            <div class="col-md-4 d-flex align-items-end">
                <button type="submit" class="btn btn-primary">Check Availability</button>
            </div>
        </div>
    </form>

    <div class="row row-cols-1 row-cols-md-3 g-4">
        <c:forEach items="${vehicles}" var="vehicle">
            <div class="col">
                <div class="card h-100">
                    <img src="${vehicle.image}" class="card-img-top" alt="${vehicle.brand} ${vehicle.model}">
                    <div class="card-body">
                        <h5 class="card-title">${vehicle.brand} ${vehicle.model}</h5>
                        <p class="card-text">$${vehicle.pricePerDay} per day</p>
                        <p class="card-text"><small class="text-muted">Status: ${vehicle.status}</small></p>
                    </div>
                    <div class="card-footer">
                        <a href="vehicles?action=details&id=${vehicle.vehicleId}" class="btn btn-outline-primary">View Details</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>