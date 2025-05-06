<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/login.css" />
    <style>
        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .profile-avatar {
            width: 60px;
            height: 60px;
            background-color: #f0f0f0;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 24px;
            color: #555;
        }

        .profile-title {
            flex: 1;
        }

        .profile-title h1 {
            margin: 0;
            text-align: left;
        }

        .profile-title p {
            margin: 5px 0 0;
            color: #666;
            text-align: left;
        }

        .readonly-field {
            background-color: #f8f9fa;
            color: #666;
        }

        .message {
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .success-message {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            color: #007bff;
            text-decoration: none;
            font-size: 14px;
            margin-top: 10px;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .back-link svg {
            margin-right: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="form-container">
        <div class="profile-header">
            <div class="profile-avatar">
                <%= user.getFname().substring(0, 1).toUpperCase() + user.getLname().substring(0, 1).toUpperCase() %>
            </div>
            <div class="profile-title">
                <h1>My Profile</h1>
                <p>Manage your personal information</p>
            </div>
        </div>

        <% if (request.getAttribute("message") != null) { %>
        <div class="message success-message"><%= request.getAttribute("message") %></div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <div class="message error-message"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="profile" method="post">
            <div class="form-group">
                <label for="email">Email (readonly)</label>
                <input type="email" id="email" name="email" value="<%= user.getEmail() %>" class="readonly-field" readonly />
            </div>

            <div class="form-group">
                <label for="fname">First Name</label>
                <input type="text" id="fname" name="fname" value="<%= user.getFname() %>" required />
            </div>

            <div class="form-group">
                <label for="lname">Last Name</label>
                <input type="text" id="lname" name="lname" value="<%= user.getLname() %>" required />
            </div>

            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="text" id="phone" name="phone" value="<%= user.getPhone() %>" />
            </div>

            <button type="submit" class="btn-primary">Update Profile</button>
        </form>

        <a href="index.jsp" class="back-link">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="19" y1="12" x2="5" y2="12"></line>
                <polyline points="12 19 5 12 12 5"></polyline>
            </svg>
            Back to Home
        </a>
    </div>
</div>
</body>
</html>