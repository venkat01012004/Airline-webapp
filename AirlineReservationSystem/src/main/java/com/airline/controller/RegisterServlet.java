package com.airline.controller;

import com.airline.model.User;
import com.airline.service.UserService;
import com.airline.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Handles new customer account registration submitted from register.jsp.
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // ---- Server-side validation ----
        if (ValidationUtil.isNullOrEmpty(firstName) || ValidationUtil.isNullOrEmpty(lastName)
                || ValidationUtil.isNullOrEmpty(email) || ValidationUtil.isNullOrEmpty(password)) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("errorMessage", "Please enter a valid email address.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        if (!ValidationUtil.isValidPassword(password)) {
            request.setAttribute("errorMessage", "Password must be at least 6 characters long.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        try {
            User user = new User();
            user.setFirstName(firstName.trim());
            user.setLastName(lastName.trim());
            user.setEmail(email.trim().toLowerCase());
            user.setPassword(password);
            user.setPhone(phone);
            user.setAddress(address);

            boolean registered = userService.registerCustomer(user);

            if (registered) {
                request.getSession().setAttribute("successMessage", "Registration successful! Please login to continue.");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            } else {
                request.setAttribute("errorMessage", "An account with this email already exists.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "A database error occurred. Please try again later.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
