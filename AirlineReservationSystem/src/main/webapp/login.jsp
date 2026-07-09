<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Login - SkyWings Airlines" scope="request"/>
<%@ include file="/includes/header.jsp" %>

<div class="container">
    <div class="auth-card">
        <div class="text-center mb-4">
            <i class="bi bi-airplane-engines-fill" style="font-size:2.5rem;color:#0d3b66;"></i>
            <h2 class="mt-2">Welcome Back</h2>
            <p class="text-muted">Login to manage your bookings</p>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-airline-danger alert-auto-dismiss">${errorMessage}</div>
        </c:if>
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-airline-success alert-auto-dismiss">${sessionScope.successMessage}</div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="alert alert-airline-danger alert-auto-dismiss">${sessionScope.errorMessage}</div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation" novalidate>
            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="you@example.com" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
            </div>
            <button type="submit" class="btn btn-primary-airline w-100">Login</button>
        </form>

        <p class="text-center mt-4 mb-0 text-muted">
            Don't have an account? <a href="${pageContext.request.contextPath}/register.jsp">Register here</a>
        </p>

        <div class="alert alert-light border mt-4 small">
            <strong>Demo Credentials</strong><br>
            Admin: admin@airline.com / Admin@123<br>
            Customer: john@example.com / John@123
        </div>
    </div>
</div>

<%@ include file="/includes/footer.jsp" %>
