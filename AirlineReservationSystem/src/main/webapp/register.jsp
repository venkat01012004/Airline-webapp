<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Register - SkyWings Airlines" scope="request"/>
<%@ include file="/includes/header.jsp" %>

<div class="container">
    <div class="auth-card" style="max-width:600px;">
        <div class="text-center mb-4">
            <i class="bi bi-person-plus-fill" style="font-size:2.5rem;color:#0d3b66;"></i>
            <h2 class="mt-2">Create Your Account</h2>
            <p class="text-muted">Register to start booking flights with SkyWings</p>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-airline-danger alert-auto-dismiss">${errorMessage}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm" class="needs-validation" novalidate>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="firstName" class="form-label">First Name</label>
                    <input type="text" class="form-control" id="firstName" name="firstName" placeholder="John" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="lastName" class="form-label">Last Name</label>
                    <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Doe" required>
                </div>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="you@example.com" required>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label">Phone Number</label>
                <input type="text" class="form-control" id="phone" name="phone" placeholder="10-digit mobile number" pattern="[0-9]{10}" required>
            </div>

            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <textarea class="form-control" id="address" name="address" rows="2" placeholder="Your address"></textarea>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Min 6 characters" minlength="6" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Re-enter password" minlength="6" required>
                    <small id="confirmPasswordError" class="text-danger" style="display:none;">Passwords do not match.</small>
                </div>
            </div>

            <button type="submit" class="btn btn-primary-airline w-100 mt-2">Create Account</button>
        </form>

        <p class="text-center mt-4 mb-0 text-muted">
            Already have an account? <a href="${pageContext.request.contextPath}/login.jsp">Login here</a>
        </p>
    </div>
</div>

<%@ include file="/includes/footer.jsp" %>
