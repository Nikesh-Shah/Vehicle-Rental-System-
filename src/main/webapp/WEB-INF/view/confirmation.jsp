<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Booking Confirmed</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/confirmation.css" />

</head>
<body>
<%@ include file="/WEB-INF/view/common/navbar.jsp" %>
<section>
<h1>Booking Confirmed!</h1>
<p>Your booking ID: ${param.bookingId}</p>
  <p>Thank you for choosing our service!</p>
  <a href="${pageContext.request.contextPath}/" >Return to Home</a>
</section>
<jsp:include page="/WEB-INF/view/common/footer.jsp" />
</body>
</html>