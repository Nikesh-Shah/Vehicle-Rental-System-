<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>Booking #${booking.bookingId}</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h1>Booking #${booking.bookingId}</h1>
    <span class="badge bg-${booking.status == 'Confirmed' ? 'success' :
                                   booking.status == 'Pending' ? 'warning' :
                                   booking.status == 'Cancelled' ? 'danger' : 'info'}">
      ${booking.status}
    </span>
  </div>

  <div class="card mb-4">
    <div class="card-body">
      <div class="row">
        <div class="col-md-6">
          <h5 class="card-title">Booking Details</h5>
          <p><strong>Customer:</strong> ${booking.customerName}</p>
          <p><strong>Dates:</strong>
            <fmt:formatDate value="${booking.startDate}" pattern="MMM d, yyyy"/> -
            <fmt:formatDate value="${booking.endDate}" pattern="MMM d, yyyy"/>
          </p>
          <p><strong>Total Amount:</strong> $<fmt:formatNumber value="${booking.totalAmount}" minFractionDigits="2"/></p>
        </div>
        <div class="col-md-6">
          <h5 class="card-title">Actions</h5>
          <c:if test="${booking.status == 'Pending' || booking.status == 'Confirmed'}">
            <form action="bookings" method="post" class="mb-3">
              <input type="hidden" name="action" value="cancel">
              <input type="hidden" name="bookingId" value="${booking.bookingId}">
              <button type="submit" class="btn btn-danger">Cancel Booking</button>
            </form>
          </c:if>
          <a href="vehicles" class="btn btn-outline-primary">Book Another Vehicle</a>
        </div>
      </div>
    </div>
  </div>

  <h3>Booked Vehicles</h3>
  <div class="row row-cols-1 row-cols-md-3 g-4">
    <c:forEach items="${booking.vehicles}" var="vehicle">
      <div class="col">
        <div class="card h-100">
          <img src="${vehicle.image}" class="card-img-top" alt="${vehicle.brand} ${vehicle.model}">
          <div class="card-body">
            <h5 class="card-title">${vehicle.brand} ${vehicle.model}</h5>
            <p class="card-text">$${vehicle.pricePerDay} per day</p>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>
</body>
</html>