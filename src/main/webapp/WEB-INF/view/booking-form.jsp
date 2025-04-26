<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Book Vehicles</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .vehicle-card.selected {
      border: 2px solid #0d6efd;
      background-color: #f8f9fa;
    }
  </style>
</head>
<body>
<div class="container mt-4">
  <h1>Book Vehicles</h1>

  <form id="bookingForm" action="bookings" method="post">
    <input type="hidden" name="action" value="create">

    <div class="row mb-4">
      <div class="col-md-6">
        <label for="startDate" class="form-label">Start Date</label>
        <input type="date" class="form-control" id="startDate" name="startDate" required>
      </div>
      <div class="col-md-6">
        <label for="endDate" class="form-label">End Date</label>
        <input type="date" class="form-control" id="endDate" name="endDate" required>
      </div>
    </div>

    <h3>Select Vehicles</h3>
    <div class="row row-cols-1 row-cols-md-3 g-4 mb-4" id="vehicleSelection">
      <c:forEach items="${vehicles}" var="vehicle">
        <div class="col">
          <div class="card h-100 vehicle-card" data-vehicle-id="${vehicle.vehicleId}">
            <img src="${vehicle.image}" class="card-img-top" alt="${vehicle.brand} ${vehicle.model}">
            <div class="card-body">
              <h5 class="card-title">${vehicle.brand} ${vehicle.model}</h5>
              <p class="card-text">$${vehicle.pricePerDay} per day</p>
            </div>
            <div class="card-footer">
              <input type="checkbox" name="vehicleIds" value="${vehicle.vehicleId}"
                     class="form-check-input vehicle-checkbox" style="display: none;">
            </div>
          </div>
        </div>
      </c:forEach>
    </div>

    <div class="d-flex justify-content-between">
      <a href="vehicles" class="btn btn-secondary">Back to Vehicles</a>
      <button type="submit" class="btn btn-primary" id="submitBtn" disabled>Proceed to Booking</button>
    </div>
  </form>
</div>

<script>
  // Handle vehicle selection
  document.querySelectorAll('.vehicle-card').forEach(card => {
    card.addEventListener('click', function() {
      const checkbox = this.querySelector('.vehicle-checkbox');
      checkbox.checked = !checkbox.checked;
      this.classList.toggle('selected', checkbox.checked);
      updateSubmitButton();
    });
  });

  // Update submit button state
  function updateSubmitButton() {
    const checkedBoxes = document.querySelectorAll('.vehicle-checkbox:checked');
    document.getElementById('submitBtn').disabled = checkedBoxes.length === 0;
  }

  // Form validation
  document.getElementById('bookingForm').addEventListener('submit', function(e) {
    const startDate = new Date(document.getElementById('startDate').value);
    const endDate = new Date(document.getElementById('endDate').value);

    if (startDate >= endDate) {
      e.preventDefault();
      alert('End date must be after start date');
    }
  });
</script>
</body>
</html>