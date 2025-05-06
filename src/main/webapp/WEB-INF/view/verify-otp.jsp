<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/login.css" />
    <style>
        .otp-input {
            letter-spacing: 2px;
            font-size: 18px;
            text-align: center;
        }

        .timer {
            margin-top: 10px;
            font-size: 14px;
            color: #666;
        }

        .resend-link {
            color: #007bff;
            text-decoration: none;
            cursor: pointer;
            display: none;
        }

        .resend-link:hover {
            text-decoration: underline;
        }
    </style>
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
        <h1>Verify OTP</h1>
        <p class="subtitle">Enter the verification code sent to your email</p>

        <!-- Display error message if exists -->
        <c:if test="${not empty error}">
            <div style="color: red; font-weight: bold; margin-bottom: 10px; text-align: center;">
                    ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/verifyotp" method="post">
            <input type="hidden" name="email" value="${email}">

            <div class="form-group">
                <label for="otp">Verification Code</label>
                <input type="text" id="otp" name="otp" class="otp-input" maxlength="6" placeholder="Enter 6-digit code" required>
                <div class="timer">Code expires in <span id="countdown">05:00</span></div>
                <a id="resendLink" class="resend-link" href="${pageContext.request.contextPath}/sendotp?email=${email}">Resend code</a>
            </div>

            <button type="submit" class="btn-primary">Verify</button>
        </form>

        <p class="alternate-action">
            <a href="${pageContext.request.contextPath}/login" class="login-btn">Back to Login</a>
        </p>
    </div>
</div>

<script>
    // Countdown timer for OTP expiration
    function startTimer(duration, display) {
        let timer = duration, minutes, seconds;
        const interval = setInterval(function () {
            minutes = parseInt(timer / 60, 10);
            seconds = parseInt(timer % 60, 10);

            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;

            display.textContent = minutes + ":" + seconds;

            if (--timer < 0) {
                clearInterval(interval);
                display.textContent = "00:00";
                document.getElementById("resendLink").style.display = "inline";
            }
        }, 1000);
    }

    // Start the countdown when the page loads
    window.onload = function () {
        const fiveMinutes = 60 * 5;
        const display = document.querySelector('#countdown');
        startTimer(fiveMinutes, display);
    };

    // Format OTP input to show only numbers
    document.getElementById('otp').addEventListener('input', function (e) {
        e.target.value = e.target.value.replace(/[^0-9]/g, '');
    });
</script>
</body>
</html>