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
<c:set var="pageTitle" value="Payment - SkyWings Airlines" scope="request"/>
<%@ include file="/includes/header.jsp" %>

<div class="page-header">
    <div class="container">
        <h1><i class="bi bi-credit-card"></i> Payment</h1>
        <p class="mb-0">Complete your payment to confirm your booking</p>
    </div>
</div>

<div class="container">

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-airline-danger">${errorMessage}</div>
    </c:if>

    <c:if test="${empty booking}">
        <div class="alert alert-airline-danger">Booking could not be found. Please try booking again.</div>
        <a href="${pageContext.request.contextPath}/search-flight.jsp" class="btn btn-primary-airline">Back to Search</a>
    </c:if>

    <c:if test="${not empty booking}">
        <div class="row">
            <div class="col-lg-5 mb-4">
                <div class="form-card">
                    <h5 class="mb-3">Booking Summary</h5>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">PNR</span>
                        <span class="fw-semibold">${booking.pnr}</span>
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
                        <span class="text-muted">Passenger</span>
                        <span class="fw-semibold">${booking.passengerName}</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Seats</span>
                        <span class="fw-semibold">${booking.numSeats}</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="text-muted">Total Payable</span>
                        <span class="flight-price">Rs. <fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00"/></span>
                    </div>
                </div>
            </div>

            <div class="col-lg-7 mb-4">
                <div class="form-card">
                    <h5 class="mb-3">Payment Details</h5>
                    <form action="${pageContext.request.contextPath}/process-payment" method="post" class="needs-validation" novalidate>
                        <input type="hidden" name="bookingId" value="${booking.bookingId}">

                        <div class="mb-3">
                            <label for="paymentMethod" class="form-label">Payment Method</label>
                            <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                                <option value="Credit Card">Credit Card</option>
                                <option value="Debit Card">Debit Card</option>
                                <option value="Net Banking">Net Banking</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="cardName" class="form-label">Name on Card</label>
                            <input type="text" class="form-control" id="cardName" name="cardName" placeholder="John Doe" required>
                        </div>

                        <div class="mb-3">
                            <label for="cardNumber" class="form-label">Card Number</label>
                            <input type="text" class="form-control" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456" maxlength="19" required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="expiry" class="form-label">Expiry (MM/YY)</label>
                                <input type="text" class="form-control" id="expiry" name="expiry" placeholder="MM/YY" maxlength="5" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="cvv" class="form-label">CVV</label>
                                <input type="password" class="form-control" id="cvv" name="cvv" placeholder="123" maxlength="3" required>
                            </div>
                        </div>

                        <div class="alert alert-light border small">
                            <i class="bi bi-shield-lock"></i> This is a simulated payment gateway for demonstration purposes. No real transaction will occur.
                        </div>

                        <button type="submit" class="btn btn-primary-airline w-100">
                            Pay Rs. <fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00"/>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </c:if>
</div>

<%@ include file="/includes/footer.jsp" %>
