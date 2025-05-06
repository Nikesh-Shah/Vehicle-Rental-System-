<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request OTP</title>
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
        <h1>Forgot Password</h1>
        <p class="subtitle">Enter your email to receive a verification code</p>

        <!-- Display error message if exists -->
        <c:if test="${not empty error}">
            <div style="color: red; font-weight: bold; margin-bottom: 10px; text-align: center;">
                    ${error}
            </div>
        </c:if>

        <!-- Display success message if exists -->
        <c:if test="${not empty success}">
            <div style="color: green; font-weight: bold; margin-bottom: 10px; text-align: center;">
                    ${success}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/sendotp" method="post">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="name@example.com" required>
            </div>

            <button type="submit" class="btn-primary">Send OTP</button>
        </form>

        <p class="alternate-action">
            Remember your password? <a href="${pageContext.request.contextPath}/login" class="login-btn">Back to Login</a>
        </p>
    </div>
</div>
</body>
</html>