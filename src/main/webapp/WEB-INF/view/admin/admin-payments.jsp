<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="/WEB-INF/view/admin/admin-sidebar.jsp" %>

<table class="table">
    <thead>
    <tr>
        <th>Payment ID</th>
        <th>Customer</th>
        <th>Amount</th>
        <th>Booking Dates</th>
        <th>Status</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${payments}" var="payment">
        <tr>
            <td>${payment.paymentId}</td>
            <td>${payment.customerName}</td>
            <td>$<fmt:formatNumber value="${payment.amount}" maxFractionDigits="2"/></td>
            <td>
                <fmt:formatDate value="${payment.bookingStartDate}" pattern="MMM dd"/> -
                <fmt:formatDate value="${payment.bookingEndDate}" pattern="MMM dd, yyyy"/>
            </td>
            <td>${payment.status}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>