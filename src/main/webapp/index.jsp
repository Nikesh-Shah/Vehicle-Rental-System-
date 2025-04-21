<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>GoRent</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/howitworks.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/faq.css" />


</head>
<body>
<%@ include file="/WEB-INF/view/common/navbar.jsp" %>
<jsp:include page="/WEB-INF/view/hero.jsp" />
<jsp:include page="/WEB-INF/view/howitworks.jsp" />
<jsp:include page="/WEB-INF/view/faq.jsp" />

<%--<h1><%= "Hello World!" %>--%>
<%--</h1>--%>
<%--<br/>--%>
<a href="hello-servlet">Hello Servlet</a>
<jsp:include page="/WEB-INF/view/common/footer.jsp" />
</body>
</html>

