<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
  <style>
    .stat-card {
      transition: transform 0.3s;
    }
    .stat-card:hover {
      transform: translateY(-5px);
    }
  </style>
</head>
<body>
<div class="container-fluid">
  <div class="row">
    <%@ include file="/WEB-INF/view/admin/admin-sidebar.jsp" %>

    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
      <h1 class="h2 mb-4">Dashboard Overview</h1>

      <!-- Stats Cards -->
      <div class="row g-4 mb-4">
        <div class="col-md-3">
          <div class="card stat-card bg-primary text-white">
            <div class="card-body">
              <div class="d-flex justify-content-between align-items-center">
                <div>
                  <h6 class="card-title text-uppercase">Users</h6>
                  <h2 class="mb-0">${totalUsers}</h2>
                </div>
                <i class="bi bi-people-fill fs-1"></i>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card stat-card bg-success text-white">
            <div class="card-body">
              <div class="d-flex justify-content-between align-items-center">
                <div>
                  <h6 class="card-title text-uppercase">Bookings</h6>
                  <h2 class="mb-0">${totalBookings}</h2>
                </div>
                <i class="bi bi-calendar-check fs-1"></i>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card stat-card bg-info text-white">
            <div class="card-body">
              <div class="d-flex justify-content-between align-items-center">
                <div>
                  <h6 class="card-title text-uppercase">Vehicles</h6>
                  <h2 class="mb-0">${totalVehicles}</h2>
                </div>
                <i class="bi bi-car-front fs-1"></i>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card stat-card bg-warning text-dark">
            <div class="card-body">
              <div class="d-flex justify-content-between align-items-center">
                <div>
                  <h6 class="card-title text-uppercase">Revenue</h6>
                  <h2 class="mb-0"><fmt:formatNumber value="${totalRevenue}" type="currency"/></h2>
                </div>
                <i class="bi bi-cash-stack fs-1"></i>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Recent Activity -->
      <div class="row g-4">
        <div class="col-md-6">
          <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
              <h5 class="mb-0">Recent Bookings</h5>

              <a href="${pageContext.request.contextPath}/admin/admin-bookings" class="btn btn-sm btn-outline-primary">View All</a>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-hover">
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
                        <td>${booking.status}</td>
                        <td>${booking.startDate}</td>
                        <td>${booking.endDate}</td>
                        <td>${booking.totalAmount}</td>
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
          </div>
        </div>

        <div class="col-md-6">
          <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
              <h5 class="mb-0">Recent Payments</h5>
              <a href="admin/payments" class="btn btn-sm btn-outline-primary">View All</a>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-hover">
                  <thead>
                  <tr>
                    <th>ID</th>
                    <th>Amount</th>
                    <th>Method</th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach items="${recentPayments}" var="payment">
                    <tr>
                      <td>${payment.paymentId}</td>
                      <td><fmt:formatNumber value="${payment.paymentAmount}" type="currency"/></td>
                      <td>${payment.paymentMethod}</td>
                    </tr>
                  </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
