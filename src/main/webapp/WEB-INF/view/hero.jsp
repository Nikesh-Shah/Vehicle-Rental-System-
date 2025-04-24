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
  <div class="floating-circles">
    <div class="circle"></div>
    <div class="circle"></div>
    <div class="circle"></div>
  </div>

  <div class="hero-content animate-fade-in">
    <div class="premium-badge">
      <i class="fas fa-crown"></i>
      <span>Premium Experience</span>
    </div>

    <h1>Drive Your Dreams Today</h1>
    <p>Experience luxury and performance with our premium car rental service. Choose from our exclusive collection of high-end vehicles for your perfect journey.</p>

    <div class="hero-buttons">
      <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-primary">
        <span>Explore Our Fleet</span>
        <i class="fas fa-arrow-right"></i>
      </a>
      <a href="${pageContext.request.contextPath}/register" class="btn btn-secondary">
        <span>Join GoRental</span>
      </a>
    </div>

    <div class="trust-indicators">
      <div class="trust-item">
        <i class="fas fa-check-circle"></i>
        <span>No hidden fees</span>
      </div>
      <div class="trust-item">
        <i class="fas fa-headset"></i>
        <span>24/7 Premium Support</span>
      </div>
      <div class="trust-item">
        <i class="fas fa-calendar-check"></i>
        <span>Free cancellation</span>
      </div>
      <div class="trust-item">
        <i class="fas fa-shield-alt"></i>
        <span>Fully insured vehicles</span>
      </div>
    </div>
  </div>

  <div class="hero-image animate-slide-in">
    <div class="image-container">
      <img src="${pageContext.request.contextPath}/assets/images/hero2.png" alt="Premium Car" class="main-image">

      <div class="floating-badge top">
        <i class="fas fa-star"></i>
        <span>Top Rated Service</span>
      </div>

      <div class="floating-badge bottom">
        <i class="fas fa-shield-alt"></i>
        <span>Premium Insurance</span>
      </div>

      <div class="car-features">
        <div class="feature">
          <div class="feature-icon">
            <i class="fas fa-tachometer-alt"></i>
          </div>
          <span class="feature-text">High Performance</span>
        </div>

        <div class="feature">
          <div class="feature-icon">
            <i class="fas fa-cog"></i>
          </div>
          <span class="feature-text">Automatic</span>
        </div>

        <div class="feature">
          <div class="feature-icon">
            <i class="fas fa-gas-pump"></i>
          </div>
          <span class="feature-text">Fuel Efficient</span>
        </div>
      </div>
    </div>
  </div>

  <!-- Shape Divider -->
  <div class="shape-divider">
    <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
      <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" class="shape-fill"></path>
    </svg>
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

    // Enhanced parallax effect on scroll with smoother animations
    window.addEventListener('scroll', function() {
      const scrollPosition = window.scrollY;
      if (scrollPosition < 800) {
        const heroImage = document.querySelector('.hero-image');
        const heroContent = document.querySelector('.hero-content');
        const circles = document.querySelectorAll('.circle');

        // Using requestAnimationFrame for smoother animations
        requestAnimationFrame(function() {
          heroImage.style.transform = `translateY(${scrollPosition * 0.05}px)`;
          heroContent.style.transform = `translateY(${scrollPosition * 0.03}px)`;

          circles.forEach((circle, index) => {
            const factor = 0.03 + (index * 0.01);
            circle.style.transform = `translateY(${scrollPosition * factor}px) rotate(${scrollPosition * 0.02}deg)`;
          });
        });
      }
    }, { passive: true }); // Using passive listener for better performance
  });
</script>
</body>
</html>