package com.airline.util;

import java.util.Random;

/**
 * Utility class for generating unique, human-readable reference codes
 * such as booking PNR numbers and payment transaction IDs.
 */
public class PNRGenerator {

    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    private static final Random RANDOM = new Random();

    private PNRGenerator() {
        // Prevent instantiation
    }

    /**
     * Generates a random 6-character alphanumeric PNR code, e.g. "A1B2C3".
     */
    public static String generatePNR() {
        StringBuilder sb = new StringBuilder("PNR");
        for (int i = 0; i < 6; i++) {
            sb.append(CHARACTERS.charAt(RANDOM.nextInt(CHARACTERS.length())));
        }
        return sb.toString();
    }

    /**
     * Generates a random transaction ID prefixed with "TXN" for payments.
     */
    public static String generateTransactionId() {
        StringBuilder sb = new StringBuilder("TXN");
        sb.append(System.currentTimeMillis());
        for (int i = 0; i < 4; i++) {
            sb.append(CHARACTERS.charAt(RANDOM.nextInt(CHARACTERS.length())));
        }
        return sb.toString();
    }
}
