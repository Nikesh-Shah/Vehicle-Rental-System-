<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 4/25/2025
  Time: 1:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/verifyotp" method="post">
    <input type="hidden" name="email" value="${email}">
    <label>Enter OTP:</label>
    <input type="text" name="otp" required>
    <button type="submit">Verify OTP</button>
</form>


</body>
</html>
