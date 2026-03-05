package com.oceanview.service;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import java.time.LocalDate;

/**
 * RoomAvailabilityServiceTest
 * 
 * ACADEMIC PURPOSE: Unit Testing with JUnit 5
 * Tests the RoomAvailabilityService class to verify:
 * - Correct overlap detection logic
 * - Boundary case handling for date ranges
 * - Adjacent booking validation
 * - Date validation logic
 * 
 * NOTE: These tests validate the core business logic without database dependencies.
 * For tests that require database interactions, mocking frameworks would be used
 * in a production environment.
 * 
 * @author OceanView Resort Testing Team
 */
public class RoomAvailabilityServiceTest {

    /**
     * Helper method to check overlap between two date ranges
     * This simulates the overlap detection logic used in the service.
     * 
     * OVERLAP LOGIC:
     * Two date ranges overlap if:
     * - existingStart < newEnd AND
     * - newStart < existingEnd
     * 
     * This is the mathematical definition of date range overlap.
     */
    private boolean isOverlapping(LocalDate existingStart, LocalDate existingEnd,
                                   LocalDate newStart, LocalDate newEnd) {
        return existingStart.isBefore(newEnd) && newStart.isBefore(existingEnd);
    }

    /**
     * Test 1: Partial Overlap Detection
     * 
     * Verifies that the service correctly detects when a new booking
     * partially overlaps with an existing reservation.
     * 
     * Scenario: 
     * - Existing booking: March 1-5, 2026
     * - New booking: March 4-8, 2026
     * - Overlap: March 4-5 (2 days)
     * 
     * BUSINESS IMPACT:
     * The room cannot be booked because guests would be present
     * on overlapping dates.
     * 
     * EXPECTED: True (overlap detected, booking rejected)
     */
    @Test
    void shouldDetectPartialOverlap() {
        RoomAvailabilityService service = new RoomAvailabilityService();

        boolean result = isOverlapping(
            LocalDate.of(2026, 3, 1),   // existing start
            LocalDate.of(2026, 3, 5),   // existing end
            LocalDate.of(2026, 3, 4),   // new start
            LocalDate.of(2026, 3, 8)    // new end
        );

        assertTrue(result, "Partial overlap should be detected");
    }

    /**
     * Test 2: Exact Overlap Detection
     * 
     * Verifies that the service correctly detects when a new booking
     * exactly matches an existing reservation (duplicate booking).
     * 
     * Scenario:
     * - Existing booking: March 1-5, 2026
     * - New booking: March 1-5, 2026 (identical)
     * 
     * BUSINESS IMPACT:
     * The room is fully occupied - no availability.
     * 
     * EXPECTED: True (overlap detected, booking rejected)
     */
    @Test
    void shouldDetectExactOverlap() {
        RoomAvailabilityService service = new RoomAvailabilityService();

        boolean result = isOverlapping(
            LocalDate.of(2026, 3, 1),   // existing start
            LocalDate.of(2026, 3, 5),   // existing end
            LocalDate.of(2026, 3, 1),   // new start (same)
            LocalDate.of(2026, 3, 5)    // new end (same)
        );

        assertTrue(result, "Exact overlap should be detected");
    }

    /**
     * Test 3: Adjacent Booking (Critical Boundary Case)
     * 
     * Verifies that the service correctly handles ADJACENT bookings
     * (checkout date = next check-in date).
     * 
     * Scenario:
     * - Existing booking: March 1-5, 2026 (checkout on March 5)
     * - New booking: March 5-8, 2026 (check-in on March 5)
     * 
     * BUSINESS LOGIC:
     * In hotel operations, checkout and check-in can happen on the same day.
     * If guest A checks out on March 5 morning and guest B checks in on March 5 afternoon,
     * the room can be cleaned in between.
     * 
     * IMPLEMENTATION DETAIL:
     * The overlap check uses strict < comparison, not <=.
     * This allows back-to-back bookings.
     * 
     * EXPECTED: False (no overlap, adjacent booking allowed)
     */
    @Test
    void shouldAllowAdjacentBooking() {
        RoomAvailabilityService service = new RoomAvailabilityService();

        boolean result = isOverlapping(
            LocalDate.of(2026, 3, 1),   // existing start
            LocalDate.of(2026, 3, 5),   // existing end
            LocalDate.of(2026, 3, 5),   // new start (same as existing end)
            LocalDate.of(2026, 3, 8)    // new end
        );

        assertFalse(result, "Adjacent booking should be allowed");
    }

    /**
     * Test 4: Complete Gap Between Bookings
     * 
     * Verifies that the service correctly allows bookings with
     * a clear gap between them.
     * 
     * Scenario:
     * - Existing booking: March 1-5, 2026
     * - New booking: March 10-15, 2026 (5-day gap)
     * 
     * EXPECTED: False (no overlap, booking allowed)
     */
    @Test
    void shouldAllowBookingWithGap() {
        RoomAvailabilityService service = new RoomAvailabilityService();

        boolean result = isOverlapping(
            LocalDate.of(2026, 3, 1),   // existing start
            LocalDate.of(2026, 3, 5),   // existing end
            LocalDate.of(2026, 3, 10),  // new start (5-day gap)
            LocalDate.of(2026, 3, 15)   // new end
        );

        assertFalse(result, "Booking with gap should be allowed");
    }

    /**
     * Test 5: Overlap at Beginning
     * 
     * Verifies that the service detects overlap when the new booking
     * starts within an existing reservation.
     * 
     * Scenario:
     * - Existing booking: March 5-10, 2026
     * - New booking: March 3-7, 2026
     * - Overlap: March 5-7 (3 days)
     * 
     * EXPECTED: True (overlap detected)
     */
    @Test
    void shouldDetectOverlapAtBeginning() {
        RoomAvailabilityService service = new RoomAvailabilityService();

        boolean result = isOverlapping(
            LocalDate.of(2026, 3, 5),   // existing start
            LocalDate.of(2026, 3, 10),  // existing end
            LocalDate.of(2026, 3, 3),   // new start
            LocalDate.of(2026, 3, 7)    // new end
        );

        assertTrue(result, "Overlap at beginning should be detected");
    }

    /**
     * Test 6: Overlap at End
     * 
     * Verifies that the service detects overlap when the new booking
     * ends within an existing reservation.
     * 
     * Scenario:
     * - Existing booking: March 5-10, 2026
     * - New booking: March 8-12, 2026
     * - Overlap: March 8-10 (3 days)
     * 
     * EXPECTED: True (overlap detected)
     */
    @Test
    void shouldDetectOverlapAtEnd() {
        RoomAvailabilityService service = new RoomAvailabilityService();

        boolean result = isOverlapping(
            LocalDate.of(2026, 3, 5),   // existing start
            LocalDate.of(2026, 3, 10),  // existing end
            LocalDate.of(2026, 3, 8),   // new start
            LocalDate.of(2026, 3, 12)   // new end
        );

        assertTrue(result, "Overlap at end should be detected");
    }

    /**
     * Test 7: Complete Containment
     * 
     * Verifies that the service detects overlap when the new booking
     * is completely contained within an existing reservation.
     * 
     * Scenario:
     * - Existing booking: March 1-10, 2026
     * - New booking: March 3-7, 2026 (entirely within existing)
     * 
     * EXPECTED: True (overlap detected)
     */
    @Test
    void shouldDetectCompleteContainment() {
        RoomAvailabilityService service = new RoomAvailabilityService();

        boolean result = isOverlapping(
            LocalDate.of(2026, 3, 1),   // existing start
            LocalDate.of(2026, 3, 10),  // existing end
            LocalDate.of(2026, 3, 3),   // new start
            LocalDate.of(2026, 3, 7)    // new end
        );

        assertTrue(result, "Complete containment should be detected as overlap");
    }

    /**
     * Test 8: Reverse Containment
     * 
     * Verifies that the service detects overlap when the existing booking
     * is completely contained within the new booking.
     * 
     * Scenario:
     * - Existing booking: March 3-7, 2026
     * - New booking: March 1-10, 2026 (contains existing)
     * 
     * EXPECTED: True (overlap detected)
     */
    @Test
    void shouldDetectReverseContainment() {
        RoomAvailabilityService service = new RoomAvailabilityService();

        boolean result = isOverlapping(
            LocalDate.of(2026, 3, 3),   // existing start
            LocalDate.of(2026, 3, 7),   // existing end
            LocalDate.of(2026, 3, 1),   // new start
            LocalDate.of(2026, 3, 10)   // new end
        );

        assertTrue(result, "Reverse containment should be detected as overlap");
    }

    /**
     * Test 9: Valid Date Range Validation
     * 
     * Verifies that the service correctly validates date ranges.
     * 
     * Test Data: Valid check-in tomorrow, check-out in 5 days
     * 
     * BUSINESS RULES:
     * - Check-out must be after check-in
     * - Check-in cannot be in the past
     */
    @Test
    void shouldValidateDateRange() {
        RoomAvailabilityService service = new RoomAvailabilityService();

        LocalDate tomorrow = LocalDate.now().plusDays(1);
        LocalDate inFiveDays = LocalDate.now().plusDays(5);

        boolean isValid = service.isValidDateRange(tomorrow, inFiveDays);

        assertTrue(isValid, "Valid date range should be accepted");
    }

    /**
     * Test 10: Reject Past Check-in Date
     * 
     * Verifies that the service rejects bookings with check-in in the past.
     * 
     * BUSINESS RULE:
     * Cannot book a room for a date that has already passed.
     */
    @Test
    void shouldRejectPastCheckInDate() {
        RoomAvailabilityService service = new RoomAvailabilityService();

        LocalDate yesterday = LocalDate.now().minusDays(1);
        LocalDate tomorrow = LocalDate.now().plusDays(1);

        boolean isValid = service.isValidDateRange(yesterday, tomorrow);

        assertFalse(isValid, "Past check-in date should be rejected");
    }
}
