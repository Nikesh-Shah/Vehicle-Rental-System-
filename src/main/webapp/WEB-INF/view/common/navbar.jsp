<%-- File: /WEB-INF/view/common/navbar.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- No DOCTYPE, html, head or body tags, just the navbar component --%>

<!-- Link to Font Awesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
      <i class="fas fa-bars"></i>
    </div>

    <div class="nav-menu">
      <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/vehicles" class="nav-link"><span>Vehicles</span></a></li>
        <li><a href="${pageContext.request.contextPath}/about" class="nav-link"><span>About</span></a></li>
        <li><a href="${pageContext.request.contextPath}/contact" class="nav-link"><span>Contact</span></a></li>
      </ul>

      <div class="auth-buttons">
        <a href="${pageContext.request.contextPath}/login" class="login-btn">Login</a>
        <a href="${pageContext.request.contextPath}/register" class="register-btn">Register</a>
      </div>
    </div>
  </div>
</nav>


<script>
  document.addEventListener('DOMContentLoaded', function() {
    // Mobile menu toggle
    const menuToggle = document.querySelector('.menu-toggle');
    const navMenu = document.querySelector('.nav-menu');

    menuToggle.addEventListener('click', function() {
      navMenu.classList.toggle('active');
      menuToggle.classList.toggle('active');
    });

    // Highlight active nav link based on current page
    const currentLocation = window.location.pathname;
    const navLinks = document.querySelectorAll('.nav-link');

    navLinks.forEach(link => {
      const linkPath = link.getAttribute('href');
      if (currentLocation.includes(linkPath) && linkPath !== '/') {
        link.classList.add('active');
      }
    });

    // Add scroll effect
    window.addEventListener('scroll', function() {
      const navbar = document.querySelector('.navbar');
      if (window.scrollY > 50) {
        navbar.classList.add('scrolled');
      } else {
        navbar.classList.remove('scrolled');
      }
    });


    document.querySelector('.navbar').classList.add('loaded');
  });
</script>