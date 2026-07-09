<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="My Bookings - SkyWings Airlines" scope="request"/>
<%@ include file="/includes/header.jsp" %>

<div class="page-header">
    <div class="container">
        <h1><i class="bi bi-journal-check"></i> My Bookings</h1>
        <p class="mb-0">View and manage your flight bookings</p>
    </div>
</div>

<div class="container">

    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-airline-success alert-auto-dismiss">${sessionScope.successMessage}</div>
        <c:remove var="successMessage" scope="session"/>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-airline-danger">${errorMessage}</div>
    </c:if>

    <c:choose>
        <c:when test="${not empty bookings}">
            <c:forEach var="booking" items="${bookings}">
                <div class="flight-card">
                    <div class="row align-items-center">
                        <div class="col-md-2">
                            <div class="text-muted small">PNR</div>
                            <div class="fw-bold">${booking.pnr}</div>
                        </div>
                        <div class="col-md-3">
                            <div class="flight-route">${booking.source} <i class="bi bi-arrow-right"></i> ${booking.destination}</div>
                            <div class="text-muted small">${booking.airlineName} &bull; ${booking.flightNumber}</div>
                        </div>
                        <div class="col-md-2">
                            <div class="text-muted small">Departure</div>
                            <div class="fw-semibold small"><fmt:formatDate value="${booking.departureTime}" pattern="dd MMM yyyy, hh:mm a"/></div>
                        </div>
                        <div class="col-md-2">
                            <div class="text-muted small">Passenger</div>
                            <div class="fw-semibold small">${booking.passengerName} (${booking.numSeats} seat<c:if test="${booking.numSeats > 1}">s</c:if>)</div>
                        </div>
                        <div class="col-md-1">
                            <c:choose>
                                <c:when test="${booking.bookingStatus == 'CONFIRMED'}">
                                    <span class="badge-status badge-confirmed">Confirmed</span>
                                </c:when>
                                <c:when test="${booking.bookingStatus == 'CANCELLED'}">
                                    <span class="badge-status badge-cancelled">Cancelled</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge-status badge-pending">Pending</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="col-md-2 text-md-end mt-3 mt-md-0">
                            <div class="fw-bold mb-2">Rs. <fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0"/></div>
                            <c:if test="${booking.bookingStatus == 'CONFIRMED'}">
                                <a href="${pageContext.request.contextPath}/my-bookings?action=cancel&bookingId=${booking.bookingId}"
                                   class="btn btn-outline-airline btn-sm"
                                   onclick="return confirmCancelBooking('${booking.pnr}')">Cancel</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="alert alert-light border text-center">
                You haven't made any bookings yet.
                <a href="${pageContext.request.contextPath}/search-flight.jsp">Search for flights</a> to get started.
            </div>
        </c:otherwise>
    </c:choose>

</div>

<%@ include file="/includes/footer.jsp" %>
