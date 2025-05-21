<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
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
              <a href="${pageContext.request.contextPath}/booking" class="booking-btn">
                <i class="fas fa-calendar-alt mr-2"></i>
                <span>Bookings</span>
              </a>

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

                  <form action="${pageContext.request.contextPath}/logout" method="post">
                    <button class="btn-log" type="submit" style="background: none; border: none; padding: 0; cursor: pointer; left: 20px;">
                      <i class="fas fa-sign-out-alt dropdown-icon"></i>
                      <span>Logout</span>
                    </button>
                  </form>
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
  });
</script>