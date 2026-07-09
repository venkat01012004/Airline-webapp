<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Manage Users - SkyWings Airlines" scope="request"/>
<%@ include file="/admin/admin-header.jsp" %>

<div class="page-header">
    <div class="container">
        <h1><i class="bi bi-people"></i> Manage Users</h1>
        <p class="mb-0">All registered customers and administrators</p>
    </div>
</div>

<div class="container">

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-airline-danger">${errorMessage}</div>
    </c:if>

    <div class="form-card">
        <div class="table-responsive">
            <table class="table table-airline table-hover align-middle">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Joined On</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.userId}</td>
                        <td class="fw-semibold">${user.fullName}</td>
                        <td>${user.email}</td>
                        <td>${user.phone}</td>
                        <td>
                            <c:choose>
                                <c:when test="${user.role == 'ADMIN'}"><span class="badge-status badge-pending">Admin</span></c:when>
                                <c:otherwise><span class="badge-status badge-confirmed">Customer</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${user.status == 'ACTIVE'}"><span class="badge-status badge-confirmed">Active</span></c:when>
                                <c:otherwise><span class="badge-status badge-cancelled">Inactive</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td><fmt:formatDate value="${user.createdAt}" pattern="dd MMM yyyy"/></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty users}">
                    <tr><td colspan="7" class="text-center text-muted py-4">No users found.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="/admin/admin-footer.jsp" %>
