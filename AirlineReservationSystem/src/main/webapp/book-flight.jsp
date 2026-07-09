<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Book Flight - SkyWings Airlines" scope="request"/>
<%@ include file="/includes/header.jsp" %>

<div class="page-header">
    <div class="container">
        <h1><i class="bi bi-ticket-perforated"></i> Book Your Flight</h1>
        <p class="mb-0">Please review the flight details and enter passenger information</p>
    </div>
</div>

<div class="container">

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-airline-danger">${errorMessage}</div>
    </c:if>

    <c:if test="${empty flight}">
        <div class="alert alert-airline-danger">Flight details could not be loaded. Please search again.</div>
        <a href="${pageContext.request.contextPath}/search-flight.jsp" class="btn btn-primary-airline">Back to Search</a>
    </c:if>

    <c:if test="${not empty flight}">
        <div class="row">
            <div class="col-lg-5 mb-4">
                <div class="form-card">
                    <h5 class="mb-3">Flight Details</h5>
                    <div class="flight-route mb-2">${flight.source} <i class="bi bi-arrow-right"></i> ${flight.destination}</div>
                    <p class="text-muted mb-1">${flight.airlineName} &bull; ${flight.flightNumber}</p>
                    <hr>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Departure</span>
                        <span class="fw-semibold"><fmt:formatDate value="${flight.departureTime}" pattern="dd MMM yyyy, hh:mm a"/></span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Arrival</span>
                        <span class="fw-semibold"><fmt:formatDate value="${flight.arrivalTime}" pattern="dd MMM yyyy, hh:mm a"/></span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Seats Available</span>
                        <span class="fw-semibold">${flight.availableSeats}</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="text-muted">Price per Seat</span>
                        <span class="flight-price">Rs. <fmt:formatNumber value="${flight.price}" pattern="#,##0"/></span>
                    </div>
                </div>
            </div>

            <div class="col-lg-7 mb-4">
                <div class="form-card">
                    <h5 class="mb-3">Passenger Details</h5>
                    <form action="${pageContext.request.contextPath}/book-flight" method="post" class="needs-validation" novalidate>
                        <input type="hidden" name="flightId" value="${flight.flightId}">

                        <div class="mb-3">
                            <label for="passengerName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="passengerName" name="passengerName" placeholder="As per government ID" required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="passengerAge" class="form-label">Age</label>
                                <input type="number" class="form-control" id="passengerAge" name="passengerAge" min="1" max="120" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="passengerGender" class="form-label">Gender</label>
                                <select class="form-select" id="passengerGender" name="passengerGender" required>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="numSeats" class="form-label">Number of Seats</label>
                            <input type="number" class="form-control" id="numSeats" name="numSeats" min="1" max="${flight.availableSeats}" value="1" required>
                            <span id="pricePerSeat" data-price="${flight.price}"></span>
                        </div>

                        <div class="alert alert-light border d-flex justify-content-between align-items-center">
                            <span class="fw-semibold">Total Amount</span>
                            <span id="totalAmountDisplay" class="fw-bold fs-5">Rs. <fmt:formatNumber value="${flight.price}" pattern="#,##0"/></span>
                        </div>

                        <button type="submit" class="btn btn-primary-airline w-100">Continue to Payment</button>
                    </form>
                </div>
            </div>
        </div>
    </c:if>
</div>

<%@ include file="/includes/footer.jsp" %>
