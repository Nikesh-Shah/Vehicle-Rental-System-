<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create an account</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/login.css" />
</head>
<body>
<div class="container">
    <div class="form-container">
        <div class="logo">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M14 16H9m10 0h3v-3.15a1 1 0 0 0-.84-.99L16 11l-2.7-3.6a1 1 0 0 0-.8-.4H5.24a2 2 0 0 0-1.8 1.1l-.8 1.63A6 6 0 0 0 2 12.42V16h2"></path>
                <circle cx="6.5" cy="16.5" r="2.5"></circle>
                <circle cx="16.5" cy="16.5" r="2.5"></circle>
            </svg>
        </div>
        <h1>Create an account</h1>
        <p class="subtitle">Enter your information to create an account</p>

        <!-- Show error message if present -->
        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="name-fields">
                <div class="form-group half-width">
                    <label>First name</label>
                    <input type="text" id="fname" name="fname" placeholder="Siya" required>
                </div>

                <div class="form-group half-width">
                    <label for="lname">Last name</label>
                    <input type="text" id="lname" name="lname" placeholder="Ram" required>
                </div>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="name@example.com" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
<%--                <span class="toggle-password" toggle="#password">&#128065;</span> <!-- eye icon -->--%>

            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
<%--                <span class="toggle-password" toggle="#confirmPassword">&#128065;</span>--%>

            </div>
            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="text" id="phone" name="phone" placeholder="98XXXXXXXX" required>
            </div>

            <button type="submit" class="btn-primary">Create Account</button>
        </form>

        <div class="divider">
            <span>OR CONTINUE WITH</span>
        </div>

        <div class="social-buttons">
            <button class="btn-social google">Google</button>
            <button class="btn-social facebook">Facebook</button>
        </div>

        <p class="alternate-action">
            Already have an account? <a href="${pageContext.request.contextPath}/login" class="login-btn">Login</a>
        </p>
    </div>
</div>
<script>
    document.querySelectorAll('.toggle-password').forEach(function(toggle) {
        toggle.addEventListener('click', function() {
            const input = document.querySelector(this.getAttribute('toggle'));
            if (input.type === 'password') {
                input.type = 'text';
                this.style.color = '#007BFF'; // optional: change color when visible
            } else {
                input.type = 'password';
                this.style.color = '#666'; // reset color
            }
        });
    });
</script>



</body>
</html>
