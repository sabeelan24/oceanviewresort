package com.oceanview.util;

/**
 * ValidationException
 * 
 * ACADEMIC PURPOSE: Custom Exception for Business Rule Violations
 * This exception is thrown when user input fails validation rules.
 * It extends RuntimeException for cleaner code flow.
 * 
 * @author OceanView Resort Development Team
 */
public class ValidationException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public ValidationException(String message) {
        super(message);
    }

    public ValidationException(String message, Throwable cause) {
        super(message, cause);
    }
}
