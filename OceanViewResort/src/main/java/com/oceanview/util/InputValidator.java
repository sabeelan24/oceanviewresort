package com.oceanview.util;

import java.util.regex.Pattern;

/**
 * InputValidator
 * 
 * ACADEMIC PURPOSE: Centralized Validation Logic
 * This class provides reusable validation methods for user input.
 * Following the DRY (Don't Repeat Yourself) principle.
 * 
 * @author OceanView Resort Development Team
 */
public class InputValidator {
    
    // Regular Expression for 10-digit phone number validation
    // ^[0-9]{10}$ means: start of string, exactly 10 digits, end of string
    private static final Pattern PHONE_PATTERN = Pattern.compile("^[0-9]{10}$");
    
    // Email validation pattern (basic)
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
        "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    );
    
    /**
     * Validates phone number format
     * 
     * BUSINESS RULE: Phone number must be exactly 10 numeric digits
     * 
     * @param phoneNumber The phone number to validate
     * @throws ValidationException if phone number is invalid
     */
    public static void validatePhoneNumber(String phoneNumber) {
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            throw new ValidationException("Phone number is required.");
        }
        
        String cleanedPhone = phoneNumber.trim();
        
        // Check if length is exactly 10
        if (cleanedPhone.length() != 10) {
            throw new ValidationException(
                "Phone number must be exactly 10 digits. Current length: " + cleanedPhone.length()
            );
        }
        
        // Check if it contains only numeric characters using regex
        if (!PHONE_PATTERN.matcher(cleanedPhone).matches()) {
            throw new ValidationException(
                "Phone number must contain only numeric digits (0-9). No spaces, dashes, or special characters allowed."
            );
        }
    }
    
    /**
     * Validates email format (optional field)
     * 
     * @param email The email to validate
     * @throws ValidationException if email format is invalid
     */
    public static void validateEmail(String email) {
        // Email is optional, so null or empty is allowed
        if (email == null || email.trim().isEmpty()) {
            return;
        }
        
        if (!EMAIL_PATTERN.matcher(email.trim()).matches()) {
            throw new ValidationException("Invalid email format.");
        }
    }
    
    /**
     * Validates that a required text field is not empty
     * 
     * @param fieldValue The field value to validate
     * @param fieldName The name of the field (for error messages)
     * @throws ValidationException if field is empty
     */
    public static void validateRequired(String fieldValue, String fieldName) {
        if (fieldValue == null || fieldValue.trim().isEmpty()) {
            throw new ValidationException(fieldName + " is required.");
        }
    }
    
    /**
     * Sanitizes phone number by removing common formatting characters
     * Use this before validation if you want to accept formatted input
     * 
     * @param phoneNumber The phone number to sanitize
     * @return Cleaned phone number with only digits
     */
    public static String sanitizePhoneNumber(String phoneNumber) {
        if (phoneNumber == null) {
            return "";
        }
        // Remove spaces, dashes, parentheses, and plus signs
        return phoneNumber.replaceAll("[\\s\\-()+ ]", "");
    }
}
