<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Manage Flights - SkyWings Airlines" scope="request"/>
<%@ include file="/admin/admin-header.jsp" %>

<div class="page-header">
    <div class="container d-flex justify-content-between align-items-center flex-wrap">
        <div>
            <h1><i class="bi bi-airplane"></i> Manage Flights</h1>
            <p class="mb-0">Add, edit or remove flights from the system</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/add-flight.jsp" class="btn btn-accent mt-3 mt-md-0">
            <i class="bi bi-plus-circle"></i> Add New Flight
        </a>
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
                    <th>Flight No.</th>
                    <th>Airline</th>
                    <th>Route</th>
                    <th>Departure</th>
                    <th>Seats</th>
                    <th>Price</th>
                    <th>Status</th>
                    <th class="text-end">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="flight" items="${flights}">
                    <tr>
                        <td class="fw-semibold">${flight.flightNumber}</td>
                        <td>${flight.airlineName}</td>
                        <td>${flight.source} <i class="bi bi-arrow-right"></i> ${flight.destination}</td>
                        <td><fmt:formatDate value="${flight.departureTime}" pattern="dd MMM yyyy, hh:mm a"/></td>
                        <td>${flight.availableSeats} / ${flight.totalSeats}</td>
                        <td>Rs. <fmt:formatNumber value="${flight.price}" pattern="#,##0"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${flight.status == 'SCHEDULED'}"><span class="badge-status badge-confirmed">Scheduled</span></c:when>
                                <c:when test="${flight.status == 'CANCELLED'}"><span class="badge-status badge-cancelled">Cancelled</span></c:when>
                                <c:otherwise><span class="badge-status badge-pending">Completed</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-end">
                            <a href="${pageContext.request.contextPath}/admin/flights?action=edit&id=${flight.flightId}" class="btn btn-sm btn-outline-airline">Edit</a>
                            <a href="${pageContext.request.contextPath}/admin/flights?action=delete&id=${flight.flightId}"
                               class="btn btn-sm btn-outline-danger"
                               onclick="return confirmDeleteFlight('${flight.flightNumber}')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty flights}">
                    <tr><td colspan="8" class="text-center text-muted py-4">No flights found. Add your first flight to get started.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="/admin/admin-footer.jsp" %>
