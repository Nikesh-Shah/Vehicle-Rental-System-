<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Confirm Booking</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/booking-confirm.css" />
</head>
<body>
<%@ include file="/WEB-INF/view/common/navbar.jsp" %>
<div class="container-payment-confirm">
  <section class="booking-section">
    <div class="summary">
      <h2>Booking Summary</h2>
      <div class="vehicle-info">
        <img src="${vehicle.image}" alt="${vehicle.brand} ${vehicle.model}">
        <h3>${vehicle.brand} ${vehicle.model}</h3>
      </div>

      <div class="details">
        <div class="detail-row">
          <p><strong>Rental Period:</strong></p>
          <p>${startDate} to ${endDate}</p>
        </div>

        <div class="detail-row">
          <p><strong>Price Breakdown:</strong></p>
          <p>NRs${vehicle.pricePerDay} × ${days} days = <span class="total-price">NRs${total}</span></p>
        </div>
      </div>
    </div>

    <form action="confirm-booking" method="post">
      <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">
      <input type="hidden" name="startDate" value="${startDate}">
      <input type="hidden" name="endDate" value="${endDate}">
      <input type="hidden" name="total" value="${total}">

      <h3>Payment Method</h3>
      <div class="payment-method">
        <div class="payment-option">
          <input type="radio" id="cod" name="paymentMethod" value="COD" checked>
          <label for="cod">Cash on Delivery (COD)</label>
        </div>
      </div>

      <div class="action-buttons">
        <a href="javascript:history.back()" class="back-link">← Back</a>
        <button type="submit" class="confirm-button">Confirm Booking</button>
      </div>
    </form>
  </section>
</div>
<jsp:include page="/WEB-INF/view/common/footer.jsp" />

</body>
</html>