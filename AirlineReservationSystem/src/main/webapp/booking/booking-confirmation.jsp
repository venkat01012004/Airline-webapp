<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.airline.model.Booking" %>
<%@ page import="com.airline.service.BookingService" %>
<%
    Booking booking = null;
    String bookingIdParam = request.getParameter("bookingId");
    if (bookingIdParam != null) {
        try {
            int bookingId = Integer.parseInt(bookingIdParam);
            booking = new BookingService().getBookingById(bookingId);
        } catch (Exception e) {
            booking = null;
        }
    }
    request.setAttribute("booking", booking);
%>
<c:set var="pageTitle" value="Booking Confirmed - SkyWings Airlines" scope="request"/>
<%@ include file="/includes/header.jsp" %>

<div class="container">
    <c:if test="${empty booking}">
        <div class="alert alert-airline-danger mt-4">Booking could not be found.</div>
    </c:if>

    <c:if test="${not empty booking}">
        <div class="form-card mx-auto mt-5 mb-5" style="max-width:640px;">
            <div class="text-center mb-4">
                <i class="bi bi-check-circle-fill" style="font-size:3.5rem;color:#1e8e5a;"></i>
                <h2 class="mt-3">Booking Confirmed!</h2>
                <p class="text-muted">Your e-ticket has been generated. Have a pleasant journey.</p>
            </div>

            <div class="alert alert-light border">
                <div class="d-flex justify-content-between mb-2">
                    <span class="text-muted">PNR Number</span>
                    <span class="fw-bold">${booking.pnr}</span>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <span class="text-muted">Passenger</span>
                    <span class="fw-semibold">${booking.passengerName}</span>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <span class="text-muted">Route</span>
                    <span class="fw-semibold">${booking.source} <i class="bi bi-arrow-right"></i> ${booking.destination}</span>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <span class="text-muted">Flight</span>
                    <span class="fw-semibold">${booking.airlineName} (${booking.flightNumber})</span>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <span class="text-muted">Departure</span>
                    <span class="fw-semibold"><fmt:formatDate value="${booking.departureTime}" pattern="dd MMM yyyy, hh:mm a"/></span>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <span class="text-muted">Seats Booked</span>
                    <span class="fw-semibold">${booking.numSeats}</span>
                </div>
                <div class="d-flex justify-content-between">
                    <span class="text-muted">Amount Paid</span>
                    <span class="fw-bold">Rs. <fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00"/></span>
                </div>
            </div>

            <div class="d-flex gap-2 mt-3">
                <a href="${pageContext.request.contextPath}/my-bookings" class="btn btn-primary-airline w-100">View My Bookings</a>
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-airline w-100">Back to Home</a>
            </div>
        </div>
    </c:if>
</div>

<%@ include file="/includes/footer.jsp" %>
