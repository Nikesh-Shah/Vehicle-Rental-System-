<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <%@ include file="admin-sidebar.jsp" %>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Booking Management</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="btn-group me-2">
                        <button class="btn btn-sm btn-outline-secondary">Export</button>
                    </div>
                </div>
            </div>

            <c:if test="${not empty param.success}">
                <div class="alert alert-success alert-dismissible fade show">
                        ${param.success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger alert-dismissible fade show">
                        ${param.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Customer</th>
                        <th>Dates</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${bookings}" var="booking">
                        <tr>
                            <td>${booking.bookingId}</td>
                            <td>${booking.customerName}</td>
                            <td>
                                <fmt:formatDate value="${booking.startDate}" pattern="MMM d"/> -
                                <fmt:formatDate value="${booking.endDate}" pattern="MMM d, yyyy"/>
                            </td>
                            <td><fmt:formatNumber value="${booking.totalAmount}" type="currency"/></td>
                            <td>
                                <form action="admin/update-booking" method="post" class="d-inline">
                                    <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                    <select name="status" class="form-select form-select-sm" onchange="this.form.submit()">
                                        <option value="Pending" ${booking.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                        <option value="Confirmed" ${booking.status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                                        <option value="Cancelled" ${booking.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                        <option value="Completed" ${booking.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                    </select>
                                </form>
                            </td>
                            <td>
                                <button class="btn btn-sm btn-outline-info" data-bs-toggle="modal"
                                        data-bs-target="#bookingDetailsModal" data-bookingid="${booking.bookingId}">
                                    <i class="bi bi-eye"></i> Details
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${currentPage - 1}">Previous</a>
                    </li>
                    <c:forEach begin="1" end="10" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item">
                        <a class="page-link" href="?page=${currentPage + 1}">Next</a>
                    </li>
                </ul>
            </nav>
        </main>
    </div>
</div>

<!-- Booking Details Modal -->
<div class="modal fade" id="bookingDetailsModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Booking Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div id="bookingDetailsContent"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Booking details modal
    document.getElementById('bookingDetailsModal').addEventListener('show.bs.modal', function(event) {
        const button = event.relatedTarget;
        const bookingId = button.getAttribute('data-bookingid');

        // Fetch booking details via AJAX
        fetch('api/bookings/' + bookingId)
            .then(response => response.json())
            .then(data => {
                const statusBadge = data.status === 'Confirmed' ? 'success' :
                    data.status === 'Pending' ? 'warning' : 'danger';

                let vehiclesList = '';
                data.vehicles.forEach(vehicle => {
                    vehiclesList += '<li class="list-group-item">' +
                        vehicle.brand + ' ' + vehicle.model + ' - $' +
                        vehicle.pricePerDay + '/day</li>';
                });

                const html = '<div class="row">' +
                    '<div class="col-md-6">' +
                    '<h5>Booking Information</h5>' +
                    '<p><strong>ID:</strong> ' + data.bookingId + '</p>' +
                    '<p><strong>Customer:</strong> ' + data.customerName + '</p>' +
                    '<p><strong>Dates:</strong> ' +
                    new Date(data.startDate).toLocaleDateString() + ' - ' +
                    new Date(data.endDate).toLocaleDateString() + '</p>' +
                    '<p><strong>Status:</strong> <span class="badge bg-' + statusBadge + '">' +
                    data.status + '</span></p>' +
                    '<p><strong>Total Amount:</strong> $' + data.totalAmount.toFixed(2) + '</p>' +
                    '</div>' +
                    '<div class="col-md-6">' +
                    '<h5>Vehicles</h5>' +
                    '<ul class="list-group">' + vehiclesList + '</ul>' +
                    '</div>' +
                    '</div>';

                document.getElementById('bookingDetailsContent').innerHTML = html;
            })
            .catch(error => {
                document.getElementById('bookingDetailsContent').innerHTML =
                    '<div class="alert alert-danger">' +
                    'Failed to load booking details: ' + error.message +
                    '</div>';
            });
    });
</script>

</body>
</html>