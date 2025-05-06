<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Booking Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        /* Optional fallback styles in case CSS file doesn't load */
        .content-wrapper { padding: 20px; font-family: Arial, sans-serif; }
        .page-title { font-size: 24px; margin-bottom: 20px; }
        .bookings-table { width: 100%; border-collapse: collapse; }
        .bookings-table th, .bookings-table td { border: 1px solid #ddd; padding: 8px; text-align: center; }
        .update-button { padding: 5px 10px; margin-top: 5px; }
        .status-form { display: flex; flex-direction: column; align-items: center; }
        .status-select { padding: 5px; }
    </style>
</head>
<body>

 <%@ include file="admin-sidebar.jsp" %>

<div class="content-wrapper">
    <h1 class="page-title">Booking Management</h1>

    <table class="bookings-table">
        <thead>
        <tr>
            <th>Booking ID</th>
            <th>User ID</th>
            <th>Vehicle ID</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="booking" items="${bookings}">
            <tr>
                <td>${booking.id}</td>
                <td>${booking.userId}</td>
                <td>${booking.vehicleId}</td>
                <td class="status-${fn:toLowerCase(booking.status)}">${booking.status}</td>
                <td>
                    <form method="post" action="${pageContext.request.contextPath}/admin-booking" class="status-form">
                        <input type="hidden" name="bookingId" value="${booking.id}" />
                        <select name="status" class="status-select">
                            <option value="Pending" ${booking.status == 'Pending' ? 'selected' : ''}>Pending</option>
                            <option value="Confirmed" ${booking.status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                            <option value="Cancelled" ${booking.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                        </select>
                        <button type="submit" class="update-button">Update</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
