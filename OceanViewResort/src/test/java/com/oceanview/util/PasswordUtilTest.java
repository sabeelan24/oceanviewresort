package com.oceanview.util;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

/**
 * PasswordUtilTest
 * 
 * ACADEMIC PURPOSE: Unit Testing with JUnit 5
 * Tests the PasswordUtil class to verify:
 * - Consistent SHA-256 hash generation
 * - Different passwords produce different hashes
 * - Hash security properties
 * - Deterministic hashing for authentication
 * 
 * SECURITY CONTEXT:
 * Password hashing is critical for user authentication security.
 * These tests verify that:
 * 1. The hashing algorithm is deterministic (same input = same output)
 * 2. Different passwords produce different outputs (no collisions in practice)
 * 3. The algorithm is consistent across multiple invocations
 * 
 * @author OceanView Resort Testing Team
 */
public class PasswordUtilTest {

    /**
     * Test 1: SHA-256 Hash Consistency
     * 
     * Verifies that the password hashing function is deterministic.
     * 
     * IMPORTANCE:
     * For authentication to work correctly, when a user logs in with password "admin123",
     * the system must hash it and compare with the stored hash. If the hashing is not
     * consistent, the same password would produce different hashes and authentication would fail.
     * 
     * TEST DATA:
     * Password: "admin123"
     * Hash attempt 1: hash("admin123")
     * Hash attempt 2: hash("admin123")
     * 
     * EXPECTED:
     * hash1 == hash2 (both hashes are identical)
     * 
     * ALGORITHM:
     * SHA-256 is deterministic: f(x) always produces the same output for the same input.
     */
    @Test
    void shouldGenerateConsistentHash() {
        String password = "admin123";

        String hash1 = PasswordUtil.hashPassword(password);
        String hash2 = PasswordUtil.hashPassword(password);

        assertEquals(hash1, hash2, "Same password should produce identical hashes");
    }

    /**
     * Test 2: Different Passwords Produce Different Hashes
     * 
     * Verifies that different passwords do not produce the same hash
     * (cryptographic collision prevention).
     * 
     * SECURITY IMPLICATION:
     * If two different passwords hashed to the same value, an attacker could
     * potentially log in as admin123 when the actual password is admin124.
     * 
     * TEST DATA:
     * Password 1: "admin123"
     * Password 2: "admin124" (1 character difference)
     * 
     * EXPECTED:
     * hash("admin123") != hash("admin124")
     * 
     * CRYPTOGRAPHIC PROPERTY:
     * SHA-256 has strong avalanche effect: a 1-bit change in input produces
     * a completely different hash output.
     */
    @Test
    void differentPasswordsShouldProduceDifferentHashes() {
        String hash1 = PasswordUtil.hashPassword("admin123");
        String hash2 = PasswordUtil.hashPassword("admin124");

        assertNotEquals(hash1, hash2, "Different passwords must produce different hashes");
    }

    /**
     * Test 3: Hash Output Format Validation
     * 
     * Verifies that the hash output is in the correct hexadecimal format.
     * 
     * EXPECTED FORMAT:
     * - SHA-256 produces 256 bits = 32 bytes = 64 hexadecimal characters
     * - Only characters 0-9 and a-f (lowercase hex)
     * 
     * TEST DATA:
     * Password: "test"
     * Expected hash length: 64 characters
     * Expected characters: [0-9, a-f]
     */
    @Test
    void shouldProduceValidHexFormat() {
        String hash = PasswordUtil.hashPassword("test");

        // SHA-256 produces 64 hex characters (32 bytes)
        assertEquals(64, hash.length(), "SHA-256 hash should be 64 characters");

        // Verify it only contains hexadecimal characters
        assertTrue(hash.matches("[0-9a-f]{64}"), 
                   "Hash should only contain lowercase hexadecimal characters");
    }

    /**
     * Test 4: Case Sensitivity
     * 
     * Verifies that password hashing is case-sensitive.
     * 
     * TEST DATA:
     * Password 1: "Admin123" (uppercase A)
     * Password 2: "admin123" (lowercase a)
     * 
     * EXPECTED:
     * Different hashes (case matters)
     * 
     * BUSINESS LOGIC:
     * This is important for user security - passwords are case-sensitive.
     */
    @Test
    void shouldBeCaseSensitive() {
        String hash1 = PasswordUtil.hashPassword("Admin123");
        String hash2 = PasswordUtil.hashPassword("admin123");

        assertNotEquals(hash1, hash2, "Password hashing should be case-sensitive");
    }

    /**
     * Test 5: Space Sensitivity
     * 
     * Verifies that spaces in passwords are treated as characters.
     * 
     * TEST DATA:
     * Password 1: "admin 123" (with space)
     * Password 2: "admin123" (without space)
     * 
     * EXPECTED:
     * Different hashes
     * 
     * BUSINESS LOGIC:
     * Users might intentionally include spaces in their password.
     * These must be preserved and not ignored during hashing.
     */
    @Test
    void shouldTreatSpacesAsPartOfPassword() {
        String hash1 = PasswordUtil.hashPassword("admin 123");
        String hash2 = PasswordUtil.hashPassword("admin123");

        assertNotEquals(hash1, hash2, "Spaces should be treated as part of password");
    }

    /**
     * Test 6: Special Character Handling
     * 
     * Verifies that special characters are properly hashed.
     * 
     * TEST DATA:
     * Password: "admin@123!#"
     * 
     * EXPECTED:
     * Valid 64-character hexadecimal hash
     * 
     * SECURITY VALIDATION:
     * Special characters increase password entropy and should be supported.
     */
    @Test
    void shouldHandleSpecialCharacters() {
        String hash = PasswordUtil.hashPassword("admin@123!#");

        assertEquals(64, hash.length(), "Special characters should hash correctly");
        assertTrue(hash.matches("[0-9a-f]{64}"), "Result should be valid hex");
    }

    /**
     * Test 7: Empty Password Hashing
     * 
     * Verifies that even an empty string produces a valid hash.
     * 
     * EXPECTED:
     * - Valid 64-character hexadecimal output
     * - Consistent output across multiple calls
     * 
     * NOTE:
     * While empty passwords should be rejected by validation logic,
     * the hash function itself should still work.
     */
    @Test
    void shouldHashEmptyString() {
        String hash1 = PasswordUtil.hashPassword("");
        String hash2 = PasswordUtil.hashPassword("");

        assertEquals(64, hash1.length(), "Empty string should produce valid hash");
        assertEquals(hash1, hash2, "Empty string should hash consistently");
    }

    /**
     * Test 8: Long Password Hashing
     * 
     * Verifies that long passwords are handled correctly.
     * 
     * TEST DATA:
     * Password: Very long string (256+ characters)
     * 
     * EXPECTED:
     * - Valid 64-character hash (SHA-256 always produces same length)
     * - Different from shorter passwords
     * 
     * CRYPTOGRAPHIC PROPERTY:
     * SHA-256 is designed to handle input of any length and always produce
     * a 256-bit output. This is a key advantage over length-sensitive hashing.
     */
    @Test
    void shouldHandleLongPasswords() {
        String longPassword = "a".repeat(1000); // 1000 characters
        String hash = PasswordUtil.hashPassword(longPassword);

        assertEquals(64, hash.length(), "Long password should produce standard-length hash");
        assertTrue(hash.matches("[0-9a-f]{64}"), "Result should be valid hex");
    }

    /**
     * Test 9: Unicode Character Support
     * 
     * Verifies that unicode characters are handled correctly.
     * 
     * TEST DATA:
     * Password: "admin🔒secure" (includes emoji)
     * 
     * EXPECTED:
     * Valid hash output (UTF-8 encoding)
     * 
     * NOTE:
     * Java's String.getBytes() uses UTF-8 by default, so unicode characters
     * should be properly encoded before hashing.
     */
    @Test
    void shouldSupportUnicodeCharacters() {
        String unicodePassword = "admin🔒secure";
        String hash = PasswordUtil.hashPassword(unicodePassword);

        assertEquals(64, hash.length(), "Unicode password should hash correctly");
        assertTrue(hash.matches("[0-9a-f]{64}"), "Result should be valid hex");
    }

    /**
     * Test 10: Authentication Flow Simulation
     * 
     * Simulates the actual authentication process:
     * 1. User submits password during login
     * 2. System hashes the submitted password
     * 3. System compares with stored hash
     * 4. Authentication succeeds if hashes match
     * 
     * EXPECTED:
     * Correct password matches stored hash
     * Wrong password produces different hash
     */
    @Test
    void shouldSupportAuthenticationFlow() {
        // Simulate database storing a password hash
        String storedPasswordHash = PasswordUtil.hashPassword("correctPassword123");

        // User attempts to login with correct password
        String submittedPasswordHash = PasswordUtil.hashPassword("correctPassword123");
        assertTrue(storedPasswordHash.equals(submittedPasswordHash),
                   "Correct password should authenticate successfully");

        // User attempts to login with wrong password
        String wrongPasswordHash = PasswordUtil.hashPassword("wrongPassword123");
        assertFalse(storedPasswordHash.equals(wrongPasswordHash),
                    "Wrong password should fail authentication");
    }
}
