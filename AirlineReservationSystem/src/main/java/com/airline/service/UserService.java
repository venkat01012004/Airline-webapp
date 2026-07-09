package com.airline.service;

import com.airline.dao.UserDAO;
import com.airline.model.User;
import com.airline.util.PasswordUtil;

import java.sql.SQLException;
import java.util.List;

/**
 * Service layer for user-related business logic such as registration
 * and login authentication. Sits between the controllers (servlets) and
 * the DAO layer.
 */
public class UserService {

    private final UserDAO userDAO = new UserDAO();

    /**
     * Registers a new customer account. Hashes the password before
     * persisting it and rejects duplicate email addresses.
     *
     * @return true if registration succeeded, false if the email is already in use
     */
    public boolean registerCustomer(User user) throws SQLException {
        User existing = userDAO.findByEmail(user.getEmail());
        if (existing != null) {
            return false;
        }
        user.setPassword(PasswordUtil.hashPassword(user.getPassword()));
        user.setRole("CUSTOMER");
        return userDAO.registerUser(user);
    }

    /**
     * Authenticates a user login attempt.
     *
     * @return the matching User if credentials are valid, otherwise null
     */
    public User login(String email, String plainPassword) throws SQLException {
        User user = userDAO.findByEmail(email);
        if (user == null) {
            return null;
        }
        if (!PasswordUtil.verifyPassword(plainPassword, user.getPassword())) {
            return null;
        }
        if ("INACTIVE".equalsIgnoreCase(user.getStatus())) {
            return null;
        }
        return user;
    }

    public User getUserById(int userId) throws SQLException {
        return userDAO.findById(userId);
    }

    public List<User> getAllUsers() throws SQLException {
        return userDAO.findAll();
    }

    public boolean updateProfile(User user) throws SQLException {
        return userDAO.updateProfile(user);
    }
}
