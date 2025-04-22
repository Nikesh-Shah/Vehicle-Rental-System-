<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Premium Car Rental</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/home.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
<div class="hero-section">
  <div class="hero-content animate-fade-in">
<%--    <span class="badge">Premium Experience</span>--%>
    <h1>Premium Car Rental Service</h1>
    <p>Rent your dream car today. We offer a wide range of vehicles for all your needs.</p>
    <div class="hero-buttons">
      <a href= ${pageContext.request.contextPath}/vehicles"  class="btn btn-primary">
        <span>Browse Vehicles</span>
        <i class="fas fa-arrow-right"></i>
      </a>
      <a href= ${pageContext.request.contextPath}/register"  class="btn btn-secondary">
        <span>Register</span>
      </a>
    </div>
    <div class="trust-indicators">
      <div class="trust-item">
        <i class="fas fa-check-circle"></i>
        <span>No hidden fees</span>
      </div>
      <div class="trust-item">
        <i class="fas fa-check-circle"></i>
        <span>24/7 Support</span>
      </div>
      <div class="trust-item">
        <i class="fas fa-check-circle"></i>
        <span>Free cancellation</span>
      </div>
    </div>
  </div>
  <div class="hero-image animate-slide-in">
    <div class="image-container">
      <img src="${pageContext.request.contextPath}/assets/images/hero2.png" alt="Premium Car" class="main-image">
      <div class="floating-badge top">
        <i class="fas fa-star"></i>
        <span>Top Rated</span>
      </div>
      <div class="floating-badge bottom">
        <i class="fas fa-shield-alt"></i>
        <span>Fully Insured</span>
      </div>
    </div>
  </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    // Add animation classes to trigger animations after page load
    setTimeout(function() {
      document.querySelectorAll('.animate-fade-in').forEach(el => {
        el.classList.add('visible');
      });
      document.querySelectorAll('.animate-slide-in').forEach(el => {
        el.classList.add('visible');
      });
    }, 100);

    // Optional: Parallax effect on scroll
    window.addEventListener('scroll', function() {
      const scrollPosition = window.scrollY;
      if (scrollPosition < 500) {
        document.querySelector('.hero-image').style.transform = 'translateY(' + scrollPosition * 0.1 + 'px)';
        document.querySelector('.hero-content').style.transform = 'translateY(' + scrollPosition * 0.05 + 'px)';
      }
    });
  });
</script>
</body>
</html>