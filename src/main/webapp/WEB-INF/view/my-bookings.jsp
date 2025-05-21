<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
  <title>My Bookings</title>
</head>
<body>
<%@ include file="/WEB-INF/view/common/navbar.jsp" %>

<h1>My Bookings</h1>

<!-- CURRENT BOOKINGS -->
<h2>Current Bookings</h2>
<c:choose>
  <c:when test="${empty currentBookings}">
    <p>No current bookings found.</p>
  </c:when>
  <c:otherwise>
    <table border="1">
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
          <td>${booking.bookingId}</td>
          <td><fmt:formatDate value="${booking.startDate}" pattern="yyyy-MM-dd" /></td>
          <td><fmt:formatDate value="${booking.endDate}" pattern="yyyy-MM-dd" /></td>
          <td>${booking.status}</td>
          <td>
            <!-- Cancel Booking -->
            <form action="${pageContext.request.contextPath}/booking" method="post">
              <input type="hidden" name="action" value="cancel">
              <input type="hidden" name="bookingId" value="${booking.bookingId}">
              <input type="submit" value="Cancel">
            </form>

            <!-- Delete Booking -->
            <form action="${pageContext.request.contextPath}/booking" method="post">
              <input type="hidden" name="action" value="delete">
              <input type="hidden" name="bookingId" value="${booking.bookingId}">
              <input type="submit" value="Delete">
            </form>

            <!-- Update Booking -->
            <form action="${pageContext.request.contextPath}/booking" method="post">
              <input type="hidden" name="action" value="update">
              <input type="hidden" name="bookingId" value="${booking.bookingId}">
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
              <input type="submit" value="Update">
            </form>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </c:otherwise>
</c:choose>

<br>

<!-- PREVIOUS BOOKINGS -->
<h2>Previous Bookings</h2>
<c:choose>
  <c:when test="${empty previousBookings}">
    <p>No previous bookings found.</p>
  </c:when>
  <c:otherwise>
    <table border="1">
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
          <td>${booking.bookingId}</td>
          <td><fmt:formatDate value="${booking.startDate}" pattern="yyyy-MM-dd" /></td>
          <td><fmt:formatDate value="${booking.endDate}" pattern="yyyy-MM-dd" /></td>
          <td>${booking.status}</td>
          <td>
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

</body>
</html>
