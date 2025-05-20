<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/sidebar.css">
</head>
<body>
<div class="sidebar-container">
    <div class="sidebar-wrapper">
        <div class="sidebar-header">
            <h4>GoRent Admin Panel</h4>
        </div>

        <% String currentUri = request.getRequestURI(); %>

        <div class="sidebar-nav">
            <ul>
                <li>
                    <a href="${pageContext.request.contextPath}/admin-dashboard"
                       class="<%= currentUri.contains("/admin-dashboard") ? "active" : "" %>">
                        <i class="bi bi-speedometer2"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin-users"
                       class="<%= currentUri.contains("/admin-users") ? "active" : "" %>">
                        <i class="bi bi-people"></i>
                        <span>Users</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/bookings"
                       class="<%= currentUri.contains("/admin/bookings") ? "active" : "" %>">
                        <i class="bi bi-calendar-check"></i>
                        <span>Bookings</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin-vehicles"
                       class="<%= currentUri.contains("/admin-vehicles") ? "active" : "" %>">
                        <i class="bi bi-car-front"></i>
                        <span>Vehicles</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/categories"
                       class="<%= currentUri.contains("/admin/categories") ? "active" : "" %>">
                        <i class="bi bi-tags"></i>
                        <span>Categories</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/payments"
                       class="<%= currentUri.contains("/admin/payments") ? "active" : "" %>">
                        <i class="bi bi-cash-coin"></i>
                        <span>Payments</span>
                    </a>
                </li>
                <li>
                    <form action="${pageContext.request.contextPath}/logout" method="post">
                        <button type="submit">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Logout</span>
                        </button>
                    </form>
                </li>
            </ul>
        </div>
    </div>
</div>


</body>
</html>