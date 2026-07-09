<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.airline.service.FlightService" %>
<%@ page import="com.airline.service.BookingService" %>
<%@ page import="com.airline.service.UserService" %>
<%
    int totalFlights = 0;
    int totalBookings = 0;
    int totalUsers = 0;
    double totalRevenue = 0.0;
    try {
        totalFlights = new FlightService().getAllFlights().size();
        BookingService bookingService = new BookingService();
        totalBookings = bookingService.countAllBookings();
        totalRevenue = bookingService.totalRevenue();
        totalUsers = new UserService().getAllUsers().size();
    } catch (Exception e) {
        // Defaults of 0 will be shown if the database is unreachable
    }
    request.setAttribute("totalFlights", totalFlights);
    request.setAttribute("totalBookings", totalBookings);
    request.setAttribute("totalUsers", totalUsers);
    request.setAttribute("totalRevenue", totalRevenue);
%>
<c:set var="pageTitle" value="Admin Dashboard - SkyWings Airlines" scope="request"/>
<%@ include file="/admin/admin-header.jsp" %>

<div class="page-header">
    <div class="container">
        <h1><i class="bi bi-speedometer2"></i> Admin Dashboard</h1>
        <p class="mb-0">Overview of flights, bookings and revenue</p>
    </div>
</div>

<div class="container">

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-airline-danger">${errorMessage}</div>
    </c:if>

    <div class="row g-4 mb-4">
        <div class="col-md-3 col-sm-6">
            <div class="stat-card">
                <span>Total Flights</span>
                <h3>${totalFlights}</h3>
                <i class="bi bi-airplane"></i>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="stat-card">
                <span>Total Bookings</span>
                <h3>${totalBookings}</h3>
                <i class="bi bi-ticket-perforated"></i>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="stat-card">
                <span>Registered Users</span>
                <h3>${totalUsers}</h3>
                <i class="bi bi-people"></i>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="stat-card">
                <span>Total Revenue</span>
                <h3>Rs. <fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/></h3>
                <i class="bi bi-cash-stack"></i>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-md-4">
            <div class="feature-card">
                <div class="feature-icon"><i class="bi bi-airplane"></i></div>
                <h5>Manage Flights</h5>
                <p class="text-muted small">Add new flights, update schedules, and manage seat inventory.</p>
                <a href="${pageContext.request.contextPath}/admin/flights?action=list" class="btn btn-primary-airline btn-sm">Go to Flights</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="feature-card">
                <div class="feature-icon"><i class="bi bi-ticket-perforated"></i></div>
                <h5>View Bookings</h5>
                <p class="text-muted small">Review every booking made by customers across all flights.</p>
                <a href="${pageContext.request.contextPath}/admin/bookings" class="btn btn-primary-airline btn-sm">Go to Bookings</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="feature-card">
                <div class="feature-icon"><i class="bi bi-people"></i></div>
                <h5>Manage Users</h5>
                <p class="text-muted small">View all registered customers and administrators.</p>
                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary-airline btn-sm">Go to Users</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="/admin/admin-footer.jsp" %>
