<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="My Profile - SkyWings Airlines" scope="request"/>
<%@ include file="/includes/header.jsp" %>

<div class="page-header">
    <div class="container">
        <h1><i class="bi bi-person-circle"></i> My Profile</h1>
        <p class="mb-0">View and update your personal information</p>
    </div>
</div>

<div class="container">
    <div class="form-card mx-auto" style="max-width:600px;">

        <c:if test="${not empty successMessage}">
            <div class="alert alert-airline-success alert-auto-dismiss">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-airline-danger alert-auto-dismiss">${errorMessage}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/customer/profile" method="post" class="needs-validation" novalidate>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="firstName" class="form-label">First Name</label>
                    <input type="text" class="form-control" id="firstName" name="firstName" value="${sessionScope.loggedInUser.firstName}" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="lastName" class="form-label">Last Name</label>
                    <input type="text" class="form-control" id="lastName" name="lastName" value="${sessionScope.loggedInUser.lastName}" required>
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <input type="email" class="form-control" value="${sessionScope.loggedInUser.email}" disabled>
                <small class="text-muted">Email address cannot be changed.</small>
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">Phone Number</label>
                <input type="text" class="form-control" id="phone" name="phone" value="${sessionScope.loggedInUser.phone}">
            </div>
            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <textarea class="form-control" id="address" name="address" rows="2">${sessionScope.loggedInUser.address}</textarea>
            </div>
            <button type="submit" class="btn btn-primary-airline w-100">Update Profile</button>
        </form>
    </div>
</div>

<%@ include file="/includes/footer.jsp" %>
