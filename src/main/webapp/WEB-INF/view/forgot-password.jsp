<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/sendotp" method="post">
    <label >Enter your email:</label>
    <input type="email" name="email" required>
    <button type="submit">Send OTP</button>
</form>


</body>
</html>
