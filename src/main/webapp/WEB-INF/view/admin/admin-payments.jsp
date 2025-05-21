<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/payment-management.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
<div class="admin-layout">
    <%@ include file="/WEB-INF/view/admin/admin-sidebar.jsp" %>

    <div class="main-content">
        <div class="page-header">
            <h1>Payment Management</h1>
            <div style="margin: 10px 0;">
                <button type="button" onclick="window.print()" style="padding: 8px 16px; font-size: 16px; cursor: pointer; border: none; border-radius: 5px">
                    🖨️ Print Report
                </button>
            </div>

        </div>

        <!-- Payment Summary Cards -->
        <div class="payment-summary">
            <div class="summary-card">
                <div class="summary-card-inner">
                    <div class="summary-content">
                        <h6>Total Revenue</h6>
                        <h2>NRs<fmt:formatNumber value="${totalRevenue}" maxFractionDigits="2"/></h2>
                    </div>
                    <div class="summary-icon">
                        <i class="bi bi-cash-coin"></i>
                    </div>
                </div>
            </div>

            <div class="summary-card">
                <div class="summary-card-inner">
                    <div class="summary-content">
                        <h6>Completed Payments</h6>
                        <h2>${totalCompletedRevenue}</h2>
                    </div>
                    <div class="summary-icon">
                        <i class="bi bi-check-circle"></i>
                    </div>
                </div>
            </div>

            <div class="summary-card">
                <div class="summary-card-inner">
                    <div class="summary-content">
                        <h6>Pending Payments</h6>
                        <h2>${totalPendingRevenue}</h2>
                    </div>
                    <div class="summary-icon">
                        <i class="bi bi-hourglass-split"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <form class="search-form" action="${pageContext.request.contextPath}/admin/payments" method="get">
                <input type="text" name="search" placeholder="Search payments..." class="search-input">
                <button type="submit" class="search-button">
                    <i class="bi bi-search"></i>
                </button>
            </form>

            <div class="filter-group">
                <span class="filter-label">Status:</span>
                <select class="filter-select" name="status" onchange="this.form.submit()">
                    <option value="">All Statuses</option>
                    <option value="Completed">Completed</option>
                    <option value="Pending">Pending</option>
                    <option value="Failed">Failed</option>
                    <option value="Refunded">Refunded</option>
                </select>
            </div>

            <div class="filter-group">
                <span class="filter-label">Date Range:</span>
                <select class="filter-select" name="dateRange" onchange="this.form.submit()">
                    <option value="all">All Time</option>
                    <option value="today">Today</option>
                    <option value="week">This Week</option>
                    <option value="month">This Month</option>
                    <option value="year">This Year</option>
                </select>
            </div>
        </div>

        <!-- Payment Table -->
        <div class="payment-table-container">
            <table class="payment-table">
                <thead>
                <tr>
                    <th>Payment ID</th>
                    <th>Customer</th>
                    <th>Amount</th>
                    <th>Method</th>
                    <th>Booking Dates</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${payments}" var="payment">
                    <tr>
                        <td><span class="payment-id">${payment.paymentId}</span></td>
                        <td><span class="customer-name">${payment.customerName}</span></td>
                        <td><span class="payment-amount">NRs<fmt:formatNumber value="${payment.amount}" maxFractionDigits="2"/></span></td>
                        <td>${payment.method}</td>
                        <td>
                            <fmt:formatDate value="${payment.bookingStartDate}" pattern="MMM dd"/> -
                            <fmt:formatDate value="${payment.bookingEndDate}" pattern="MMM dd, yyyy"/>
                        </td>
                        <td>
                            <span class="status-badge ${payment.status.toLowerCase()}">${payment.status}</span>
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/admin/payments" method="post" class="status-form">
                                <input type="hidden" name="paymentId" value="${payment.paymentId}"/>
                                <select name="status" class="status-select">
                                    <option value="Pending" ${payment.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                    <option value="Completed" ${payment.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                    <option value="Failed" ${payment.status == 'Failed' ? 'selected' : ''}>Failed</option>
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

        <div class="pagination">
            <a href="?page=${currentPage - 1}" class="page-link ${currentPage <= 1 ? 'disabled' : ''}">
                <i class="bi bi-chevron-left"></i> Previous
            </a>

            <c:forEach begin="1" end="${totalPages > 5 ? 5 : totalPages}" var="i">
                <a href="?page=${i}" class="page-link ${currentPage == i ? 'active' : ''}">${i}</a>
            </c:forEach>

            <a href="?page=${currentPage + 1}" class="page-link ${currentPage >= totalPages ? 'disabled' : ''}">
                Next <i class="bi bi-chevron-right"></i>
            </a>
        </div>
    </div>
</div>
</body>
</html>