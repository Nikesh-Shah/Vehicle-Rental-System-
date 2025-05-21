
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--  <title>My Bookings</title>--%>
<%--  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/my-bookings.css" />--%>
<%--  <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--</head>--%>
<%--<body>--%>
<%--<%@ include file="/WEB-INF/view/common/navbar.jsp" %>--%>

<%--<div class="container-my-bookings">--%>
<%--  <h1>My Bookings</h1>--%>

<%--  <h2>Current Bookings</h2>--%>
<%--  <c:choose>--%>
<%--    <c:when test="${empty currentBookings}">--%>
<%--      <p class="P">No current bookings found.</p>--%>
<%--    </c:when>--%>
<%--    <c:otherwise>--%>
<%--      <table>--%>
<%--        <thead>--%>
<%--        <tr>--%>
<%--          <th>Booking ID</th>--%>
<%--          <th>Start Date</th>--%>
<%--          <th>End Date</th>--%>
<%--          <th>Status</th>--%>
<%--          <th>Actions</th>--%>
<%--        </tr>--%>
<%--        </thead>--%>
<%--        <tbody>--%>
<%--        <c:forEach items="${currentBookings}" var="booking">--%>
<%--          <tr>--%>
<%--            <td data-label="Booking ID">${booking.bookingId}</td>--%>
<%--            <td data-label="Start Date"><fmt:formatDate value="${booking.startDate}" pattern="yyyy-MM-dd" /></td>--%>
<%--            <td data-label="End Date"><fmt:formatDate value="${booking.endDate}" pattern="yyyy-MM-dd" /></td>--%>
<%--            <td data-label="Status">${booking.status}</td>--%>
<%--            <td data-label="Actions">--%>
<%--              <form action="${pageContext.request.contextPath}/booking" method="post">--%>
<%--                <input type="hidden" name="action" value="cancel">--%>
<%--                <input type="hidden" name="bookingId" value="${booking.bookingId}">--%>
<%--                <input type="submit" value="Cancel">--%>
<%--              </form>--%>

<%--              <!-- Update Booking -->--%>
<%--              <form action="${pageContext.request.contextPath}/booking" method="post" class="update-form">--%>
<%--                <input type="hidden" name="action" value="update">--%>
<%--                <input type="hidden" name="bookingId" value="${booking.bookingId}">--%>
<%--                <div class="date-inputs">--%>
<%--                  <label>--%>
<%--                    New Start:--%>
<%--                    <input type="date" name="startDate" required--%>
<%--                           value="<fmt:formatDate value='${booking.startDate}' pattern='yyyy-MM-dd' />">--%>
<%--                  </label>--%>
<%--                  <label>--%>
<%--                    New End:--%>
<%--                    <input type="date" name="endDate" required--%>
<%--                           value="<fmt:formatDate value='${booking.endDate}' pattern='yyyy-MM-dd' />">--%>
<%--                  </label>--%>
<%--                </div>--%>
<%--                <input type="submit" value="Update">--%>
<%--              </form>--%>
<%--            </td>--%>
<%--          </tr>--%>
<%--        </c:forEach>--%>
<%--        </tbody>--%>
<%--      </table>--%>
<%--    </c:otherwise>--%>
<%--  </c:choose>--%>

<%--  <!-- PREVIOUS BOOKINGS -->--%>
<%--  <h2>Previous Bookings</h2>--%>
<%--  <c:choose>--%>
<%--    <c:when test="${empty previousBookings}">--%>
<%--      <p class="P">No previous bookings found.</p>--%>
<%--    </c:when>--%>
<%--    <c:otherwise>--%>
<%--      <table>--%>
<%--        <thead>--%>
<%--        <tr>--%>
<%--          <th>Booking ID</th>--%>
<%--          <th>Start Date</th>--%>
<%--          <th>End Date</th>--%>
<%--          <th>Status</th>--%>
<%--          <th>Actions</th>--%>
<%--        </tr>--%>
<%--        </thead>--%>
<%--        <tbody>--%>
<%--        <c:forEach items="${previousBookings}" var="booking">--%>
<%--          <tr>--%>
<%--            <td data-label="Booking ID">${booking.bookingId}</td>--%>
<%--            <td data-label="Start Date"><fmt:formatDate value="${booking.startDate}" pattern="yyyy-MM-dd" /></td>--%>
<%--            <td data-label="End Date"><fmt:formatDate value="${booking.endDate}" pattern="yyyy-MM-dd" /></td>--%>
<%--            <td data-label="Status">${booking.status}</td>--%>
<%--            <td data-label="Actions">--%>
<%--              <!-- Only allow Delete for previous bookings -->--%>
<%--              <form action="${pageContext.request.contextPath}/booking" method="post">--%>
<%--                <input type="hidden" name="action" value="delete">--%>
<%--                <input type="hidden" name="bookingId" value="${booking.bookingId}">--%>
<%--                <input type="submit" value="Delete">--%>
<%--              </form>--%>
<%--            </td>--%>
<%--          </tr>--%>
<%--        </c:forEach>--%>
<%--        </tbody>--%>
<%--      </table>--%>
<%--    </c:otherwise>--%>
<%--  </c:choose>--%>
<%--</div>--%>

<%--<jsp:include page="/WEB-INF/view/common/footer.jsp" />--%>
<%--</body>--%>
<%--</html>--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
  <title>My Bookings</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/my-bookings.css" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%@ include file="/WEB-INF/view/common/navbar.jsp" %>

<div class="container-my-bookings">
  <h1>My Bookings</h1>

  <h2>Current Bookings</h2>
  <c:choose>
    <c:when test="${empty currentBookings}">
      <p class="P">No current bookings found.</p>
    </c:when>
    <c:otherwise>
      <table>
        <thead>
        <tr>
          <th>Booking ID</th>
          <th>Start Date</th>
          <th>End Date</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${currentBookings}" var="booking">
          <tr>
            <td data-label="Booking ID">${booking.bookingId}</td>
            <td data-label="Start Date"><fmt:formatDate value="${booking.startDate}" pattern="yyyy-MM-dd" /></td>
            <td data-label="End Date"><fmt:formatDate value="${booking.endDate}" pattern="yyyy-MM-dd" /></td>
            <td data-label="Status">${booking.status}</td>
            <td data-label="Actions">
              <!-- Cancel Button -->
              <button class="action-btn"
                      onclick="showConfirmModal('cancel', ${booking.bookingId}, 'Are you sure you want to cancel this booking?')">
                Cancel
              </button>

              <!-- Update Button -->
              <button class="action-btn update-btn"
                      onclick="showUpdateModal(${booking.bookingId},
                              '<fmt:formatDate value='${booking.startDate}' pattern='yyyy-MM-dd' />',
                              '<fmt:formatDate value='${booking.endDate}' pattern='yyyy-MM-dd' />')">
                Update
              </button>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </c:otherwise>
  </c:choose>

  <!-- PREVIOUS BOOKINGS -->
  <h2>Previous Bookings</h2>
  <c:choose>
    <c:when test="${empty previousBookings}">
      <p class="P">No previous bookings found.</p>
    </c:when>
    <c:otherwise>
      <table>
        <thead>
        <tr>
          <th>Booking ID</th>
          <th>Start Date</th>
          <th>End Date</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${previousBookings}" var="booking">
          <tr>
            <td data-label="Booking ID">${booking.bookingId}</td>
            <td data-label="Start Date"><fmt:formatDate value="${booking.startDate}" pattern="yyyy-MM-dd" /></td>
            <td data-label="End Date"><fmt:formatDate value="${booking.endDate}" pattern="yyyy-MM-dd" /></td>
            <td data-label="Status">${booking.status}</td>
            <td data-label="Actions">
              <!-- Delete Button -->
              <button class="action-btn delete-btn"
                      onclick="showConfirmModal('delete', ${booking.bookingId}, 'Are you sure you want to delete this booking?')">
                Delete
              </button>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </c:otherwise>
  </c:choose>
</div>

<!-- Confirmation Modal -->
<div id="confirmModal" class="modal-overlay">
  <div class="modal">
    <div class="modal-header">
      <h3 class="modal-title">Confirm Action</h3>
    </div>
    <div class="modal-body" id="confirmMessage">
      Are you sure you want to proceed?
    </div>
    <div class="modal-footer">
      <button class="modal-btn modal-btn-cancel" onclick="closeModal()">Cancel</button>
      <button class="modal-btn modal-btn-confirm" id="confirmBtn">Confirm</button>
    </div>
  </div>
</div>

<!-- Update Modal -->
<div id="updateModal" class="modal-overlay">
  <div class="modal">
    <div class="modal-header">
      <h3 class="modal-title">Update Booking</h3>
    </div>
    <div class="modal-body">
      <form id="updateForm" action="${pageContext.request.contextPath}/booking" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" id="updateBookingId" name="bookingId" value="">
        <div class="date-inputs">
          <label>
            New Start:
            <input type="date" id="updateStartDate" name="startDate" required>
          </label>
          <label>
            New End:
            <input type="date" id="updateEndDate" name="endDate" required>
          </label>
        </div>
      </form>
    </div>
    <div class="modal-footer">
      <button class="modal-btn modal-btn-cancel" onclick="closeModal()">Cancel</button>
      <button class="modal-btn modal-btn-confirm" onclick="submitUpdateForm()">Update</button>
    </div>
  </div>
</div>

<!-- Success Message -->
<div id="successMessage" class="success-message">
  Action completed successfully!
</div>

<!-- Hidden Forms for Actions -->
<form id="cancelForm" action="${pageContext.request.contextPath}/booking" method="post" style="display:none;">
  <input type="hidden" name="action" value="cancel">
  <input type="hidden" id="cancelBookingId" name="bookingId" value="">
</form>

<form id="deleteForm" action="${pageContext.request.contextPath}/booking" method="post" style="display:none;">
  <input type="hidden" name="action" value="delete">
  <input type="hidden" id="deleteBookingId" name="bookingId" value="">
</form>

<script>
  // Show confirmation modal
  function showConfirmModal(action, bookingId, message) {
    document.getElementById('confirmMessage').textContent = message;

    const confirmBtn = document.getElementById('confirmBtn');
    confirmBtn.onclick = function() {
      if (action === 'delete') {
        document.getElementById('deleteBookingId').value = bookingId;
        document.getElementById('deleteForm').submit();
      } else if (action === 'cancel') {
        document.getElementById('cancelBookingId').value = bookingId;
        document.getElementById('cancelForm').submit();
      }
    };

    document.getElementById('confirmModal').style.display = 'flex';
  }

  // Show update modal
  function showUpdateModal(bookingId, startDate, endDate) {
    document.getElementById('updateBookingId').value = bookingId;
    document.getElementById('updateStartDate').value = startDate;
    document.getElementById('updateEndDate').value = endDate;
    document.getElementById('updateModal').style.display = 'flex';
  }

  // Close any modal
  function closeModal() {
    document.getElementById('confirmModal').style.display = 'none';
    document.getElementById('updateModal').style.display = 'none';
  }

  // Submit update form
  function submitUpdateForm() {
    document.getElementById('updateForm').submit();
  }

  // Show success message
  function showSuccessMessage(message) {
    const successMsg = document.getElementById('successMessage');
    successMsg.textContent = message;
    successMsg.classList.add('show');

    // Hide after 10 seconds
    setTimeout(function() {
      successMsg.style.animation = 'fadeOut 0.5s ease-out';
      setTimeout(function() {
        successMsg.classList.remove('show');
        successMsg.style.animation = '';
      }, 500);
    }, 10000);
  }

  // Check for success parameter in URL
  window.onload = function() {
    const urlParams = new URLSearchParams(window.location.search);
    const action = urlParams.get('action');
    const success = urlParams.get('success');

    if (success === 'true') {
      let message = 'Action completed successfully!';

      if (action === 'delete') {
        message = 'Booking deleted successfully!';
      } else if (action === 'cancel') {
        message = 'Booking cancelled successfully!';
      } else if (action === 'update') {
        message = 'Booking updated successfully!';
      }

      showSuccessMessage(message);
    }
  };

  // Close modals when clicking outside
  window.onclick = function(event) {
    if (event.target.className === 'modal-overlay') {
      closeModal();
    }
  };
</script>

<jsp:include page="/WEB-INF/view/common/footer.jsp" />
</body>
</html>
