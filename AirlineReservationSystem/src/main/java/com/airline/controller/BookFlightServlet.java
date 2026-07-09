package com.airline.controller;

import com.airline.model.Booking;
import com.airline.model.Flight;
import com.airline.model.User;
import com.airline.service.BookingService;
import com.airline.service.FlightService;
import com.airline.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Handles the flight booking workflow:
 *  - GET  -> loads the selected flight and displays the booking form
 *  - POST -> validates passenger details, creates a PENDING booking
 *            (reserving seats) and forwards the user to the payment page
 */
@WebServlet(name = "BookFlightServlet", urlPatterns = {"/book-flight"})
public class BookFlightServlet extends HttpServlet {

    private final FlightService flightService = new FlightService();
    private final BookingService bookingService = new BookingService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String flightIdParam = request.getParameter("flightId");

        if (!ValidationUtil.isPositiveInteger(flightIdParam)) {
            response.sendRedirect(request.getContextPath() + "/search-flight.jsp");
            return;
        }

        try {
            Flight flight = flightService.getFlightById(Integer.parseInt(flightIdParam));
            if (flight == null) {
                request.setAttribute("errorMessage", "Selected flight could not be found.");
                request.getRequestDispatcher("/search-flight.jsp").forward(request, response);
                return;
            }
            request.setAttribute("flight", flight);
            request.getRequestDispatcher("/book-flight.jsp").forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "A database error occurred. Please try again later.");
            request.getRequestDispatcher("/search-flight.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        String flightIdParam = request.getParameter("flightId");
        String passengerName = request.getParameter("passengerName");
        String passengerAgeParam = request.getParameter("passengerAge");
        String passengerGender = request.getParameter("passengerGender");
        String numSeatsParam = request.getParameter("numSeats");

        if (!ValidationUtil.isPositiveInteger(flightIdParam) || ValidationUtil.isNullOrEmpty(passengerName)
                || !ValidationUtil.isPositiveInteger(passengerAgeParam)
                || !ValidationUtil.isPositiveInteger(numSeatsParam)) {
            request.setAttribute("errorMessage", "Please fill in all passenger details correctly.");
            doGet(request, response);
            return;
        }

        try {
            int flightId = Integer.parseInt(flightIdParam);
            int numSeats = Integer.parseInt(numSeatsParam);

            Booking booking = new Booking();
            booking.setUserId(loggedInUser.getUserId());
            booking.setFlightId(flightId);
            booking.setNumSeats(numSeats);
            booking.setPassengerName(passengerName.trim());
            booking.setPassengerAge(Integer.parseInt(passengerAgeParam));
            booking.setPassengerGender(passengerGender);

            int bookingId = bookingService.createBooking(booking);

            if (bookingId == -1) {
                request.setAttribute("errorMessage", "Sorry, not enough seats are available on this flight.");
                doGet(request, response);
                return;
            }

            response.sendRedirect(request.getContextPath() + "/payment.jsp?bookingId=" + bookingId);

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "A database error occurred while booking. Please try again later.");
            doGet(request, response);
        }
    }
}
