<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 4/25/2025
  Time: 1:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/resetpassword" method="post">
    <input type="hidden" name="email" value="${email}">
    <label>New Password:</label>
    <input type="password" name="newPassword" required>
    <button type="submit">Update Password</button>
</form>

</body>
</html>
