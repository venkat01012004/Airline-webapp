package com.airline;

import com.airline.util.PasswordUtil;
import com.airline.util.ValidationUtil;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

/**
 * Unit tests for the utility classes used across the Airline Reservation
 * System. These tests do not require a database connection and can run
 * as part of the Maven build / Jenkins pipeline.
 */
public class UtilTest {

    @Test
    public void testPasswordHashingIsConsistent() {
        String hash1 = PasswordUtil.hashPassword("MySecret123");
        String hash2 = PasswordUtil.hashPassword("MySecret123");
        assertEquals("Hashing the same password twice should produce the same hash", hash1, hash2);
    }

    @Test
    public void testPasswordVerificationSucceedsForCorrectPassword() {
        String hash = PasswordUtil.hashPassword("MySecret123");
        assertTrue(PasswordUtil.verifyPassword("MySecret123", hash));
    }

    @Test
    public void testPasswordVerificationFailsForWrongPassword() {
        String hash = PasswordUtil.hashPassword("MySecret123");
        assertFalse(PasswordUtil.verifyPassword("WrongPassword", hash));
    }

    @Test
    public void testValidEmailAddresses() {
        assertTrue(ValidationUtil.isValidEmail("john@example.com"));
        assertTrue(ValidationUtil.isValidEmail("admin@airline.co.in"));
    }

    @Test
    public void testInvalidEmailAddresses() {
        assertFalse(ValidationUtil.isValidEmail("not-an-email"));
        assertFalse(ValidationUtil.isValidEmail(""));
        assertFalse(ValidationUtil.isValidEmail(null));
    }

    @Test
    public void testValidPhoneNumbers() {
        assertTrue(ValidationUtil.isValidPhone("9876543210"));
        assertFalse(ValidationUtil.isValidPhone("12345"));
    }

    @Test
    public void testPositiveIntegerCheck() {
        assertTrue(ValidationUtil.isPositiveInteger("5"));
        assertFalse(ValidationUtil.isPositiveInteger("-5"));
        assertFalse(ValidationUtil.isPositiveInteger("abc"));
        assertFalse(ValidationUtil.isPositiveInteger(null));
    }
}
