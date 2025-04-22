<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- No DOCTYPE, html, head or body tags, just the navbar component --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Link to Font Awesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Link to Google Fonts -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
<!-- Link to our custom CSS file -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css">

<nav class="navbar">
  <div class="navbar-container">
    <div class="logo-container">
      <a href="${pageContext.request.contextPath}/" class="logo">
        <i class="fas fa-car-side"></i>
        <span class="logo-text">GoRent</span>
      </a>
    </div>

    <div class="menu-toggle">
      <div class="hamburger">
        <span></span>
        <span></span>
        <span></span>
      </div>
    </div>

    <div class="nav-menu">
      <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/vehicles" class="nav-link"><span>Vehicles</span></a></li>
        <li><a href="${pageContext.request.contextPath}/about" class="nav-link"><span>About</span></a></li>
        <li><a href="${pageContext.request.contextPath}/contact" class="nav-link"><span>Contact</span></a></li>
      </ul>

      <div class="auth-buttons">
        <c:choose>
          <c:when test="${not empty sessionScope.user}">
            <div class="profile-section">
              <button class="booking-btn" id="bookNowBtn">
                <i class="fas fa-calendar-alt mr-2"></i>
                <span>Bookings</span>
              </button>

              <div class="profile-dropdown">
                <div class="profile-icon" id="profileIcon">
                  <i class="fas fa-user"></i>
                </div>

                <div class="dropdown-menu" id="dropdownMenu">
                  <a href="${pageContext.request.contextPath}/profile">
                    <i class="fas fa-user dropdown-icon"></i>
                    <span>Profile</span>
                  </a>
                  <a href="${pageContext.request.contextPath}/settings">
                    <i class="fas fa-cog dropdown-icon"></i>
                    <span>Settings</span>
                  </a>
                  <a href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt dropdown-icon"></i>
                    <span>Logout</span>
                  </a>
                </div>
              </div>
            </div>
          </c:when>
          <c:otherwise>
            <a href="${pageContext.request.contextPath}/login" class="login-btn">Login</a>
            <a href="${pageContext.request.contextPath}/register" class="register-btn">Register</a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</nav>

<!-- Booking Modal -->
<div class="booking-modal-overlay" id="bookingModal">
  <div class="booking-modal-content">
    <button class="booking-modal-close" id="closeModalBtn">&times;</button>

    <div class="booking-modal-header">
      <h2>Book Your Ride</h2>
      <div class="booking-steps">
        <div class="step active" data-step="1">1</div>
        <div class="step-line"></div>
        <div class="step" data-step="2">2</div>
        <div class="step-line"></div>
        <div class="step" data-step="3">3</div>
      </div>
    </div>

    <form id="bookingForm" class="booking-form">
      <div class="booking-step-content step-1 active-step">
        <h3>Select Dates</h3>

        <div class="date-pickers">
          <div class="date-field">
            <label for="pickupDate">Pickup Date</label>
            <div class="date-input-wrapper">
              <i class="fas fa-calendar-alt"></i>
              <input type="date" id="pickupDate" class="date-input" required>
            </div>
          </div>

          <div class="date-field">
            <label for="returnDate">Return Date</label>
            <div class="date-input-wrapper">
              <i class="fas fa-calendar-alt"></i>
              <input type="date" id="returnDate" class="date-input" required>
            </div>
          </div>
        </div>

        <div class="time-pickers">
          <div class="time-field">
            <label for="pickupTime">Pickup Time</label>
            <div class="time-input-wrapper">
              <i class="fas fa-clock"></i>
              <select id="pickupTime" class="time-input" required>
                <option value="" disabled selected>Select time</option>
                <c:forEach var="hour" begin="0" end="23">
                  <option value="${hour}:00">
                    <c:choose>
                      <c:when test="${hour < 10}">0${hour}:00</c:when>
                      <c:otherwise>${hour}:00</c:otherwise>
                    </c:choose>
                  </option>
                </c:forEach>
              </select>
            </div>
          </div>

          <div class="time-field">
            <label for="returnTime">Return Time</label>
            <div class="time-input-wrapper">
              <i class="fas fa-clock"></i>
              <select id="returnTime" class="time-input" required>
                <option value="" disabled selected>Select time</option>
                <c:forEach var="hour" begin="0" end="23">
                  <option value="${hour}:00">
                    <c:choose>
                      <c:when test="${hour < 10}">0${hour}:00</c:when>
                      <c:otherwise>${hour}:00</c:otherwise>
                    </c:choose>
                  </option>
                </c:forEach>
              </select>
            </div>
          </div>
        </div>

        <button type="button" class="next-button" id="step1Next">Next</button>
      </div>

      <div class="booking-step-content step-2">
        <h3>Select Location & Vehicle</h3>

        <div class="location-field">
          <label for="location">Pickup Location</label>
          <div class="location-input-wrapper">
            <i class="fas fa-map-marker-alt"></i>
            <select id="location" class="location-input" required>
              <option value="" disabled selected>Select location</option>
              <option value="downtown">Downtown</option>
              <option value="airport">Airport</option>
              <option value="north">North Branch</option>
              <option value="south">South Branch</option>
            </select>
          </div>
        </div>

        <div class="car-field">
          <label for="carType">Vehicle Type</label>
          <div class="car-input-wrapper">
            <i class="fas fa-car"></i>
            <select id="carType" class="car-input" required>
              <option value="" disabled selected>Select vehicle</option>
              <option value="economy">Economy</option>
              <option value="compact">Compact</option>
              <option value="suv">SUV</option>
              <option value="luxury">Luxury</option>
            </select>
          </div>
        </div>

        <div class="button-group">
          <button type="button" class="back-button" id="step2Back">Back</button>
          <button type="button" class="next-button" id="step2Next">Next</button>
        </div>
      </div>

      <div class="booking-step-content step-3">
        <h3>Confirm Booking</h3>

        <div class="booking-summary">
          <div class="summary-item">
            <span class="summary-label">Pickup Date:</span>
            <span class="summary-value" id="summaryPickupDate">Not selected</span>
          </div>
          <div class="summary-item">
            <span class="summary-label">Return Date:</span>
            <span class="summary-value" id="summaryReturnDate">Not selected</span>
          </div>
          <div class="summary-item">
            <span class="summary-label">Pickup Time:</span>
            <span class="summary-value" id="summaryPickupTime">Not selected</span>
          </div>
          <div class="summary-item">
            <span class="summary-label">Return Time:</span>
            <span class="summary-value" id="summaryReturnTime">Not selected</span>
          </div>
          <div class="summary-item">
            <span class="summary-label">Location:</span>
            <span class="summary-value" id="summaryLocation">Not selected</span>
          </div>
          <div class="summary-item">
            <span class="summary-label">Vehicle Type:</span>
            <span class="summary-value" id="summaryCarType">Not selected</span>
          </div>

          <div class="estimated-price">
            <span class="price-label">Estimated Total:</span>
            <span class="price-value">$120.00</span>
          </div>
        </div>

        <div class="button-group">
          <button type="button" class="back-button" id="step3Back">Back</button>
          <button type="submit" class="confirm-button">Confirm Booking</button>
        </div>
      </div>
    </form>
  </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    // Navbar entrance animation
    const navbar = document.querySelector('.navbar');
    setTimeout(() => {
      navbar.classList.add('loaded');
    }, 100);

    // Mobile menu toggle
    const menuToggle = document.querySelector('.menu-toggle');
    const navMenu = document.querySelector('.nav-menu');
    const hamburger = document.querySelector('.hamburger');

    menuToggle.addEventListener('click', function() {
      navMenu.classList.toggle('active');
      hamburger.classList.toggle('active');
    });

    // Highlight active nav link based on current page
    const currentLocation = window.location.pathname;
    const navLinks = document.querySelectorAll('.nav-link');

    navLinks.forEach(link => {
      const linkPath = link.getAttribute('href');
      if (currentLocation.includes(linkPath) && linkPath !== '${pageContext.request.contextPath}/') {
        link.classList.add('active');
      }
    });

    // Add scroll effect
    window.addEventListener('scroll', function() {
      if (window.scrollY > 50) {
        navbar.classList.add('scrolled');
      } else {
        navbar.classList.remove('scrolled');
      }
    });

    // Profile dropdown toggle
    const profileIcon = document.getElementById('profileIcon');
    const dropdownMenu = document.getElementById('dropdownMenu');

    if (profileIcon) {
      profileIcon.addEventListener('click', function(event) {
        dropdownMenu.classList.toggle('active');
        event.stopPropagation();
      });
    }

    // Close dropdown when clicking outside
    document.addEventListener('click', function(event) {
      if (dropdownMenu && dropdownMenu.classList.contains('active')) {
        if (!event.target.closest('.profile-dropdown')) {
          dropdownMenu.classList.remove('active');
        }
      }
    });

    // Booking Modal
    const bookNowBtn = document.getElementById('bookNowBtn');
    const bookingModal = document.getElementById('bookingModal');
    const closeModalBtn = document.getElementById('closeModalBtn');

    if (bookNowBtn) {
      bookNowBtn.addEventListener('click', function() {
        bookingModal.style.display = 'flex';
        document.body.style.overflow = 'hidden'; // Prevent scrolling when modal is open
      });
    }

    if (closeModalBtn) {
      closeModalBtn.addEventListener('click', function() {
        bookingModal.style.display = 'none';
        document.body.style.overflow = '';
      });
    }

    // Close modal when clicking outside
    bookingModal.addEventListener('click', function(event) {
      if (event.target === bookingModal) {
        bookingModal.style.display = 'none';
        document.body.style.overflow = '';
      }
    });

    // Multi-step form navigation
    const step1Next = document.getElementById('step1Next');
    const step2Next = document.getElementById('step2Next');
    const step2Back = document.getElementById('step2Back');
    const step3Back = document.getElementById('step3Back');
    const steps = document.querySelectorAll('.booking-step-content');
    const stepIndicators = document.querySelectorAll('.step');

    function goToStep(stepNumber) {
      steps.forEach(step => step.classList.remove('active-step'));
      document.querySelector(`.step-${stepNumber}`).classList.add('active-step');

      stepIndicators.forEach(indicator => {
        const indicatorStep = parseInt(indicator.getAttribute('data-step'));
        if (indicatorStep <= stepNumber) {
          indicator.classList.add('active');
        } else {
          indicator.classList.remove('active');
        }
      });
    }

    step1Next.addEventListener('click', function() {
      const pickupDate = document.getElementById('pickupDate').value;
      const returnDate = document.getElementById('returnDate').value;
      const pickupTime = document.getElementById('pickupTime').value;
      const returnTime = document.getElementById('returnTime').value;

      if (pickupDate && returnDate && pickupTime && returnTime) {
        goToStep(2);
      } else {
        alert('Please fill in all date and time fields');
      }
    });

    step2Next.addEventListener('click', function() {
      const location = document.getElementById('location').value;
      const carType = document.getElementById('carType').value;

      if (location && carType) {
        // Update summary
        const pickupDate = document.getElementById('pickupDate').value;
        const returnDate = document.getElementById('returnDate').value;
        const pickupTime = document.getElementById('pickupTime').value;
        const returnTime = document.getElementById('returnTime').value;

        document.getElementById('summaryPickupDate').textContent = formatDate(pickupDate);
        document.getElementById('summaryReturnDate').textContent = formatDate(returnDate);
        document.getElementById('summaryPickupTime').textContent = pickupTime;
        document.getElementById('summaryReturnTime').textContent = returnTime;
        document.getElementById('summaryLocation').textContent = capitalizeFirstLetter(location);
        document.getElementById('summaryCarType').textContent = capitalizeFirstLetter(carType);

        goToStep(3);
      } else {
        alert('Please select a location and vehicle type');
      }
    });

    step2Back.addEventListener('click', function() {
      goToStep(1);
    });

    step3Back.addEventListener('click', function() {
      goToStep(2);
    });

    // Form submission
    const bookingForm = document.getElementById('bookingForm');
    bookingForm.addEventListener('submit', function(event) {
      event.preventDefault();
      alert('Booking submitted successfully!');
      bookingModal.style.display = 'none';
      document.body.style.overflow = '';
    });

    // Helper functions
    function formatDate(dateString) {
      if (!dateString) return 'Not selected';

      const date = new Date(dateString);
      const options = { year: 'numeric', month: 'long', day: 'numeric' };
      return date.toLocaleDateString('en-US', options);
    }

    function capitalizeFirstLetter(string) {
      if (!string) return 'Not selected';
      return string.charAt(0).toUpperCase() + string.slice(1);
    }
  });
</script>