<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.airline.model.Flight" %>
<%@ page import="com.airline.service.FlightService" %>
<%@ page import="java.util.List" %>
<%
    // Fetch a handful of scheduled flights to feature on the homepage
    FlightService flightService = new FlightService();
    List<Flight> featuredFlights = null;
    try {
        featuredFlights = flightService.getAllFlights();
        if (featuredFlights.size() > 6) {
            featuredFlights = featuredFlights.subList(0, 6);
        }
    } catch (Exception e) {
        featuredFlights = null;
    }
    request.setAttribute("featuredFlights", featuredFlights);
%>
<c:set var="pageTitle" value="SkyWings Airlines - Book Flights Online" scope="request"/>
<%@ include file="/includes/header.jsp" %>

<!-- ================= Hero Section ================= -->
<section class="hero-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-7">
                <h1>Fly Further, <br>Fly with <span style="color:#f4a300;">SkyWings</span></h1>
                <p class="lead mt-3">Book domestic flights across India at the best fares. Simple booking, secure payments, and 24x7 support.</p>
            </div>
        </div>
    </div>
</section>

<!-- ================= Search Card ================= -->
<div class="container">
    <div class="search-card">
        <form action="${pageContext.request.contextPath}/search-flight" method="get" class="row g-3 align-items-end">
            <div class="col-md-4">
                <label for="source">From</label>
                <input type="text" class="form-control" id="source" name="source" placeholder="e.g. Hyderabad" required>
            </div>
            <div class="col-md-1 text-center">
                <button type="button" id="swapLocationsBtn" class="btn btn-outline-airline w-100" title="Swap">
                    <i class="bi bi-arrow-left-right"></i>
                </button>
            </div>
            <div class="col-md-4">
                <label for="destination">To</label>
                <input type="text" class="form-control" id="destination" name="destination" placeholder="e.g. Delhi" required>
            </div>
            <div class="col-md-3">
                <label for="date">Departure Date</label>
                <input type="date" class="form-control" id="date" name="date">
            </div>
            <div class="col-12 mt-4">
                <button type="submit" class="btn btn-primary-airline w-100 w-md-auto px-5">
                    <i class="bi bi-search"></i> Search Flights
                </button>
            </div>
        </form>
    </div>
</div>

<!-- ================= Featured Flights ================= -->
<div class="container mt-5 pt-4">
    <h2 class="section-title text-center">Featured Flights</h2>
    <p class="section-subtitle text-center">A selection of our popular routes available for booking today</p>

    <div class="row">
        <c:choose>
            <c:when test="${empty featuredFlights}">
                <div class="col-12">
                    <div class="alert alert-airline-danger text-center">No flights are currently available. Please check back soon.</div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="flight" items="${featuredFlights}">
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="flight-card h-100 d-flex flex-column justify-content-between">
                            <div>
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="flight-badge"><i class="bi bi-check-circle"></i> ${flight.status}</span>
                                    <span class="text-muted small">${flight.flightNumber}</span>
                                </div>
                                <div class="flight-route mb-1">${flight.source} <i class="bi bi-arrow-right"></i> ${flight.destination}</div>
                                <div class="text-muted small mb-3">${flight.airlineName}</div>
                                <div class="text-muted small">
                                    <i class="bi bi-clock"></i>
                                    <fmt:formatDate value="${flight.departureTime}" pattern="dd MMM yyyy, hh:mm a"/>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <div class="flight-price">Rs. <fmt:formatNumber value="${flight.price}" pattern="#,##0"/><br/><small>${flight.availableSeats} seats left</small></div>
                                <a href="${pageContext.request.contextPath}/book-flight?flightId=${flight.flightId}" class="btn btn-outline-airline">Book Now</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="text-center mt-2">
        <a href="${pageContext.request.contextPath}/search-flight.jsp" class="btn btn-primary-airline px-5">View All Flights</a>
    </div>
</div>

<!-- ================= Why Choose Us ================= -->
<div class="container mt-5 pt-4">
    <h2 class="section-title text-center">Why Choose SkyWings</h2>
    <p class="section-subtitle text-center">We make air travel simple, transparent and affordable</p>

    <div class="row g-4">
        <div class="col-md-3 col-sm-6">
            <div class="feature-card text-center">
                <div class="feature-icon mx-auto"><i class="bi bi-cash-coin"></i></div>
                <h5>Best Fares</h5>
                <p class="text-muted small mb-0">Transparent pricing with no hidden charges on every booking.</p>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="feature-card text-center">
                <div class="feature-icon mx-auto"><i class="bi bi-shield-check"></i></div>
                <h5>Secure Payments</h5>
                <p class="text-muted small mb-0">Your payment information is always encrypted and protected.</p>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="feature-card text-center">
                <div class="feature-icon mx-auto"><i class="bi bi-headset"></i></div>
                <h5>24x7 Support</h5>
                <p class="text-muted small mb-0">Our support team is available around the clock to help you.</p>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="feature-card text-center">
                <div class="feature-icon mx-auto"><i class="bi bi-lightning-charge"></i></div>
                <h5>Instant Booking</h5>
                <p class="text-muted small mb-0">Search, book and pay for your tickets in just a few clicks.</p>
            </div>
        </div>
    </div>
</div>

<%@ include file="/includes/footer.jsp" %>
