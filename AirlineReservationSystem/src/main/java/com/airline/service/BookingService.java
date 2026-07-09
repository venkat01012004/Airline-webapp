package com.airline.service;

import com.airline.dao.BookingDAO;
import com.airline.dao.FlightDAO;
import com.airline.model.Booking;
import com.airline.model.Flight;
import com.airline.util.PNRGenerator;

import java.sql.SQLException;
import java.util.List;

/**
 * Service layer for booking-related business logic: creating bookings
 * (with seat availability checks), cancellations, and lookups.
 */
public class BookingService {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final FlightDAO flightDAO = new FlightDAO();

    /**
     * Creates a new booking for a customer after verifying seat availability
     * and atomically decrementing the flight's available seat count.
     *
     * @return the generated booking_id, or -1 if seats were not available
     */
    public int createBooking(Booking booking) throws SQLException {
        Flight flight = flightDAO.findById(booking.getFlightId());
        if (flight == null || flight.getAvailableSeats() < booking.getNumSeats()) {
            return -1;
        }

        boolean seatsReserved = flightDAO.decreaseAvailableSeats(booking.getFlightId(), booking.getNumSeats());
        if (!seatsReserved) {
            return -1;
        }

        booking.setPnr(PNRGenerator.generatePNR());
        booking.setBookingStatus("PENDING");
        booking.setTotalAmount(flight.getPrice() * booking.getNumSeats());

        int bookingId = bookingDAO.createBooking(booking);
        if (bookingId == -1) {
            // Roll back the seat reservation if the booking insert failed
            flightDAO.increaseAvailableSeats(booking.getFlightId(), booking.getNumSeats());
        }
        return bookingId;
    }

    /**
     * Confirms a booking after successful payment.
     */
    public boolean confirmBooking(int bookingId) throws SQLException {
        return bookingDAO.updateStatus(bookingId, "CONFIRMED");
    }

    /**
     * Cancels a booking and releases the reserved seats back to the flight.
     */
    public boolean cancelBooking(int bookingId) throws SQLException {
        Booking booking = bookingDAO.findById(bookingId);
        if (booking == null) {
            return false;
        }
        boolean updated = bookingDAO.updateStatus(bookingId, "CANCELLED");
        if (updated) {
            flightDAO.increaseAvailableSeats(booking.getFlightId(), booking.getNumSeats());
        }
        return updated;
    }

    public Booking getBookingById(int bookingId) throws SQLException {
        return bookingDAO.findById(bookingId);
    }

    public List<Booking> getBookingsForUser(int userId) throws SQLException {
        return bookingDAO.findByUser(userId);
    }

    public List<Booking> getAllBookings() throws SQLException {
        return bookingDAO.findAll();
    }

    public int countAllBookings() throws SQLException {
        return bookingDAO.countAll();
    }

    public double totalRevenue() throws SQLException {
        return bookingDAO.sumRevenue();
    }
}
