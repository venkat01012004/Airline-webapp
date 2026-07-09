package com.airline.service;

import com.airline.dao.FlightDAO;
import com.airline.model.Flight;

import java.sql.SQLException;
import java.util.List;

/**
 * Service layer for flight-related business logic: searching, and
 * admin CRUD operations for flight management.
 */
public class FlightService {

    private final FlightDAO flightDAO = new FlightDAO();

    public boolean addFlight(Flight flight) throws SQLException {
        // A newly created flight starts with all seats available
        flight.setAvailableSeats(flight.getTotalSeats());
        return flightDAO.addFlight(flight);
    }

    public boolean updateFlight(Flight flight) throws SQLException {
        return flightDAO.updateFlight(flight);
    }

    public boolean deleteFlight(int flightId) throws SQLException {
        return flightDAO.deleteFlight(flightId);
    }

    public Flight getFlightById(int flightId) throws SQLException {
        return flightDAO.findById(flightId);
    }

    public List<Flight> getAllFlights() throws SQLException {
        return flightDAO.findAll();
    }

    public List<Flight> searchFlights(String source, String destination, String date) throws SQLException {
        return flightDAO.searchFlights(source, destination, date);
    }
}
