package com.airline.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Utility class for hashing and verifying user passwords using SHA-256.
 * Only JDK-standard classes are used - no external hashing libraries.
 */
public class PasswordUtil {

    private PasswordUtil() {
        // Prevent instantiation
    }

    /**
     * Hashes a plain text password using SHA-256 and returns it as a
     * lowercase hexadecimal string.
     *
     * @param plainPassword the raw password entered by the user
     * @return the SHA-256 hash of the password
     */
    public static String hashPassword(String plainPassword) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = digest.digest(plainPassword.getBytes("UTF-8"));

            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    sb.append('0');
                }
                sb.append(hex);
            }
            return sb.toString();

        } catch (NoSuchAlgorithmException | java.io.UnsupportedEncodingException e) {
            throw new RuntimeException("Error while hashing password", e);
        }
    }

    /**
     * Verifies that a plain text password matches a previously hashed value.
     *
     * @param plainPassword  the raw password entered by the user during login
     * @param hashedPassword the hash stored in the database
     * @return true if the password matches, false otherwise
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        String computedHash = hashPassword(plainPassword);
        return computedHash.equals(hashedPassword);
    }
}
