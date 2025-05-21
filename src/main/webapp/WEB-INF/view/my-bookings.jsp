
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
  <title>My Bookings</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/my-bookings.css" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%@ include file="/WEB-INF/view/common/navbar.jsp" %>

<div class="container-my-bookings">
  <h1>My Bookings</h1>

  <h2>Current Bookings</h2>
  <c:choose>
    <c:when test="${empty currentBookings}">
      <p class="P">No current bookings found.</p>
    </c:when>
    <c:otherwise>
      <table>
        <thead>
        <tr>
          <th>Booking ID</th>
          <th>Start Date</th>
          <th>End Date</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${currentBookings}" var="booking">
          <tr>
            <td data-label="Booking ID">${booking.bookingId}</td>
            <td data-label="Start Date"><fmt:formatDate value="${booking.startDate}" pattern="yyyy-MM-dd" /></td>
            <td data-label="End Date"><fmt:formatDate value="${booking.endDate}" pattern="yyyy-MM-dd" /></td>
            <td data-label="Status">${booking.status}</td>
            <td data-label="Actions">
              <!-- Cancel Booking -->
              <form action="${pageContext.request.contextPath}/booking" method="post">
                <input type="hidden" name="action" value="cancel">
                <input type="hidden" name="bookingId" value="${booking.bookingId}">
                <input type="submit" value="Cancel">
              </form>

              <!-- Update Booking -->
              <form action="${pageContext.request.contextPath}/booking" method="post" class="update-form">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="bookingId" value="${booking.bookingId}">
                <div class="date-inputs">
                  <label>
                    New Start:
                    <input type="date" name="startDate" required
                           value="<fmt:formatDate value='${booking.startDate}' pattern='yyyy-MM-dd' />">
                  </label>
                  <label>
                    New End:
                    <input type="date" name="endDate" required
                           value="<fmt:formatDate value='${booking.endDate}' pattern='yyyy-MM-dd' />">
                  </label>
                </div>
                <input type="submit" value="Update">
              </form>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </c:otherwise>
  </c:choose>

  <!-- PREVIOUS BOOKINGS -->
  <h2>Previous Bookings</h2>
  <c:choose>
    <c:when test="${empty previousBookings}">
      <p class="P">No previous bookings found.</p>
    </c:when>
    <c:otherwise>
      <table>
        <thead>
        <tr>
          <th>Booking ID</th>
          <th>Start Date</th>
          <th>End Date</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${previousBookings}" var="booking">
          <tr>
            <td data-label="Booking ID">${booking.bookingId}</td>
            <td data-label="Start Date"><fmt:formatDate value="${booking.startDate}" pattern="yyyy-MM-dd" /></td>
            <td data-label="End Date"><fmt:formatDate value="${booking.endDate}" pattern="yyyy-MM-dd" /></td>
            <td data-label="Status">${booking.status}</td>
            <td data-label="Actions">
              <!-- Only allow Delete for previous bookings -->
              <form action="${pageContext.request.contextPath}/booking" method="post">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="bookingId" value="${booking.bookingId}">
                <input type="submit" value="Delete">
              </form>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </c:otherwise>
  </c:choose>
</div>

<jsp:include page="/WEB-INF/view/common/footer.jsp" />
</body>
</html>
