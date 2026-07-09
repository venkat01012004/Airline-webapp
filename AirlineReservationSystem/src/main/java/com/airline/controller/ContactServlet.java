package com.airline.controller;

import com.airline.model.ContactMessage;
import com.airline.service.ContactService;
import com.airline.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Handles submissions from the Contact Us page (contact.jsp).
 */
@WebServlet(name = "ContactServlet", urlPatterns = {"/contact"})
public class ContactServlet extends HttpServlet {

    private final ContactService contactService = new ContactService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        if (ValidationUtil.isNullOrEmpty(name) || !ValidationUtil.isValidEmail(email)
                || ValidationUtil.isNullOrEmpty(message)) {
            request.setAttribute("errorMessage", "Please fill in all required fields with a valid email.");
            request.getRequestDispatcher("/contact.jsp").forward(request, response);
            return;
        }

        try {
            ContactMessage contactMessage = new ContactMessage();
            contactMessage.setName(name.trim());
            contactMessage.setEmail(email.trim());
            contactMessage.setSubject(subject);
            contactMessage.setMessage(message.trim());

            contactService.submitMessage(contactMessage);

            request.setAttribute("successMessage", "Thank you for reaching out! We'll get back to you soon.");

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "A database error occurred. Please try again later.");
        }

        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }
}
