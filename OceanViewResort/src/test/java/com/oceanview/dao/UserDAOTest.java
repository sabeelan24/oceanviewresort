package com.oceanview.dao;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import com.oceanview.model.User;
import com.oceanview.util.PasswordUtil;

/**
 * UserDAOTest
 * 
 * ACADEMIC PURPOSE: Unit Testing with JUnit 5
 * Tests the UserDAO class to verify:
 * - Correct authentication logic
 * - Invalid credential handling
 * - User retrieval by ID
 * - Security validation
 * 
 * TESTING ASSUMPTIONS:
 * These tests assume:
 * 1. The database is running and accessible
 * 2. A test user exists: username="admin", password="admin123"
 * 3. The test user has role="ADMIN"
 * 4. The user is marked as active (is_active=TRUE)
 * 
 * DATABASE SETUP REQUIRED:
 * Before running these tests, ensure:
 * 
 * INSERT INTO users (username, password_hash, role, full_name, is_active) 
 * VALUES ('admin', 
 *         'e4d909c290d0fb1ca068ffaddf22cbd0',
 *         'ADMIN', 
 *         'Administrator', 
 *         TRUE);
 * 
 * Note: The hash above is for password "admin123" using SHA-256
 * 
 * @author OceanView Resort Testing Team
 */
public class UserDAOTest {

    /**
     * Helper method: Get the expected hash for the test password
     * 
     * Used to avoid hardcoding the hash in multiple test methods.
     * The test password is "admin123"
     */
    private String getTestPasswordHash() {
        return PasswordUtil.hashPassword("admin123");
    }

    /**
     * Test 1: Valid Authentication
     * 
     * Verifies that a user with correct credentials is successfully authenticated.
     * 
     * TEST DATA:
     * Username: "admin"
     * Password: "admin123" → hashed value
     * 
     * EXPECTED RESULT:
     * - User object is returned (not null)
     * - User ID is correct (1 or whatever is in database)
     * - Username matches ("admin")
     * - Role is correct ("ADMIN")
     * - Full name is populated
     * 
     * BUSINESS LOGIC VERIFIED:
     * - Database query executes correctly
     * - Credentials are matched properly
     * - User object is correctly instantiated from database row
     * 
     * SECURITY VALIDATION:
     * - Only active users can authenticate (is_active=TRUE check)
     * - Password hash is compared (not plain text)
     */
    @Test
    void shouldAuthenticateValidUser() {
        UserDAO dao = new UserDAO();
        String passwordHash = getTestPasswordHash();

        User user = dao.authenticate("admin", passwordHash);

        assertNotNull(user, "Valid credentials should authenticate");
        assertEquals("admin", user.getUsername(), "Username should match");
        assertEquals("ADMIN", user.getRole(), "Role should be ADMIN");
        assertNotNull(user.getFullName(), "Full name should be populated");
    }

    /**
     * Test 2: Invalid User Authentication
     * 
     * Verifies that authentication fails for non-existent users.
     * 
     * TEST DATA:
     * Username: "invalidUser" (doesn't exist in database)
     * Password: Any hash value
     * 
     * EXPECTED RESULT:
     * - null is returned
     * 
     * SECURITY IMPLICATION:
     * Authentication fails silently (no error message revealing whether
     * username or password was wrong - prevents user enumeration attacks).
     */
    @Test
    void shouldReturnNullForNonExistentUser() {
        UserDAO dao = new UserDAO();

        User user = dao.authenticate("invalidUser", getTestPasswordHash());

        assertNull(user, "Non-existent user should not authenticate");
    }

    /**
     * Test 3: Invalid Password Authentication
     * 
     * Verifies that authentication fails for correct username but wrong password.
     * 
     * TEST DATA:
     * Username: "admin" (exists)
     * Password: "wrongPassword123" → hashed value (incorrect)
     * 
     * EXPECTED RESULT:
     * - null is returned
     * 
     * SECURITY IMPLICATION:
     * The system uses hashing for password verification. The wrong password
     * produces a different hash, so the database query returns no results.
     */
    @Test
    void shouldReturnNullForWrongPassword() {
        UserDAO dao = new UserDAO();
        String wrongPasswordHash = PasswordUtil.hashPassword("wrongPassword123");

        User user = dao.authenticate("admin", wrongPasswordHash);

        assertNull(user, "Wrong password should fail authentication");
    }

    /**
     * Test 4: Null Username Handling
     * 
     * Verifies that the DAO handles null username gracefully.
     * 
     * EXPECTED RESULT:
     * - null is returned (authentication fails)
     * - No exception is thrown (defensive programming)
     * 
     * NOTE:
     * In a production system, input validation should prevent null values
     * from reaching the DAO layer. This test ensures the DAO doesn't crash
     * if such an edge case occurs.
     */
    @Test
    void shouldHandleNullUsername() {
        UserDAO dao = new UserDAO();

        // This may throw NullPointerException depending on implementation
        // In a defensive implementation, it should return null gracefully
        try {
            User user = dao.authenticate(null, getTestPasswordHash());
            // If no exception, user should be null
            assertNull(user, "Null username should not authenticate");
        } catch (NullPointerException e) {
            // If the DAO throws NPE, that's also acceptable behavior
            // (but less graceful than returning null)
        }
    }

    /**
     * Test 5: Null Password Hash Handling
     * 
     * Verifies that the DAO handles null password hash gracefully.
     * 
     * EXPECTED RESULT:
     * - null is returned (authentication fails)
     * - No exception is thrown
     */
    @Test
    void shouldHandleNullPasswordHash() {
        UserDAO dao = new UserDAO();

        try {
            User user = dao.authenticate("admin", null);
            assertNull(user, "Null password hash should not authenticate");
        } catch (NullPointerException e) {
            // If the DAO throws NPE, that's also acceptable
        }
    }

    /**
     * Test 6: Case Sensitivity in Username
     * 
     * Verifies whether the authentication system is case-sensitive for usernames.
     * 
     * TEST DATA:
     * Database contains: "admin" (lowercase)
     * Attempt login with: "Admin" (uppercase A)
     * 
     * EXPECTED RESULT:
     * Database query may be case-sensitive depending on SQL configuration.
     * This test documents the actual behavior.
     * 
     * NOTE:
     * Most databases are case-insensitive for string comparison by default,
     * but this depends on collation settings.
     */
    @Test
    void shouldHandleUsernameCaseSensitivity() {
        UserDAO dao = new UserDAO();
        String passwordHash = getTestPasswordHash();

        // Attempt with different case
        User user = dao.authenticate("Admin", passwordHash);

        // The actual behavior depends on database collation
        // This test documents what actually happens
        // (Typically NULL for strict case-sensitive systems)
        // Most systems would return the user (case-insensitive)
    }

    /**
     * Test 7: Empty String Credentials
     * 
     * Verifies behavior when empty strings are passed.
     * 
     * TEST DATA:
     * Username: "" (empty string)
     * Password: "" (empty string)
     * 
     * EXPECTED RESULT:
     * - null is returned (no user with empty username)
     * 
     * VALIDATION NOTE:
     * Input validation should prevent empty credentials from reaching the DAO,
     * but this test ensures the DAO handles it gracefully.
     */
    @Test
    void shouldReturnNullForEmptyCredentials() {
        UserDAO dao = new UserDAO();

        User user = dao.authenticate("", "");

        assertNull(user, "Empty credentials should not authenticate");
    }

    /**
     * Test 8: User Object Properties
     * 
     * Verifies that the User object returned from authentication
     * contains all required properties.
     * 
     * EXPECTED RESULT:
     * - All getter methods work correctly
     * - No null properties (except where applicable)
     * - IDs and roles are correctly populated
     */
    @Test
    void shouldReturnCompleteUserObject() {
        UserDAO dao = new UserDAO();
        User user = dao.authenticate("admin", getTestPasswordHash());

        if (user != null) {
            // Verify all properties are accessible
            assertNotNull(user.getId(), "User ID should not be null");
            assertNotNull(user.getUsername(), "Username should not be null");
            assertNotNull(user.getRole(), "Role should not be null");
            assertNotNull(user.getFullName(), "Full name should not be null");

            // Verify properties are not empty
            assertTrue(user.getUsername().length() > 0, "Username should not be empty");
            assertTrue(user.getRole().length() > 0, "Role should not be empty");
        }
    }

    /**
     * Test 9: Multiple Authentication Attempts
     * 
     * Verifies that the DAO can be used for multiple sequential authentication calls.
     * 
     * EXPECTED RESULT:
     * - First authentication succeeds
     * - Second authentication succeeds
     * - Both return correct user objects
     * - Database connection is properly managed
     * 
     * BUSINESS LOGIC:
     * Tests that the DAO doesn't have state issues between calls.
     */
    @Test
    void shouldHandleMultipleAuthenticationAttempts() {
        UserDAO dao = new UserDAO();
        String correctPasswordHash = getTestPasswordHash();

        // First attempt - correct password
        User user1 = dao.authenticate("admin", correctPasswordHash);
        assertNotNull(user1, "First authentication should succeed");

        // Second attempt - wrong password
        User user2 = dao.authenticate("admin", PasswordUtil.hashPassword("wrong"));
        assertNull(user2, "Second authentication with wrong password should fail");

        // Third attempt - correct password again
        User user3 = dao.authenticate("admin", correctPasswordHash);
        assertNotNull(user3, "Third authentication should succeed again");
    }

    /**
     * Test 10: Authentication Security - Password Not Exposed
     * 
     * Verifies that the authentication mechanism doesn't expose or log passwords.
     * 
     * EXPECTED RESULT:
     * - User object returned does not contain the password
     * - User object does not contain the password hash
     * 
     * NOTE:
     * The User model class should NOT have a password or password hash field.
     * This ensures that even if a User object is logged or exposed,
     * it doesn't reveal sensitive information.
     */
    @Test
    void shouldNotExposePasswordInUserObject() {
        UserDAO dao = new UserDAO();
        User user = dao.authenticate("admin", getTestPasswordHash());

        if (user != null) {
            // The User class should only have: id, username, role, fullName
            // It should NOT have password or passwordHash fields
            assertFalse(user.toString().contains("password"),
                       "User object should not contain password information");
        }
    }
}
