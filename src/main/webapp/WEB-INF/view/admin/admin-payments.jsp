<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <%@ include file="admin-sidebar.jsp" %>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Payment Management</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="btn-group me-2">
                        <button class="btn btn-sm btn-outline-secondary">Export</button>
                    </div>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Booking ID</th>
                        <th>Amount</th>
                        <th>Method</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${payments}" var="payment">
                        <tr>
                            <td>${payment.paymentId}</td>
                            <td>${payment.bookingId}</td>
                            <td><fmt:formatNumber value="${payment.paymentAmount}" type="currency"/></td>
                            <td>${payment.paymentMethod}</td>
                            <td><fmt:formatDate value="${payment.paymentDate}" pattern="MMM d, yyyy"/></td>
                            <td>
                                        <span class="badge bg-${payment.paymentStatus == 'Completed' ? 'success' :
                                                               payment.paymentStatus == 'Pending' ? 'warning' : 'danger'}">
                                                ${payment.paymentStatus}
                                        </span>
                            </td>
                            <td>
                                <button class="btn btn-sm btn-outline-info" data-bs-toggle="modal"
                                        data-bs-target="#paymentDetailsModal" data-paymentid="${payment.paymentId}">
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

<!-- Payment Details Modal -->
<div class="modal fade" id="paymentDetailsModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Payment Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div id="paymentDetailsContent">
                    <!-- Will be populated by JavaScript -->
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Payment details modal
    document.getElementById('paymentDetailsModal').addEventListener('show.bs.modal', function(event) {
        const button = event.relatedTarget;
        const paymentId = button.getAttribute('data-paymentid');

        // Here you would fetch payment details via AJAX
        // For now, we'll show a loading message
        document.getElementById('paymentDetailsContent').innerHTML = `
                <div class="text-center">
                    <div class="spinner-border" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p>Loading payment details...</p>
                </div>
            `;

        // Simulate AJAX call
        setTimeout(() => {
            document.getElementById('paymentDetailsContent').innerHTML =
                '<p><strong>Payment ID:</strong> ' + paymentId + '</p>' +
                '<p><strong>Booking ID:</strong> 123</p>' +
                '<p><strong>Amount:</strong> $150.00</p>' +
                '<p><strong>Method:</strong> COD</p>' +
                '<p><strong>Date:</strong> ' + new Date().toLocaleDateString() + '</p>' +
                '<p><strong>Status:</strong> Completed</p>';
        }, 1000);
    });
</script>
</body>
</html>