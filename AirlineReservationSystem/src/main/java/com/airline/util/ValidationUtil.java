package com.airline.util;

import java.util.regex.Pattern;

/**
 * Utility class providing simple, reusable validation helpers used by
 * servlets when processing form submissions (registration, contact form,
 * booking form etc.).
 */
public class ValidationUtil {

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^[0-9]{10}$");

    private ValidationUtil() {
        // Prevent instantiation
    }

    public static boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    public static boolean isValidEmail(String email) {
        return !isNullOrEmpty(email) && EMAIL_PATTERN.matcher(email).matches();
    }

    public static boolean isValidPhone(String phone) {
        return !isNullOrEmpty(phone) && PHONE_PATTERN.matcher(phone).matches();
    }

    public static boolean isValidPassword(String password) {
        // Minimum 6 characters
        return !isNullOrEmpty(password) && password.length() >= 6;
    }

    public static boolean isPositiveInteger(String value) {
        try {
            return Integer.parseInt(value) > 0;
        } catch (NumberFormatException | NullPointerException e) {
            return false;
        }
    }
}
