package com.airline.dao;

import com.airline.model.Booking;
import com.airline.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for the "bookings" table.
 * Provides create/read/update operations for flight bookings, including
 * joined queries that pull in flight details for display purposes.
 */
public class BookingDAO {

    /**
     * Creates a new booking and returns the generated booking_id, or -1
     * if the insert failed.
     */
    public int createBooking(Booking booking) throws SQLException {
        String sql = "INSERT INTO bookings (pnr, user_id, flight_id, num_seats, passenger_name, " +
                     "passenger_age, passenger_gender, total_amount, booking_status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, booking.getPnr());
            ps.setInt(2, booking.getUserId());
            ps.setInt(3, booking.getFlightId());
            ps.setInt(4, booking.getNumSeats());
            ps.setString(5, booking.getPassengerName());
            ps.setInt(6, booking.getPassengerAge());
            ps.setString(7, booking.getPassengerGender());
            ps.setDouble(8, booking.getTotalAmount());
            ps.setString(9, booking.getBookingStatus() == null ? "PENDING" : booking.getBookingStatus());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        return keys.getInt(1);
                    }
                }
            }
        }
        return -1;
    }

    /**
     * Updates the status of a booking (e.g. PENDING -> CONFIRMED, or CANCELLED).
     */
    public boolean updateStatus(int bookingId, String status) throws SQLException {
        String sql = "UPDATE bookings SET booking_status = ? WHERE booking_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, bookingId);

            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Retrieves a single booking (with joined flight details) by its id.
     */
    public Booking findById(int bookingId) throws SQLException {
        String sql = "SELECT b.*, f.flight_number, f.airline_name, f.source, f.destination, " +
                     "f.departure_time, f.arrival_time, u.email AS customer_email " +
                     "FROM bookings b " +
                     "JOIN flights f ON b.flight_id = f.flight_id " +
                     "JOIN users u ON b.user_id = u.user_id " +
                     "WHERE b.booking_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        }
        return null;
    }

    /**
     * Retrieves all bookings made by a specific customer, most recent first.
     */
    public List<Booking> findByUser(int userId) throws SQLException {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, f.flight_number, f.airline_name, f.source, f.destination, " +
                     "f.departure_time, f.arrival_time, u.email AS customer_email " +
                     "FROM bookings b " +
                     "JOIN flights f ON b.flight_id = f.flight_id " +
                     "JOIN users u ON b.user_id = u.user_id " +
                     "WHERE b.user_id = ? ORDER BY b.booking_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    bookings.add(mapRow(rs));
                }
            }
        }
        return bookings;
    }

    /**
     * Retrieves every booking in the system - used by the admin dashboard.
     */
    public List<Booking> findAll() throws SQLException {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, f.flight_number, f.airline_name, f.source, f.destination, " +
                     "f.departure_time, f.arrival_time, u.email AS customer_email " +
                     "FROM bookings b " +
                     "JOIN flights f ON b.flight_id = f.flight_id " +
                     "JOIN users u ON b.user_id = u.user_id " +
                     "ORDER BY b.booking_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                bookings.add(mapRow(rs));
            }
        }
        return bookings;
    }

    /**
     * Counts the total number of bookings - used for admin dashboard stats.
     */
    public int countAll() throws SQLException {
        String sql = "SELECT COUNT(*) FROM bookings";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    /**
     * Sums total revenue from confirmed bookings - used for admin dashboard stats.
     */
    public double sumRevenue() throws SQLException {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) FROM bookings WHERE booking_status = 'CONFIRMED'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getDouble(1);
            }
        }
        return 0.0;
    }

    /**
     * Maps the current row of a ResultSet (joined with flights and users) to a Booking object.
     */
    private Booking mapRow(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setBookingId(rs.getInt("booking_id"));
        booking.setPnr(rs.getString("pnr"));
        booking.setUserId(rs.getInt("user_id"));
        booking.setFlightId(rs.getInt("flight_id"));
        booking.setNumSeats(rs.getInt("num_seats"));
        booking.setPassengerName(rs.getString("passenger_name"));
        booking.setPassengerAge(rs.getInt("passenger_age"));
        booking.setPassengerGender(rs.getString("passenger_gender"));
        booking.setTotalAmount(rs.getDouble("total_amount"));
        booking.setBookingStatus(rs.getString("booking_status"));
        booking.setBookingDate(rs.getTimestamp("booking_date"));
        booking.setFlightNumber(rs.getString("flight_number"));
        booking.setAirlineName(rs.getString("airline_name"));
        booking.setSource(rs.getString("source"));
        booking.setDestination(rs.getString("destination"));
        booking.setDepartureTime(rs.getTimestamp("departure_time"));
        booking.setArrivalTime(rs.getTimestamp("arrival_time"));
        booking.setCustomerEmail(rs.getString("customer_email"));
        return booking;
    }
}
