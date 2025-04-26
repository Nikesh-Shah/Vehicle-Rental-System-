<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>My Bookings</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
  <h1 class="mb-4">My Bookings</h1>

  <c:if test="${not empty param.cancelSuccess}">
    <div class="alert alert-success">Booking cancelled successfully!</div>
  </c:if>

  <c:choose>
    <c:when test="${empty bookings}">
      <div class="alert alert-info">
        You don't have any bookings yet. <a href="vehicles">Book a vehicle now!</a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="table-responsive">
        <table class="table table-striped">
          <thead>
          <tr>
            <th>Booking #</th>
            <th>Dates</th>
            <th>Vehicles</th>
            <th>Total</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach items="${bookings}" var="booking">
            <tr>
              <td>${booking.bookingId}</td>
              <td>
                <fmt:formatDate value="${booking.startDate}" pattern="MMM d"/> -
                <fmt:formatDate value="${booking.endDate}" pattern="MMM d, yyyy"/>
              </td>
              <td>
                <c:forEach items="${booking.vehicles}" var="vehicle" varStatus="loop">
                  ${vehicle.brand} ${vehicle.model}<c:if test="${!loop.last}">, </c:if>
                </c:forEach>
              </td>
              <td>$<fmt:formatNumber value="${booking.totalAmount}" minFractionDigits="2"/></td>
              <td>
                                        <span class="badge bg-${booking.status == 'Confirmed' ? 'success' :
                                                               booking.status == 'Pending' ? 'warning' :
                                                               booking.status == 'Cancelled' ? 'danger' : 'info'}">
                                            ${booking.status}
                                        </span>
              </td>
              <td>
                <a href="bookings?action=details&id=${booking.bookingId}" class="btn btn-sm btn-outline-primary">Details</a>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </c:otherwise>
  </c:choose>
</div>
</body>
</html>