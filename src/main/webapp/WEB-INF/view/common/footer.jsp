<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="footer">
  <div class="container">
    <div class="footer-content">
      <div class="footer-column">
        <h3>Company</h3>
        <ul>
          <li><a href="about.jsp">About Us</a></li>
          <li><a href="careers.jsp">Careers</a></li>
          <li><a href="contact.jsp">Contact</a></li>
        </ul>
      </div>

      <div class="footer-column">
        <h3>Services</h3>
        <ul>
          <li><a href="car-rental.jsp">Car Rental</a></li>
          <li><a href="long-term-rental.jsp">Long Term Rental</a></li>
          <li><a href="airport-pickup.jsp">Airport Pickup</a></li>
        </ul>
      </div>

      <div class="footer-column">
        <h3>Support</h3>
        <ul>
          <li><a href="faqs.jsp">FAQs</a></li>
          <li><a href="help-center.jsp">Help Center</a></li>
          <li><a href="terms-of-service.jsp">Terms of Service</a></li>
        </ul>
      </div>

      <div class="footer-column">
        <h3>Connect</h3>
        <ul>
          <li><a href="https://facebook.com/carrentalservice" target="_blank">Facebook</a></li>
          <li><a href="https://twitter.com/carrentalservice" target="_blank">Twitter</a></li>
          <li><a href="https://instagram.com/carrentalservice" target="_blank">Instagram</a></li>
        </ul>
      </div>
    </div>

    <div class="footer-divider"></div>

    <div class="footer-copyright">
      <p>&copy; <%= java.time.Year.now() %> Car Rental Service. All rights reserved.</p>
    </div>
  </div>
</footer>
