<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
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
        <h1>Welcome back</h1>
        <p class="subtitle">Enter your credentials to sign in to your account</p>

        <!-- Display error message if exists -->
        <c:if test="${not empty error}">
            <div style="color: red; font-weight: bold; margin-bottom: 10px; text-align: center;">
                    ${error}
            </div>
        </c:if>
        <%
        String rememberedEmail  = "";
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            for (Cookie c : cookies){
                if ("rememberEmail".equals(c.getName())){
                    rememberedEmail  = c.getValue();
                }
            }
        }
            String email = request.getAttribute("email") != null ? (String) request.getAttribute("email") : rememberedEmail;
            String error = (String) request.getAttribute("error");



        %>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" value="<%= email  %>"placeholder="name@example.com" required>
            </div>

            <div class="form-group password-group">
                <label for="password">Password</label>
                <a href="${pageContext.request.contextPath}/forgot-password.jsp" class="forgot-link">Forgot password?</a>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="remember-me">
                <input type="checkbox" id="rememberMe" name="rememberMe" value="true" <%= !"".equals(rememberedEmail ) ? "checked" : "" %> >
                <label for="rememberMe">Remember me</label>
            </div>

            <button type="submit" class="btn-primary">Sign In</button>
        </form>

        <div class="divider">
            <span>OR CONTINUE WITH</span>
        </div>

        <div class="social-buttons">
            <button class="btn-social google">Google</button>
            <button class="btn-social facebook">Facebook</button>
        </div>

        <p class="alternate-action">
            Don't have an account? <a href="${pageContext.request.contextPath}/register" class="login-btn">Register</a>
        </p>
    </div>
</div>

</body>
</html>
