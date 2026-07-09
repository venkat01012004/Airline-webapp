package com.airline.dao;

import com.airline.model.Flight;
import com.airline.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for the "flights" table.
 * Handles all CRUD operations and search queries for flights.
 */
public class FlightDAO {

    /**
     * Adds a new flight - used by the admin flight management screens.
     */
    public boolean addFlight(Flight flight) throws SQLException {
        String sql = "INSERT INTO flights (flight_number, airline_name, source, destination, " +
                     "departure_time, arrival_time, total_seats, available_seats, price, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, flight.getFlightNumber());
            ps.setString(2, flight.getAirlineName());
            ps.setString(3, flight.getSource());
            ps.setString(4, flight.getDestination());
            ps.setTimestamp(5, flight.getDepartureTime());
            ps.setTimestamp(6, flight.getArrivalTime());
            ps.setInt(7, flight.getTotalSeats());
            ps.setInt(8, flight.getAvailableSeats());
            ps.setDouble(9, flight.getPrice());
            ps.setString(10, flight.getStatus() == null ? "SCHEDULED" : flight.getStatus());

            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Updates an existing flight's details.
     */
    public boolean updateFlight(Flight flight) throws SQLException {
        String sql = "UPDATE flights SET flight_number = ?, airline_name = ?, source = ?, destination = ?, " +
                     "departure_time = ?, arrival_time = ?, total_seats = ?, available_seats = ?, price = ?, " +
                     "status = ? WHERE flight_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, flight.getFlightNumber());
            ps.setString(2, flight.getAirlineName());
            ps.setString(3, flight.getSource());
            ps.setString(4, flight.getDestination());
            ps.setTimestamp(5, flight.getDepartureTime());
            ps.setTimestamp(6, flight.getArrivalTime());
            ps.setInt(7, flight.getTotalSeats());
            ps.setInt(8, flight.getAvailableSeats());
            ps.setDouble(9, flight.getPrice());
            ps.setString(10, flight.getStatus());
            ps.setInt(11, flight.getFlightId());

            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Deletes a flight by its primary key.
     */
    public boolean deleteFlight(int flightId) throws SQLException {
        String sql = "DELETE FROM flights WHERE flight_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, flightId);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Retrieves a single flight by its primary key.
     */
    public Flight findById(int flightId) throws SQLException {
        String sql = "SELECT * FROM flights WHERE flight_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, flightId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        }
        return null;
    }

    /**
     * Returns every flight in the system - used by the admin dashboard.
     */
    public List<Flight> findAll() throws SQLException {
        List<Flight> flights = new ArrayList<>();
        String sql = "SELECT * FROM flights ORDER BY departure_time ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                flights.add(mapRow(rs));
            }
        }
        return flights;
    }

    /**
     * Searches for available, scheduled flights matching the given source,
     * destination and departure date.
     *
     * @param source      departure city
     * @param destination arrival city
     * @param date        travel date in "yyyy-MM-dd" format (nullable)
     */
    public List<Flight> searchFlights(String source, String destination, String date) throws SQLException {
        List<Flight> flights = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT * FROM flights WHERE status = 'SCHEDULED' AND available_seats > 0 ");

        if (source != null && !source.trim().isEmpty()) {
            sql.append("AND source LIKE ? ");
        }
        if (destination != null && !destination.trim().isEmpty()) {
            sql.append("AND destination LIKE ? ");
        }
        if (date != null && !date.trim().isEmpty()) {
            sql.append("AND DATE(departure_time) = ? ");
        }
        sql.append("ORDER BY departure_time ASC");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (source != null && !source.trim().isEmpty()) {
                ps.setString(idx++, "%" + source.trim() + "%");
            }
            if (destination != null && !destination.trim().isEmpty()) {
                ps.setString(idx++, "%" + destination.trim() + "%");
            }
            if (date != null && !date.trim().isEmpty()) {
                ps.setString(idx++, date.trim());
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    flights.add(mapRow(rs));
                }
            }
        }
        return flights;
    }

    /**
     * Decreases the available seat count for a flight after a successful
     * booking. Returns false if not enough seats are available (prevents
     * overbooking).
     */
    public boolean decreaseAvailableSeats(int flightId, int seatsToBook) throws SQLException {
        String sql = "UPDATE flights SET available_seats = available_seats - ? " +
                     "WHERE flight_id = ? AND available_seats >= ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, seatsToBook);
            ps.setInt(2, flightId);
            ps.setInt(3, seatsToBook);

            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Increases the available seat count for a flight after a booking is
     * cancelled.
     */
    public boolean increaseAvailableSeats(int flightId, int seatsToRelease) throws SQLException {
        String sql = "UPDATE flights SET available_seats = available_seats + ? WHERE flight_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, seatsToRelease);
            ps.setInt(2, flightId);

            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Maps the current row of a ResultSet to a Flight object.
     */
    private Flight mapRow(ResultSet rs) throws SQLException {
        Flight flight = new Flight();
        flight.setFlightId(rs.getInt("flight_id"));
        flight.setFlightNumber(rs.getString("flight_number"));
        flight.setAirlineName(rs.getString("airline_name"));
        flight.setSource(rs.getString("source"));
        flight.setDestination(rs.getString("destination"));
        flight.setDepartureTime(rs.getTimestamp("departure_time"));
        flight.setArrivalTime(rs.getTimestamp("arrival_time"));
        flight.setTotalSeats(rs.getInt("total_seats"));
        flight.setAvailableSeats(rs.getInt("available_seats"));
        flight.setPrice(rs.getDouble("price"));
        flight.setStatus(rs.getString("status"));
        flight.setCreatedAt(rs.getTimestamp("created_at"));
        return flight;
    }
}
