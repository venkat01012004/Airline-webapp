<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Server Error - SkyWings Airlines" scope="request"/>
<%@ include file="/includes/header.jsp" %>

<div class="container text-center" style="padding:100px 0;">
    <i class="bi bi-exclamation-triangle" style="font-size:4rem;color:#d64545;"></i>
    <h1 class="mt-3">Oops! Something Went Wrong</h1>
    <p class="text-muted">We encountered an unexpected error while processing your request. Please try again later.</p>
    <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary-airline mt-3">Back to Home</a>
</div>

<%@ include file="/includes/footer.jsp" %>
