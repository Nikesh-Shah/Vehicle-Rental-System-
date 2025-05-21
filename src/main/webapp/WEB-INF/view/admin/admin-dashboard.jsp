<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
<div class="admin-layout">
  <div>
    <%@ include file="/WEB-INF/view/admin/admin-sidebar.jsp" %>

    <main class="main-content">
      <div class="dashboard-header">
        <h1>Dashboard Overview</h1>

        <div style="margin: 10px 0;">
          <button type="button" onclick="window.print()" style="padding: 8px 16px; font-size: 16px; cursor: pointer; border: none;border-radius: 5px">
            🖨️ Print Report
          </button>
        </div>
      </div>


      <div class="stats-container">
        <div class="stat-card">
          <div class="stat-card-inner">
            <div class="stat-content">
              <h6>Users</h6>
              <h2>${totalUsers}</h2>
            </div>
            <div class="stat-icon">
              <i class="bi bi-people"></i>
            </div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-card-inner">
            <div class="stat-content">
              <h6>Bookings</h6>
              <h2>${totalBookings}</h2>
            </div>
            <div class="stat-icon">
              <i class="bi bi-calendar-check"></i>
            </div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-card-inner">
            <div class="stat-content">
              <h6>Vehicles</h6>
              <h2>${totalVehicles}</h2>
            </div>
            <div class="stat-icon">
              <i class="bi bi-car-front"></i>
            </div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-card-inner">
            <div class="stat-content">
              <h6>Revenue</h6>
              <h2>NRs<fmt:formatNumber value="${totalRevenue}" maxFractionDigits="2"/></h2>
            </div>
            <div class="stat-icon">
              <i class="bi bi-cash-coin"></i>
            </div>
          </div>
        </div>
      </div>

      <!-- Recent Activity -->
      <div class="activity-section">
        <div class="activity-card">
          <div class="activity-header">
            <h5>Recent Bookings</h5>
            <a href="${pageContext.request.contextPath}/admin/bookings">View All</a>
          </div>
          <div class="activity-body">
            <table class="dashboard-table">
              <thead>
              <tr>
                <th>ID</th>
                <th>Status</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Total Amount</th>
                <th>User ID</th>
                <th>Vehicles</th>
              </tr>
              </thead>
              <tbody>
              <c:if test="${not empty recentBookings}">
                <c:forEach var="booking" items="${recentBookings}">
                  <tr>
                    <td>${booking.bookingId}</td>
                    <td>
                      <span class="status-badge status-${booking.status.toLowerCase()}">${booking.status}</span>
                    </td>
                    <td>${booking.startDate}</td>
                    <td>${booking.endDate}</td>
                    <td>NRs. <fmt:formatNumber value="${booking.totalAmount}" type="number" /></td>
                    <td>${booking.userId}</td>
                    <td>
                      <c:forEach var="vehicle" items="${booking.vehicles}">
                        ${vehicle.brand} ${vehicle.model} (ID: ${vehicle.vehicleId})<br/>
                      </c:forEach>
                    </td>
                  </tr>
                </c:forEach>
              </c:if>
              </tbody>
            </table>
          </div>
        </div>

        <div class="activity-card">
          <div class="activity-header">
            <h5>Recent Payments</h5>
            <a href="${pageContext.request.contextPath}/admin/payments">View All</a>
          </div>
          <div class="activity-body">
            <table class="dashboard-table">
              <thead>
              <tr>
                <th>Payment ID</th>
                <th>Customer</th>
                <th>Amount</th>
                <th>Booking Dates</th>
                <th>Status</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach items="${recentPayments}" var="payment">
                <tr>
                  <td><span class="payment-id">${payment.paymentId}</span></td>
                  <td><span class="customer-name">${payment.customerName}</span></td>
                  <td><span class="payment-amount">NRs<fmt:formatNumber value="${payment.amount}" maxFractionDigits="2"/></span></td>
                  <td>
                    <fmt:formatDate value="${payment.bookingStartDate}" pattern="MMM dd"/> -
                    <fmt:formatDate value="${payment.bookingEndDate}" pattern="MMM dd, yyyy"/>
                  </td>
                  <td>
                    <span class="status-badge status-${payment.status.toLowerCase()}">${payment.status}</span>
                  </td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </main>
  </div>
</div>
</body>
</html>