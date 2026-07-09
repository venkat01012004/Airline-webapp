package com.airline.controller;

import com.airline.model.Flight;
import com.airline.service.FlightService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Handles flight search requests submitted from search-flight.jsp / the
 * homepage search widget. Displays matching results back on search-flight.jsp.
 */
@WebServlet(name = "SearchFlightServlet", urlPatterns = {"/search-flight"})
public class SearchFlightServlet extends HttpServlet {

    private final FlightService flightService = new FlightService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleSearch(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleSearch(request, response);
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String source = request.getParameter("source");
        String destination = request.getParameter("destination");
        String date = request.getParameter("date");

        try {
            List<Flight> results = flightService.searchFlights(source, destination, date);
            request.setAttribute("flights", results);
            request.setAttribute("searched", true);
            request.setAttribute("source", source);
            request.setAttribute("destination", destination);
            request.setAttribute("date", date);

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Unable to search flights right now. Please try again later.");
        }

        request.getRequestDispatcher("/search-flight.jsp").forward(request, response);
    }
}
