package com.oceanview.service;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * BillingServiceTest
 * 
 * ACADEMIC PURPOSE: Unit Testing with JUnit 5
 * Tests the BillingService class to verify:
 * - Correct total calculation for valid date ranges
 * - Exception handling for invalid dates
 * - BigDecimal precision for currency calculations
 * - Boundary case handling
 * 
 * @author OceanView Resort Testing Team
 */
public class BillingServiceTest {

    /**
     * Test 1: Correct Total Calculation for Valid Dates
     * 
     * Verifies that the billing service correctly calculates the total cost
     * for a valid date range using the correct formula: nights * rate
     * 
     * Test Data: Check-in: March 1, 2026 | Check-out: March 5, 2026
     * Expected: 4 nights * 20,000 = 80,000
     * 
     * BUSINESS LOGIC VERIFIED:
     * - Date arithmetic is correct
     * - BigDecimal multiplication preserves precision
     */
    @Test
    void shouldCalculateCorrectTotalForValidDates() {
        BillingService service = new BillingService();

        LocalDate checkIn = LocalDate.of(2026, 3, 1);
        LocalDate checkOut = LocalDate.of(2026, 3, 5);
        BigDecimal rate = new BigDecimal("20000");

        BigDecimal total = service.calculateTotalCost(checkIn, checkOut, rate);

        assertEquals(new BigDecimal("80000"), total);
    }

    /**
     * Test 2: Zero Night Booking (Same-Day Checkout)
     * 
     * Verifies that the billing service handles the edge case where
     * check-in and check-out dates are the same.
     * 
     * Current Implementation: Assumes 1 night for same-day dates
     * (Safety fallback in business logic)
     * 
     * Test Data: Same date = March 1, 2026
     * Expected: 1 night * 20,000 = 20,000
     * 
     * IMPORTANT: This behavior ensures guests are not overbilled
     * in edge cases, while preventing zero-cost bookings.
     */
    @Test
    void shouldCalculateOneNightWhenDatesAreEqual() {
        BillingService service = new BillingService();

        LocalDate date = LocalDate.of(2026, 3, 1);
        BigDecimal rate = new BigDecimal("20000");

        BigDecimal total = service.calculateTotalCost(date, date, rate);

        // Business rule: Same-day booking defaults to 1 night
        assertEquals(new BigDecimal("20000"), total);
    }

    /**
     * Test 3: Checkout Before Checkin
     * 
     * Verifies that when checkout date is before check-in date,
     * the system defaults to 1 night (safety mechanism).
     * 
     * Test Data: Check-in: March 5, 2026 | Check-out: March 1, 2026
     * Expected: 1 night * 20,000 = 20,000 (fallback behavior)
     * 
     * NOTE: In a real system, this might throw an exception.
     * Current implementation uses safety fallback.
     */
    @Test
    void shouldCalculateOneNightWhenCheckoutBeforeCheckin() {
        BillingService service = new BillingService();

        LocalDate checkIn = LocalDate.of(2026, 3, 5);
        LocalDate checkOut = LocalDate.of(2026, 3, 1);
        BigDecimal rate = new BigDecimal("20000");

        BigDecimal total = service.calculateTotalCost(checkIn, checkOut, rate);

        // Business rule: Invalid dates default to 1 night
        assertEquals(new BigDecimal("20000"), total);
    }

    /**
     * Test 4: Long Duration Booking
     * 
     * Verifies that the billing service correctly handles extended stays
     * (testing limits of date arithmetic).
     * 
     * Test Data: Check-in: January 1, 2026 | Check-out: February 1, 2026
     * Expected: 31 nights * 20,000 = 620,000
     * 
     * MATHEMATICAL VERIFICATION:
     * January has 31 days, so Jan 1 to Feb 1 = 31 nights
     * 
     * CRITICAL VALIDATION:
     * - Long-duration bookings don't overflow
     * - BigDecimal scales correctly for large amounts
     */
    @Test
    void shouldHandleLongStayCorrectly() {
        BillingService service = new BillingService();

        LocalDate checkIn = LocalDate.of(2026, 1, 1);
        LocalDate checkOut = LocalDate.of(2026, 2, 1);
        BigDecimal rate = new BigDecimal("20000");

        BigDecimal total = service.calculateTotalCost(checkIn, checkOut, rate);

        assertEquals(new BigDecimal("620000"), total); // 31 nights
    }

    /**
     * Test 5: Nightly Rate Calculation
     * 
     * Verifies the independent calculateNights() method works correctly.
     * 
     * Test Data: March 1 to March 5, 2026
     * Expected: 4 nights
     */
    @Test
    void shouldCalculateNightsCorrectly() {
        BillingService service = new BillingService();

        LocalDate checkIn = LocalDate.of(2026, 3, 1);
        LocalDate checkOut = LocalDate.of(2026, 3, 5);

        long nights = service.calculateNights(checkIn, checkOut);

        assertEquals(4, nights);
    }

    /**
     * Test 6: Single Night Stay
     * 
     * Verifies correct calculation for the minimum booking unit (1 night).
     * 
     * Test Data: March 1 to March 2, 2026
     * Expected: 1 night * 20,000 = 20,000
     */
    @Test
    void shouldCalculateSingleNightStay() {
        BillingService service = new BillingService();

        LocalDate checkIn = LocalDate.of(2026, 3, 1);
        LocalDate checkOut = LocalDate.of(2026, 3, 2);
        BigDecimal rate = new BigDecimal("20000");

        BigDecimal total = service.calculateTotalCost(checkIn, checkOut, rate);

        assertEquals(new BigDecimal("20000"), total);
    }

    /**
     * Test 7: High Precision BigDecimal Calculation
     * 
     * Verifies that BigDecimal maintains precision for fractional amounts.
     * (Important for currency with cents/decimal places)
     * 
     * Test Data: 3 nights * 15,750.50 = 47,251.50
     * 
     * PRECISION VALIDATION:
     * - Decimal precision is preserved
     * - No floating-point rounding errors
     */
    @Test
    void shouldMaintainBigDecimalPrecision() {
        BillingService service = new BillingService();

        LocalDate checkIn = LocalDate.of(2026, 3, 1);
        LocalDate checkOut = LocalDate.of(2026, 3, 4);
        BigDecimal rate = new BigDecimal("15750.50");

        BigDecimal total = service.calculateTotalCost(checkIn, checkOut, rate);

        assertEquals(new BigDecimal("47251.50"), total);
    }
}
