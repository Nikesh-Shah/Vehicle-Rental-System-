<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>GoRent</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/home.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/feature.css" />


</head>
<body>
<c:if test="${empty categoryVehicleMap}">
    <c:redirect url="feature" />
</c:if>
<%@ include file="/WEB-INF/view/common/navbar.jsp" %>
<jsp:include page="/WEB-INF/view/hero.jsp" />
<jsp:include page="/WEB-INF/view/howitworks.jsp" />
<jsp:include page="/WEB-INF/view/testimonials.jsp" />
<jsp:include page="/WEB-INF/view/faq.jsp" />
<jsp:include page="/WEB-INF/view/featuredproduct.jsp" />
<jsp:include page="/WEB-INF/view/common/footer.jsp" />

</body>
</html>

