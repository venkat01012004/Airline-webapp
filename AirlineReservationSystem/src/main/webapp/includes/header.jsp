<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- ============================================================
     Shared Header / Navigation Bar
     Included at the top of every public-facing JSP page.
     Expects the servlet context path to be available as ${pageContext.request.contextPath}
     ============================================================ -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${pageTitle != null ? pageTitle : 'SkyWings Airlines'}"/></title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <!-- Custom Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-airline sticky-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
            <i class="bi bi-airplane-engines-fill"></i> Sky<span>Wings</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="mainNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/search-flight.jsp">Search Flights</a>
                </li>
                <c:if test="${sessionScope.loggedInUser != null && sessionScope.role == 'CUSTOMER'}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/my-bookings">My Bookings</a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.loggedInUser != null && sessionScope.role == 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard.jsp">Admin Dashboard</a>
                    </li>
                </c:if>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
                </li>
            </ul>

            <ul class="navbar-nav ms-auto align-items-lg-center">
                <c:choose>
                    <c:when test="${sessionScope.loggedInUser != null}">
                        <li class="nav-item me-2">
                            <span class="nav-link">
                                <i class="bi bi-person-circle"></i> ${sessionScope.userName}
                            </span>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/logout">Logout</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item me-2">
                            <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/login.jsp">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-accent btn-sm" href="${pageContext.request.contextPath}/register.jsp">Register</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
