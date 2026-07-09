package com.airline.controller;

import com.airline.service.BookingService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Displays every booking made in the system - used by the admin
 * "View Bookings" screen.
 */
@WebServlet(name = "AdminBookingServlet", urlPatterns = {"/admin/bookings"})
public class AdminBookingServlet extends HttpServlet {

    private final BookingService bookingService = new BookingService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            request.setAttribute("bookings", bookingService.getAllBookings());
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Unable to load bookings right now. Please try again later.");
        }

        request.getRequestDispatcher("/admin/view-bookings.jsp").forward(request, response);
    }
}
