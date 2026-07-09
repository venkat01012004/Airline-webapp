<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Add Flight - SkyWings Airlines" scope="request"/>
<%@ include file="/admin/admin-header.jsp" %>

<div class="page-header">
    <div class="container">
        <h1><i class="bi bi-plus-circle"></i> Add New Flight</h1>
        <p class="mb-0">Create a new flight schedule</p>
    </div>
</div>

<div class="container">
    <div class="form-card mx-auto" style="max-width:720px;">

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-airline-danger">${errorMessage}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/flights" method="post" class="needs-validation" novalidate>
            <input type="hidden" name="action" value="add">

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="flightNumber" class="form-label">Flight Number</label>
                    <input type="text" class="form-control" id="flightNumber" name="flightNumber" placeholder="e.g. AI-101" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="airlineName" class="form-label">Airline Name</label>
                    <input type="text" class="form-control" id="airlineName" name="airlineName" placeholder="e.g. Air India" required>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="source" class="form-label">Source City</label>
                    <input type="text" class="form-control" id="source" name="source" placeholder="e.g. Hyderabad" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="destination" class="form-label">Destination City</label>
                    <input type="text" class="form-control" id="destination" name="destination" placeholder="e.g. Delhi" required>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="departureTime" class="form-label">Departure Date &amp; Time</label>
                    <input type="datetime-local" class="form-control" id="departureTime" name="departureTime" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="arrivalTime" class="form-label">Arrival Date &amp; Time</label>
                    <input type="datetime-local" class="form-control" id="arrivalTime" name="arrivalTime" required>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4 mb-3">
                    <label for="totalSeats" class="form-label">Total Seats</label>
                    <input type="number" class="form-control" id="totalSeats" name="totalSeats" min="1" required>
                </div>
                <div class="col-md-4 mb-3">
                    <label for="price" class="form-label">Price per Seat (Rs.)</label>
                    <input type="number" step="0.01" class="form-control" id="price" name="price" min="1" required>
                </div>
                <div class="col-md-4 mb-3">
                    <label for="status" class="form-label">Status</label>
                    <select class="form-select" id="status" name="status">
                        <option value="SCHEDULED">Scheduled</option>
                        <option value="CANCELLED">Cancelled</option>
                        <option value="COMPLETED">Completed</option>
                    </select>
                </div>
            </div>

            <button type="submit" class="btn btn-primary-airline w-100 mt-2">Add Flight</button>
        </form>
    </div>
</div>

<%@ include file="/admin/admin-footer.jsp" %>
