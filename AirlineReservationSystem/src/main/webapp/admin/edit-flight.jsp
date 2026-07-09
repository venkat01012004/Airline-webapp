<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Edit Flight - SkyWings Airlines" scope="request"/>
<%@ include file="/admin/admin-header.jsp" %>

<div class="page-header">
    <div class="container">
        <h1><i class="bi bi-pencil-square"></i> Edit Flight</h1>
        <p class="mb-0">Update flight schedule and pricing</p>
    </div>
</div>

<div class="container">
    <div class="form-card mx-auto" style="max-width:720px;">

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-airline-danger">${errorMessage}</div>
        </c:if>

        <c:if test="${empty flight}">
            <div class="alert alert-airline-danger">Flight not found.</div>
        </c:if>

        <c:if test="${not empty flight}">
            <form action="${pageContext.request.contextPath}/admin/flights" method="post" class="needs-validation" novalidate>
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="flightId" value="${flight.flightId}">

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="flightNumber" class="form-label">Flight Number</label>
                        <input type="text" class="form-control" id="flightNumber" name="flightNumber" value="${flight.flightNumber}" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="airlineName" class="form-label">Airline Name</label>
                        <input type="text" class="form-control" id="airlineName" name="airlineName" value="${flight.airlineName}" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="source" class="form-label">Source City</label>
                        <input type="text" class="form-control" id="source" name="source" value="${flight.source}" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="destination" class="form-label">Destination City</label>
                        <input type="text" class="form-control" id="destination" name="destination" value="${flight.destination}" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="departureTime" class="form-label">Departure Date &amp; Time</label>
                        <input type="datetime-local" class="form-control" id="departureTime" name="departureTime"
                               value="<fmt:formatDate value="${flight.departureTime}" pattern="yyyy-MM-dd'T'HH:mm"/>" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="arrivalTime" class="form-label">Arrival Date &amp; Time</label>
                        <input type="datetime-local" class="form-control" id="arrivalTime" name="arrivalTime"
                               value="<fmt:formatDate value="${flight.arrivalTime}" pattern="yyyy-MM-dd'T'HH:mm"/>" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label for="totalSeats" class="form-label">Total Seats</label>
                        <input type="number" class="form-control" id="totalSeats" name="totalSeats" min="1" value="${flight.totalSeats}" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="availableSeats" class="form-label">Available Seats</label>
                        <input type="number" class="form-control" id="availableSeats" name="availableSeats" min="0" value="${flight.availableSeats}" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="price" class="form-label">Price per Seat (Rs.)</label>
                        <input type="number" step="0.01" class="form-control" id="price" name="price" min="1" value="${flight.price}" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="status" class="form-label">Status</label>
                    <select class="form-select" id="status" name="status">
                        <option value="SCHEDULED" ${flight.status == 'SCHEDULED' ? 'selected' : ''}>Scheduled</option>
                        <option value="CANCELLED" ${flight.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                        <option value="COMPLETED" ${flight.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary-airline w-100 mt-2">Update Flight</button>
            </form>
        </c:if>
    </div>
</div>

<%@ include file="/admin/admin-footer.jsp" %>
