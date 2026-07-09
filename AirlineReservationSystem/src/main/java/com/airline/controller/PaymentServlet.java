package com.airline.controller;

import com.airline.model.Booking;
import com.airline.service.BookingService;
import com.airline.service.PaymentService;
import com.airline.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Handles payment submission for a booking. On success, confirms the
 * booking and forwards the user to the booking confirmation page.
 * Note: this is a simulated payment gateway suitable for a demo/training
 * project - no real card processing occurs.
 */
@WebServlet(name = "PaymentServlet", urlPatterns = {"/process-payment"})
public class PaymentServlet extends HttpServlet {

    private final BookingService bookingService = new BookingService();
    private final PaymentService paymentService = new PaymentService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingIdParam = request.getParameter("bookingId");
        String paymentMethod = request.getParameter("paymentMethod");
        String cardNumber = request.getParameter("cardNumber");
        String cardName = request.getParameter("cardName");
        String expiry = request.getParameter("expiry");
        String cvv = request.getParameter("cvv");

        if (!ValidationUtil.isPositiveInteger(bookingIdParam) || ValidationUtil.isNullOrEmpty(paymentMethod)
                || ValidationUtil.isNullOrEmpty(cardNumber) || ValidationUtil.isNullOrEmpty(cardName)
                || ValidationUtil.isNullOrEmpty(expiry) || ValidationUtil.isNullOrEmpty(cvv)) {
            request.setAttribute("errorMessage", "Please fill in all payment details.");
            response.sendRedirect(request.getContextPath() + "/payment.jsp?bookingId=" + bookingIdParam);
            return;
        }

        try {
            int bookingId = Integer.parseInt(bookingIdParam);
            Booking booking = bookingService.getBookingById(bookingId);

            if (booking == null) {
                request.setAttribute("errorMessage", "Booking not found.");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }

            String transactionId = paymentService.processPayment(
                    bookingId, booking.getTotalAmount(), paymentMethod, cardNumber);

            if (transactionId != null) {
                bookingService.confirmBooking(bookingId);
                response.sendRedirect(request.getContextPath()
                        + "/booking/booking-confirmation.jsp?bookingId=" + bookingId);
            } else {
                request.setAttribute("errorMessage", "Payment failed. Please try again.");
                response.sendRedirect(request.getContextPath() + "/payment.jsp?bookingId=" + bookingId);
            }

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "A database error occurred during payment. Please try again later.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}
