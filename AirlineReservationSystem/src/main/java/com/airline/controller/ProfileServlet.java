package com.airline.controller;

import com.airline.model.User;
import com.airline.service.UserService;
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
 * Displays and updates the logged-in customer's profile information.
 */
@WebServlet(name = "ProfileServlet", urlPatterns = {"/customer/profile"})
public class ProfileServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (ValidationUtil.isNullOrEmpty(firstName) || ValidationUtil.isNullOrEmpty(lastName)) {
            request.setAttribute("errorMessage", "First name and last name are required.");
            request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
            return;
        }

        try {
            loggedInUser.setFirstName(firstName.trim());
            loggedInUser.setLastName(lastName.trim());
            loggedInUser.setPhone(phone);
            loggedInUser.setAddress(address);

            userService.updateProfile(loggedInUser);

            // Refresh session with updated details
            session.setAttribute("loggedInUser", loggedInUser);
            session.setAttribute("userName", loggedInUser.getFullName());

            request.setAttribute("successMessage", "Profile updated successfully.");

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "A database error occurred. Please try again later.");
        }

        request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
    }
}
