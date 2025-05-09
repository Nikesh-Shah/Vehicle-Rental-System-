<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin - Manage Bookings</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/booking-management.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
<div class="admin-layout">
    <%@ include file="admin-sidebar.jsp" %>

    <div class="main-content">
        <div class="page-header">
            <h1>Manage Bookings</h1>
        </div>

        <div class="status-filter">
            <a href="?" class="${empty param.status ? 'active' : ''}">
                <i class="bi bi-grid-3x3-gap"></i> All
            </a>
            <c:forEach items="${['Pending','Confirmed','Active','Completed','Cancelled']}" var="status">
                <a href="?status=${status}" class="${param.status eq status ? 'active' : ''}">
                    <c:choose>
                        <c:when test="${status eq 'Pending'}"><i class="bi bi-hourglass-split"></i></c:when>
                        <c:when test="${status eq 'Confirmed'}"><i class="bi bi-check-circle"></i></c:when>
                        <c:when test="${status eq 'Active'}"><i class="bi bi-play-circle"></i></c:when>
                        <c:when test="${status eq 'Completed'}"><i class="bi bi-trophy"></i></c:when>
                        <c:when test="${status eq 'Cancelled'}"><i class="bi bi-x-circle"></i></c:when>
                    </c:choose>
                        ${status}
                </a>
            </c:forEach>
        </div>

        <c:choose>
            <c:when test="${empty bookings}">
                <div class="no-bookings">
                    <i class="bi bi-calendar-x"></i>
                    No bookings found matching the criteria
                </div>
            </c:when>
            <c:otherwise>
                <div class="booking-table-container">
                    <table class="booking-table">
                        <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>User</th>
                            <th>Vehicles</th>
                            <th>Dates</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${bookings}" var="booking">
                            <tr>
                                <td><span class="booking-id">#${booking.bookingId}</span></td>
                                <td>
                                    <div class="user-info">
                                        <span class="user-name">${booking.user.fname} ${booking.user.lname}</span>
                                        <span class="user-email">${booking.user.email}</span>
                                    </div>
                                </td>
                                <td>
                                    <ul class="vehicle-list">
                                        <c:forEach items="${booking.vehicles}" var="vehicle">
                                            <li>${vehicle.brand} ${vehicle.model}</li>
                                        </c:forEach>
                                    </ul>
                                </td>
                                <td>
                                    <fmt:formatDate value="${booking.startDate}" pattern="MMM dd"/> to
                                    <fmt:formatDate value="${booking.endDate}" pattern="MMM dd, yyyy"/>
                                </td>
                                <td><span class="price">NRs <fmt:formatNumber value="${booking.totalAmount}" maxFractionDigits="2"/></span></td>
                                <td>
                                    <span class="status-badge status-${fn:toLowerCase(booking.status)}">${booking.status}</span>
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/booking-action" method="post" class="status-form">
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                        <select name="status" class="status-select">
                                            <option value="Pending" ${booking.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                            <option value="Confirmed" ${booking.status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                                            <option value="Active" ${booking.status == 'Active' ? 'selected' : ''}>Active</option>
                                            <option value="Completed" ${booking.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                            <option value="Cancelled" ${booking.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                        </select>
                                        <button type="submit" class="update-btn">
                                            <i class="bi bi-check2"></i> Update
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>