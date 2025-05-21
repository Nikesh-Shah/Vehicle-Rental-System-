<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Confirm Booking</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/payment.css" />
</head>
<body>
<%@ include file="/WEB-INF/view/common/navbar.jsp" %>


<section style="margin-top: 10px">

<div class="summary">
  <h2>Booking Summary</h2>
  <img src="${vehicle.image}" alt="${vehicle.brand} ${vehicle.model}">
  <h3>${vehicle.brand} ${vehicle.model}</h3>

  <div class="details">
    <p><strong>Rental Period:</strong>
      ${startDate} to ${endDate}</p>

    <p><strong>Price Breakdown:</strong>
      NRs${vehicle.pricePerDay} × ${days} days = NRs${total}</p>
  </div>
</div>

<form action="confirm-booking" method="post">
  <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">
  <input type="hidden" name="startDate" value="${startDate}">
  <input type="hidden" name="endDate" value="${endDate}">
  <input type="hidden" name="total" value="${total}">

  <h3>Payment Method</h3>
  <div class="payment-method">
    <input type="radio" id="cod" name="paymentMethod" value="COD" checked>
    <label for="cod">Cash on Delivery (COD)</label>
  </div>

  <button type="submit">Confirm Booking</button>
</form>
</section>
<jsp:include page="/WEB-INF/view/common/footer.jsp" />


</body>

</html>