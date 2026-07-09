<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- ============================================================
     Admin Header - shared across all admin/*.jsp pages
     ============================================================ -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${pageTitle != null ? pageTitle : 'Admin - SkyWings Airlines'}"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-airline sticky-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard.jsp">
            <i class="bi bi-speedometer2"></i> SkyWings <span>Admin</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="adminNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard.jsp">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/flights?action=list">Manage Flights</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/bookings">All Bookings</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/users">Manage Users</a></li>
            </ul>
            <ul class="navbar-nav ms-auto align-items-lg-center">
                <li class="nav-item me-2">
                    <span class="nav-link"><i class="bi bi-person-circle"></i> ${sessionScope.userName}</span>
                </li>
                <li class="nav-item">
                    <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/logout">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
