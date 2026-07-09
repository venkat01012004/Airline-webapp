package com.airline.dao;

import com.airline.model.ContactMessage;
import com.airline.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for the "contact_messages" table.
 */
public class ContactMessageDAO {

    /**
     * Saves a new message submitted from the Contact Us page.
     */
    public boolean saveMessage(ContactMessage message) throws SQLException {
        String sql = "INSERT INTO contact_messages (name, email, subject, message) VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, message.getName());
            ps.setString(2, message.getEmail());
            ps.setString(3, message.getSubject());
            ps.setString(4, message.getMessage());

            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Retrieves all contact messages - used by the admin dashboard.
     */
    public List<ContactMessage> findAll() throws SQLException {
        List<ContactMessage> messages = new ArrayList<>();
        String sql = "SELECT * FROM contact_messages ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ContactMessage message = new ContactMessage();
                message.setMessageId(rs.getInt("message_id"));
                message.setName(rs.getString("name"));
                message.setEmail(rs.getString("email"));
                message.setSubject(rs.getString("subject"));
                message.setMessage(rs.getString("message"));
                message.setCreatedAt(rs.getTimestamp("created_at"));
                messages.add(message);
            }
        }
        return messages;
    }
}
