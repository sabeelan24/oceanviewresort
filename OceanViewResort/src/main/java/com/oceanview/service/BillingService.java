package com.oceanview.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class BillingService {

    public BigDecimal calculateTotalCost(LocalDate checkIn, LocalDate checkOut, BigDecimal nightlyRate) {
        // 1. Calculate number of nights
        long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
        
        // Validation: If dates are same or invalid, assume at least 1 night for logic safety
        if (nights < 1) {
            nights = 1; 
        }

        // 2. Calculate Total (Nights * Rate)
        // Using BigDecimal is critical for currency (Double is not precise enough for distinctions)
        return nightlyRate.multiply(new BigDecimal(nights));
    }

    public long calculateNights(LocalDate checkIn, LocalDate checkOut) {
        long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
        return nights < 1 ? 0 : nights;
    }
}