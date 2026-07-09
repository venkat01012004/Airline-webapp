package com.airline.controller;

import com.airline.service.BookingService;
import com.airline.service.FlightService;
import com.airline.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Gathers summary statistics (total flights, bookings, users, revenue)
 * for display on the admin dashboard (admin/dashboard.jsp).
 */
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

    private final FlightService flightService = new FlightService();
    private final BookingService bookingService = new BookingService();
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            request.setAttribute("totalFlights", flightService.getAllFlights().size());
            request.setAttribute("totalBookings", bookingService.countAllBookings());
            request.setAttribute("totalUsers", userService.getAllUsers().size());
            request.setAttribute("totalRevenue", bookingService.totalRevenue());

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Unable to load dashboard statistics.");
        }

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
