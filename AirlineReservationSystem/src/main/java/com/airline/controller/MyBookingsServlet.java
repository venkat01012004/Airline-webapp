package com.airline.controller;

import com.airline.model.Booking;
import com.airline.model.User;
import com.airline.service.BookingService;
import com.airline.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Displays the logged-in customer's booking history and handles
 * booking cancellation requests.
 */
@WebServlet(name = "MyBookingsServlet", urlPatterns = {"/my-bookings"})
public class MyBookingsServlet extends HttpServlet {

    private final BookingService bookingService = new BookingService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        String action = request.getParameter("action");
        String bookingIdParam = request.getParameter("bookingId");

        try {
            if ("cancel".equals(action) && ValidationUtil.isPositiveInteger(bookingIdParam)) {
                Booking booking = bookingService.getBookingById(Integer.parseInt(bookingIdParam));
                // Ensure customers can only cancel their own bookings
                if (booking != null && booking.getUserId() == loggedInUser.getUserId()) {
                    bookingService.cancelBooking(booking.getBookingId());
                    session.setAttribute("successMessage", "Booking " + booking.getPnr() + " has been cancelled.");
                }
            }

            List<Booking> bookings = bookingService.getBookingsForUser(loggedInUser.getUserId());
            request.setAttribute("bookings", bookings);

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Unable to load your bookings right now. Please try again later.");
        }

        request.getRequestDispatcher("/my-bookings.jsp").forward(request, response);
    }
}
