package com.airline.dao;

import com.airline.model.Payment;
import com.airline.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Data Access Object for the "payments" table.
 */
public class PaymentDAO {

    /**
     * Records a payment attempt for a booking.
     *
     * @return true if the insert succeeded
     */
    public boolean createPayment(Payment payment) throws SQLException {
        String sql = "INSERT INTO payments (booking_id, amount, payment_method, card_number, " +
                     "transaction_id, payment_status) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, payment.getBookingId());
            ps.setDouble(2, payment.getAmount());
            ps.setString(3, payment.getPaymentMethod());
            ps.setString(4, payment.getCardNumber());
            ps.setString(5, payment.getTransactionId());
            ps.setString(6, payment.getPaymentStatus());

            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Retrieves the payment record associated with a given booking.
     */
    public Payment findByBookingId(int bookingId) throws SQLException {
        String sql = "SELECT * FROM payments WHERE booking_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Payment payment = new Payment();
                    payment.setPaymentId(rs.getInt("payment_id"));
                    payment.setBookingId(rs.getInt("booking_id"));
                    payment.setAmount(rs.getDouble("amount"));
                    payment.setPaymentMethod(rs.getString("payment_method"));
                    payment.setCardNumber(rs.getString("card_number"));
                    payment.setTransactionId(rs.getString("transaction_id"));
                    payment.setPaymentStatus(rs.getString("payment_status"));
                    payment.setPaymentDate(rs.getTimestamp("payment_date"));
                    return payment;
                }
            }
        }
        return null;
    }
}
