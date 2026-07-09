package com.airline.controller;

import com.airline.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Displays every registered user - used by the admin "Manage Users" screen.
 */
@WebServlet(name = "AdminUserServlet", urlPatterns = {"/admin/users"})
public class AdminUserServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            request.setAttribute("users", userService.getAllUsers());
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Unable to load users right now. Please try again later.");
        }

        request.getRequestDispatcher("/admin/manage-users.jsp").forward(request, response);
    }
}
