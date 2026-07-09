package com.airline.controller;

import com.airline.model.Flight;
import com.airline.service.FlightService;
import com.airline.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 * Handles all admin flight-management actions: list, add, edit, delete.
 * The requested action is determined by the "action" request parameter.
 */
@WebServlet(name = "AdminFlightServlet", urlPatterns = {"/admin/flights"})
public class AdminFlightServlet extends HttpServlet {

    private final FlightService flightService = new FlightService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "edit":
                    handleEditForm(request, response);
                    break;
                case "delete":
                    handleDelete(request, response);
                    break;
                case "list":
                default:
                    handleList(request, response);
                    break;
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "A database error occurred. Please try again later.");
            request.getRequestDispatcher("/admin/manage-flights.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("update".equals(action)) {
                handleUpdate(request, response);
            } else {
                handleAdd(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "A database error occurred while saving the flight.");
            request.getRequestDispatcher("/admin/add-flight.jsp").forward(request, response);
        }
    }

    private void handleList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        request.setAttribute("flights", flightService.getAllFlights());
        request.getRequestDispatcher("/admin/manage-flights.jsp").forward(request, response);
    }

    private void handleEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String idParam = request.getParameter("id");
        if (ValidationUtil.isPositiveInteger(idParam)) {
            Flight flight = flightService.getFlightById(Integer.parseInt(idParam));
            request.setAttribute("flight", flight);
        }
        request.getRequestDispatcher("/admin/edit-flight.jsp").forward(request, response);
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {
        String idParam = request.getParameter("id");
        if (ValidationUtil.isPositiveInteger(idParam)) {
            flightService.deleteFlight(Integer.parseInt(idParam));
        }
        response.sendRedirect(request.getContextPath() + "/admin/flights?action=list");
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        Flight flight = buildFlightFromRequest(request, false);

        if (flight == null) {
            request.setAttribute("errorMessage", "Please fill in all flight fields correctly.");
            request.getRequestDispatcher("/admin/add-flight.jsp").forward(request, response);
            return;
        }

        flightService.addFlight(flight);
        response.sendRedirect(request.getContextPath() + "/admin/flights?action=list");
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        Flight flight = buildFlightFromRequest(request, true);

        if (flight == null) {
            request.setAttribute("errorMessage", "Please fill in all flight fields correctly.");
            request.getRequestDispatcher("/admin/edit-flight.jsp").forward(request, response);
            return;
        }

        flightService.updateFlight(flight);
        response.sendRedirect(request.getContextPath() + "/admin/flights?action=list");
    }

    /**
     * Builds a Flight object from submitted form fields. Returns null if
     * required fields are missing or malformed.
     */
    private Flight buildFlightFromRequest(HttpServletRequest request, boolean isUpdate) {
        String flightIdParam = request.getParameter("flightId");
        String flightNumber = request.getParameter("flightNumber");
        String airlineName = request.getParameter("airlineName");
        String source = request.getParameter("source");
        String destination = request.getParameter("destination");
        String departureTime = request.getParameter("departureTime");
        String arrivalTime = request.getParameter("arrivalTime");
        String totalSeatsParam = request.getParameter("totalSeats");
        String availableSeatsParam = request.getParameter("availableSeats");
        String priceParam = request.getParameter("price");
        String status = request.getParameter("status");

        if (ValidationUtil.isNullOrEmpty(flightNumber) || ValidationUtil.isNullOrEmpty(airlineName)
                || ValidationUtil.isNullOrEmpty(source) || ValidationUtil.isNullOrEmpty(destination)
                || ValidationUtil.isNullOrEmpty(departureTime) || ValidationUtil.isNullOrEmpty(arrivalTime)
                || !ValidationUtil.isPositiveInteger(totalSeatsParam) || ValidationUtil.isNullOrEmpty(priceParam)) {
            return null;
        }

        if (isUpdate && !ValidationUtil.isPositiveInteger(flightIdParam)) {
            return null;
        }

        try {
            Flight flight = new Flight();
            if (isUpdate) {
                flight.setFlightId(Integer.parseInt(flightIdParam));
                flight.setAvailableSeats(ValidationUtil.isPositiveInteger(availableSeatsParam)
                        ? Integer.parseInt(availableSeatsParam) : Integer.parseInt(totalSeatsParam));
            }
            flight.setFlightNumber(flightNumber.trim());
            flight.setAirlineName(airlineName.trim());
            flight.setSource(source.trim());
            flight.setDestination(destination.trim());
            flight.setDepartureTime(Timestamp.valueOf(departureTime.replace("T", " ") + ":00"));
            flight.setArrivalTime(Timestamp.valueOf(arrivalTime.replace("T", " ") + ":00"));
            flight.setTotalSeats(Integer.parseInt(totalSeatsParam));
            flight.setPrice(Double.parseDouble(priceParam));
            flight.setStatus(ValidationUtil.isNullOrEmpty(status) ? "SCHEDULED" : status);

            return flight;

        } catch (Exception e) {
            return null;
        }
    }
}
