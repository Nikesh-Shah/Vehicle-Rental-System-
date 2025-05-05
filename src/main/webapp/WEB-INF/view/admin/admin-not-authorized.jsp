<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Access Denied</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card border-warning">
                <div class="card-header bg-warning text-dark">
                    <h2>Access Denied</h2>
                </div>
                <div class="card-body">
                    <div class="alert alert-warning">
                        <h4 class="alert-heading">You don't have permission to access this page</h4>
                        <p>Only administrators can access the admin dashboard.</p>
                        <hr>
                        <p class="mb-0">
                            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">
                                Login as Admin
                            </a>
                            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">
                                Return to Home
                            </a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>