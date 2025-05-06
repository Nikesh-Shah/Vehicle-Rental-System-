<div class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse vh-100 sticky-top">
    <div class="position-sticky pt-3">
        <div class="text-center mb-4">
            <h4 class="text-white">Admin Panel</h4>
        </div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link text-white ${param.active == 'dashboard' ? 'active' : ''}"
                href="${pageContext.request.contextPath}/admin-dashboard">Dashboard
                    <i class="bi bi-speedometer2 me-2"></i>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white ${param.active == 'admin-users' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/admin-users">
                    <i class="bi bi-people me-2"></i> Users
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white ${param.active == 'bookings' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/admin-booking">
                    <i class="bi bi-calendar-check me-2"></i> Bookings
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white ${param.active == 'vehicles' ? 'active' : ''}"

                   href="${pageContext.request.contextPath}/admin-vehicles">
                    <i class="bi bi-car-front me-2"></i> Vehicles
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white ${param.active == 'categories' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/admin/categories">
                    <i class="bi bi-tags me-2"></i> Categories
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white ${param.active == 'payments' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/admin/payments">
                    <i class="bi bi-cash-coin me-2"></i> Payments
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white ${param.active == 'reports' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/admin/reports">
                    <i class="bi bi-graph-up me-2"></i> Reports
                </a>
            </li>
            <li class="nav-item mt-4">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/logout">
                    <i class="bi bi-box-arrow-right me-2"></i> Logout
                </a>
            </li>
        </ul>
    </div>
</div>