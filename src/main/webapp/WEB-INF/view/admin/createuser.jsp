<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <title>Create User - Admin</title>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--    <h1>Create New User</h1>--%>

<%--    <!-- Show error message if present -->--%>
<%--    <c:if test="${not empty error}">--%>
<%--        <div class="error-message">${error}</div>--%>
<%--    </c:if>--%>

<%--    <form action="${pageContext.request.contextPath}/admin/createuser" method="post">--%>

<%--        <div class="form-group">--%>
<%--            <label for="fname">First Name</label>--%>
<%--            <input type="text" id="fname" name="fname" placeholder="First Name" required--%>
<%--                   value="${param.fname}" />--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--            <label for="lname">Last Name</label>--%>
<%--            <input type="text" id="lname" name="lname" placeholder="Last Name" required--%>
<%--                   value="${param.lname}" />--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--            <label for="email">Email</label>--%>
<%--            <input type="email" id="email" name="email" placeholder="email@example.com" required--%>
<%--                   value="${param.email}" />--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--            <label for="phone">Phone</label>--%>
<%--            <input type="text" id="phone" name="phone" placeholder="98XXXXXXXX" required--%>
<%--                   value="${param.phone}" />--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--            <label for="password">Password</label>--%>
<%--            <input type="password" id="password" name="password" required />--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--            <label for="confirmPassword">Confirm Password</label>--%>
<%--            <input type="password" id="confirmPassword" name="confirmPassword" required />--%>
<%--        </div>--%>

<%--        <button type="submit" class="btn-primary">Create User</button>--%>
<%--    </form>--%>

<%--    <p>--%>
<%--        <a href="${pageContext.request.contextPath}/admin/admin-dashboard">Back to Dashboard</a>--%>
<%--    </p>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create User - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-create-user.css">
</head>
<body>
<%@ include file="admin-sidebar.jsp" %>

<div class="container">
    <h1>Create New User</h1>

    <!-- Show error message if present -->
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/createuser" method="post">
        <div class="form-group">
            <label for="fname">First Name</label>
            <input type="text" id="fname" name="fname" placeholder="First Name" required
                   value="${param.fname}" />
        </div>

        <div class="form-group">
            <label for="lname">Last Name</label>
            <input type="text" id="lname" name="lname" placeholder="Last Name" required
                   value="${param.lname}" />
        </div>

        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="email@example.com" required
                   value="${param.email}" />
        </div>

        <div class="form-group">
            <label for="phone">Phone</label>
            <input type="text" id="phone" name="phone" placeholder="98XXXXXXXX" required
                   value="${param.phone}" />
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required />
        </div>

        <div class="form-group">
            <label for="confirmPassword">Confirm Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required />
        </div>

        <button type="submit" class="btn-primary">Create User</button>
    </form>

    <p>
        <a href="${pageContext.request.contextPath}/admin/admin-dashboard">Back to Dashboard</a>
    </p>
</div>
</body>
</html>
