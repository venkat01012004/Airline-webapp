<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Page Not Found - SkyWings Airlines" scope="request"/>
<%@ include file="/includes/header.jsp" %>

<div class="container text-center" style="padding:100px 0;">
    <i class="bi bi-signpost-2" style="font-size:4rem;color:#0d3b66;"></i>
    <h1 class="mt-3">404 - Page Not Found</h1>
    <p class="text-muted">The page you are looking for doesn't exist or has been moved.</p>
    <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary-airline mt-3">Back to Home</a>
</div>

<%@ include file="/includes/footer.jsp" %>
