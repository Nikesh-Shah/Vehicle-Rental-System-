<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/login.css" />
    <script src="https://connect.facebook.net/en_US/sdk.js"></script>
    <script>
        let fbLoaded = false;

        window.fbAsyncInit = function () {
            FB.init({
                appId: 1941126890031130,
                cookie: true,
                xfbml: false,
                version: 'v19.0'
            });
            fbLoaded = true;
            console.log("Facebook SDK initialized.");
        };

        (function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "https://connect.facebook.net/en_US/sdk.js";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));

        function handleFacebookLogin() {
            if (!fbLoaded) {
                alert("Facebook SDK is not loaded yet. Please wait a moment.");
                return;
            }

            console.log("Initiating Facebook login...");

            FB.login(function (response) {
                console.log("FB.login response:", response);

                if (response.authResponse) {
                    console.log("Login successful. Fetching user info...");

                    FB.api('/me', {fields: 'id,name,email'}, function (userInfo) {
                        console.log("User info retrieved from Facebook:", userInfo);

                        document.getElementById("fbId").value = userInfo.id;
                        document.getElementById("fbName").value = userInfo.name;
                        document.getElementById("fbEmail").value = userInfo.email;

                        document.forms[1].submit();  // Submits the form with Facebook details
                    });
                } else {
                    console.error("Facebook login failed or was cancelled.", response);
                    alert("Facebook login failed or was cancelled.");
                }
            }, {scope: 'public_profile,email'});
        }
    </script>


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
                <a href="${pageContext.request.contextPath}/forgot-password" class="forgot-link">Forgot password?</a>
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
            <button class="btn-social facebook" onclick="handleFacebookLogin()">Facebook</button>
        </div>
        <form id="fbForm" action="${pageContext.request.contextPath}/FacebookLoginServlet" method="POST">
            <input type="hidden" name="fbId" id="fbId">
            <input type="hidden" name="fbName" id="fbName">
            <input type="hidden" name="fbEmail" id="fbEmail">
        </form>


        <p class="alternate-action">
            Don't have an account? <a href="${pageContext.request.contextPath}/register" class="login-btn">Register</a>
        </p>
    </div>
</div>
<script>
    function handleFacebookLogin() {
        console.log("Initiating Facebook login...");

        FB.login(function(response) {
            console.log("FB.login response:", response);

            if (response.authResponse) {
                console.log("Login successful. Fetching user info...");

                FB.api('/me', {fields: 'id,name,email'}, function(userInfo) {
                    console.log("User info retrieved from Facebook:", userInfo);

                    // Populate form fields
                    document.getElementById("fbId").value = userInfo.id;
                    document.getElementById("fbName").value = userInfo.name;
                    document.getElementById("fbEmail").value = userInfo.email;

                    console.log("Populated form fields. Submitting form...");
                    document.getElementById("fbForm").submit();
                });
            } else {
                console.error("Facebook login failed or was cancelled.", response);
                alert("Facebook login failed or was cancelled.");
            }
        }, {scope: 'public_profile,email'});
    }
</script>



</body>
</html>
