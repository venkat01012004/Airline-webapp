package com.airline.service;

import com.airline.dao.PaymentDAO;
import com.airline.model.Payment;
import com.airline.util.PNRGenerator;

import java.sql.SQLException;

/**
 * Service layer for payment-related business logic.
 * Since this is a demonstration project, real payment gateway integration
 * is simulated: any well-formed card submission is treated as successful.
 */
public class PaymentService {

    private final PaymentDAO paymentDAO = new PaymentDAO();

    /**
     * Processes a (simulated) payment for a booking and records the result.
     *
     * @return the generated transaction ID if payment succeeded, otherwise null
     */
    public String processPayment(int bookingId, double amount, String method, String cardNumber) throws SQLException {
        String transactionId = PNRGenerator.generateTransactionId();

        Payment payment = new Payment();
        payment.setBookingId(bookingId);
        payment.setAmount(amount);
        payment.setPaymentMethod(method);
        payment.setCardNumber(maskCardNumber(cardNumber));
        payment.setTransactionId(transactionId);
        payment.setPaymentStatus("SUCCESS");

        boolean saved = paymentDAO.createPayment(payment);
        return saved ? transactionId : null;
    }

    public Payment getPaymentForBooking(int bookingId) throws SQLException {
        return paymentDAO.findByBookingId(bookingId);
    }

    /**
     * Masks all but the last 4 digits of a card number before storing it.
     */
    private String maskCardNumber(String cardNumber) {
        if (cardNumber == null || cardNumber.length() < 4) {
            return "XXXX";
        }
        String last4 = cardNumber.substring(cardNumber.length() - 4);
        return "**** **** **** " + last4;
    }
}
