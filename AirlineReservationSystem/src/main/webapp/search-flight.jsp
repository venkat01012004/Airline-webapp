<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Search Flights - SkyWings Airlines" scope="request"/>
<%@ include file="/includes/header.jsp" %>

<div class="page-header">
    <div class="container">
        <h1><i class="bi bi-search"></i> Search Flights</h1>
        <p class="mb-0">Find the best flights for your next journey</p>
    </div>
</div>

<div class="container">

    <div class="form-card mb-5">
        <form action="${pageContext.request.contextPath}/search-flight" method="get" class="row g-3 align-items-end">
            <div class="col-md-3">
                <label for="source">From</label>
                <input type="text" class="form-control" id="source" name="source" placeholder="e.g. Hyderabad" value="${source}">
            </div>
            <div class="col-md-1 text-center">
                <button type="button" id="swapLocationsBtn" class="btn btn-outline-airline w-100" title="Swap">
                    <i class="bi bi-arrow-left-right"></i>
                </button>
            </div>
            <div class="col-md-3">
                <label for="destination">To</label>
                <input type="text" class="form-control" id="destination" name="destination" placeholder="e.g. Delhi" value="${destination}">
            </div>
            <div class="col-md-3">
                <label for="date">Departure Date</label>
                <input type="date" class="form-control" id="date" name="date" value="${date}">
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary-airline w-100"><i class="bi bi-search"></i> Search</button>
            </div>
        </form>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-airline-danger">${errorMessage}</div>
    </c:if>

    <c:choose>
        <c:when test="${not empty flights}">
            <h5 class="mb-3">${flights.size()} flight(s) found</h5>
            <c:forEach var="flight" items="${flights}">
                <div class="flight-card">
                    <div class="row align-items-center">
                        <div class="col-md-3">
                            <div class="flight-route">${flight.source} <i class="bi bi-arrow-right"></i> ${flight.destination}</div>
                            <div class="text-muted small">${flight.airlineName} &bull; ${flight.flightNumber}</div>
                        </div>
                        <div class="col-md-3">
                            <div class="text-muted small">Departure</div>
                            <div class="fw-semibold"><fmt:formatDate value="${flight.departureTime}" pattern="dd MMM yyyy, hh:mm a"/></div>
                        </div>
                        <div class="col-md-2">
                            <div class="text-muted small">Arrival</div>
                            <div class="fw-semibold"><fmt:formatDate value="${flight.arrivalTime}" pattern="hh:mm a"/></div>
                        </div>
                        <div class="col-md-2">
                            <span class="flight-badge">${flight.availableSeats} seats left</span>
                        </div>
                        <div class="col-md-2 text-md-end mt-3 mt-md-0">
                            <div class="flight-price mb-2">Rs. <fmt:formatNumber value="${flight.price}" pattern="#,##0"/></div>
                            <a href="${pageContext.request.contextPath}/book-flight?flightId=${flight.flightId}" class="btn btn-primary-airline btn-sm w-100">Book Now</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:when test="${searched}">
            <div class="alert alert-airline-danger text-center">No flights found matching your search criteria. Try different cities or dates.</div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-light border text-center">Enter your travel details above to search for available flights.</div>
        </c:otherwise>
    </c:choose>

</div>

<%@ include file="/includes/footer.jsp" %>
