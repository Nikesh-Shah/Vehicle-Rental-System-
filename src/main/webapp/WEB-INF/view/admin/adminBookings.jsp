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
    <style>
        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: #fff;
            margin: 10% auto;
            padding: 20px;
            border-radius: 8px;
            width: 40%;
            position: relative;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h3 {
            margin: 0;
        }

        .modal-close {
            cursor: pointer;
            font-size: 1.5em;
        }

        .modal-body .form-group {
            margin-bottom: 15px;
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
    </style>
</head>
<body>
<div class="admin-layout">
    <%@ include file="admin-sidebar.jsp" %>

    <div class="main-content">
        <div class="page-header">
            <h1>Manage Bookings</h1>
        </div>

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
                        <td><span class="status-badge status-${fn:toLowerCase(booking.status)}">${booking.status}</span></td>
                        <td>
                            <button class="action-btn edit-btn"
                                    data-booking-id="${booking.bookingId}"
                                    data-status="${booking.status}">
                                Edit
                            </button>

                            <form method="post"
                                  action="${pageContext.request.contextPath}/admin/bookings"
                                  style="display:inline">
                                <input type="hidden" name="action" value="delete"/>
                                <input type="hidden" name="bookingId" value="${booking.bookingId}"/>
                                <button type="submit" class="action-btn delete-btn"
                                        onclick="return confirm('Delete booking ${booking.bookingId}?')">
                                    Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Edit Modal -->
<div class="modal" id="booking-edit-modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Edit Booking</h3>
            <span class="modal-close" id="close-booking-edit-modal">&times;</span>
        </div>

        <div class="modal-body">
            <form id="booking-edit-form"
                  method="post"
                  action="${pageContext.request.contextPath}/admin/bookings">

                <input type="hidden" name="action" value="update"/>
                <input type="hidden" id="modal-booking-id" name="bookingId"/>

                <div class="form-group">
                    <label for="modal-status">Status</label>
                    <select id="modal-status" name="status" class="select">
                        <option value="Pending">Pending</option>
                        <option value="Confirmed">Confirmed</option>
                        <option value="Active">Active</option>
                        <option value="Completed">Completed</option>
                        <option value="Cancelled">Cancelled</option>
                    </select>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-outline" id="cancel-booking-edit-btn">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- JavaScript for Modal Logic -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const modal = document.getElementById('booking-edit-modal');

        function openModal() { modal.style.display = 'block'; }
        function closeModal() { modal.style.display = 'none'; }

        document.querySelectorAll('.edit-btn').forEach(button => {
            button.addEventListener('click', () => {
                document.getElementById('modal-booking-id').value = button.dataset.bookingId;
                document.getElementById('modal-status').value = button.dataset.status;
                openModal();
            });
        });

        document.getElementById('close-booking-edit-modal').addEventListener('click', closeModal);
        document.getElementById('cancel-booking-edit-btn').addEventListener('click', closeModal);

        window.onclick = function(event) {
            if (event.target === modal) {
                closeModal();
            }
        };
    });
</script>
</body>
</html>


