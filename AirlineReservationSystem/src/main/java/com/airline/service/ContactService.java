package com.airline.service;

import com.airline.dao.ContactMessageDAO;
import com.airline.model.ContactMessage;

import java.sql.SQLException;
import java.util.List;

/**
 * Service layer for handling messages submitted via the Contact Us page.
 */
public class ContactService {

    private final ContactMessageDAO contactMessageDAO = new ContactMessageDAO();

    public boolean submitMessage(ContactMessage message) throws SQLException {
        return contactMessageDAO.saveMessage(message);
    }

    public List<ContactMessage> getAllMessages() throws SQLException {
        return contactMessageDAO.findAll();
    }
}
