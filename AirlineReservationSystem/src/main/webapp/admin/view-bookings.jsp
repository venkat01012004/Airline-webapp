<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="All Bookings - SkyWings Airlines" scope="request"/>
<%@ include file="/admin/admin-header.jsp" %>

<div class="page-header">
    <div class="container">
        <h1><i class="bi bi-ticket-perforated"></i> All Bookings</h1>
        <p class="mb-0">Every booking made across the SkyWings platform</p>
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
                    <th>PNR</th>
                    <th>Customer</th>
                    <th>Flight</th>
                    <th>Route</th>
                    <th>Departure</th>
                    <th>Seats</th>
                    <th>Amount</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="booking" items="${bookings}">
                    <tr>
                        <td class="fw-semibold">${booking.pnr}</td>
                        <td>${booking.customerEmail}</td>
                        <td>${booking.airlineName} (${booking.flightNumber})</td>
                        <td>${booking.source} <i class="bi bi-arrow-right"></i> ${booking.destination}</td>
                        <td><fmt:formatDate value="${booking.departureTime}" pattern="dd MMM yyyy, hh:mm a"/></td>
                        <td>${booking.numSeats}</td>
                        <td>Rs. <fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${booking.bookingStatus == 'CONFIRMED'}"><span class="badge-status badge-confirmed">Confirmed</span></c:when>
                                <c:when test="${booking.bookingStatus == 'CANCELLED'}"><span class="badge-status badge-cancelled">Cancelled</span></c:when>
                                <c:otherwise><span class="badge-status badge-pending">Pending</span></c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty bookings}">
                    <tr><td colspan="8" class="text-center text-muted py-4">No bookings have been made yet.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="/admin/admin-footer.jsp" %>
