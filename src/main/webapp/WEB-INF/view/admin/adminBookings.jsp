<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Manage Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .vehicle-list { list-style: none; padding-left: 0; }
        .status-badge { font-size: 0.9rem; padding: 0.35em 0.65em; }
    </style>
</head>
<body>
<%@ include file="admin-sidebar.jsp" %>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1>Manage Bookings</h1>
        <div class="btn-group">
            <a href="?status" class="btn btn-outline-secondary ${statusFilter eq 'all' ? 'active' : ''}">All</a>
            <c:forEach items="${['Pending','Confirmed','Active','Completed','Cancelled']}" var="status">
                <a href="?status=${status}"
                   class="btn btn-outline-secondary ${statusFilter eq status ? 'active' : ''}">
                        ${status}
                </a>
            </c:forEach>
        </div>
    </div>

    <c:choose>
        <c:when test="${empty bookings}">
            <div class="alert alert-info">No bookings found matching the criteria</div>
        </c:when>
        <c:otherwise>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
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
                            <td>#${booking.bookingId}</td>
                            <td>
                                <div class="fw-bold">${booking.user.fname} ${booking.user.lname}</div>
                                <div class="text-muted small">${booking.user.email}</div>
                            </td>
                            <td>
                                <ul class="vehicle-list">
                                    <c:forEach items="${booking.vehicles}" var="vehicle">
                                        <li>${vehicle.brand} ${vehicle.model}</li>
                                    </c:forEach>
                                </ul>
                            </td>
                            <td>
                                <div class="text-nowrap">
                                    <fmt:formatDate value="${booking.startDate}" pattern="MMM dd"/><br>
                                    <span class="text-muted">to</span><br>
                                    <fmt:formatDate value="${booking.endDate}" pattern="MMM dd, yyyy"/>
                                </div>
                            </td>
                            <td class="text-nowrap">
                                $<fmt:formatNumber value="${booking.totalAmount}" maxFractionDigits="2"/>
                            </td>
                            <td>
                                <span class="badge status-badge
                                    ${booking.status == 'Pending' ? 'bg-warning' :
                                     booking.status == 'Confirmed' ? 'bg-primary' :
                                     booking.status == 'Active' ? 'bg-success' :
                                     booking.status == 'Completed' ? 'bg-secondary' : 'bg-danger'}">
                                        ${booking.status}
                                </span>
                            </td>
                            <td>
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle"
                                            type="button" data-bs-toggle="dropdown">
                                        Actions
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <!-- Corrected action value from 'update-status' to 'update' -->
                                            <form action="${pageContext.request.contextPath}/admin/booking-action" method="post">
                                                <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                                <div class="px-3 py-2">
                                                    <select name="status" class="form-select form-select-sm"
                                                            onchange="this.form.submit()">
                                                        <option value="">Change Status</option>
                                                        <c:forEach items="${['Pending','Confirmed','Active','Completed','Cancelled']}" var="status">
                                                            <option ${booking.status eq status ? 'selected' : ''}>
                                                                    ${status}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                    <input type="hidden" name="action" value="update">
                                                </div>
                                            </form>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <form action="${pageContext.request.contextPath}/admin/booking-action" method="post">
                                                <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                                <input type="hidden" name="action" value="cancel">
                                                <button type="submit" class="dropdown-item text-danger">
                                                    Cancel Booking
                                                </button>
                                            </form>
                                        </li>
                                        <li>
                                            <form action="${pageContext.request.contextPath}/admin/booking-action" method="post">
                                                <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                                <input type="hidden" name="action" value="delete">
                                                <button type="submit" class="dropdown-item text-danger">
                                                    Delete Permanently
                                                </button>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>