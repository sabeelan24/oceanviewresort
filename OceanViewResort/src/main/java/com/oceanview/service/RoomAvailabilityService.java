package com.oceanview.service;

import java.time.LocalDate;
import java.util.List;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Room;

/**
 * RoomAvailabilityService
 * 
 * ACADEMIC PURPOSE: Service Layer Pattern
 * This class encapsulates all business logic related to room availability checks.
 * It sits between the Controller (Servlet) and DAO layers, promoting:
 * - Separation of Concerns
 * - Code Reusability
 * - Easier Testing and Maintenance
 * 
 * @author OceanView Resort Development Team
 */
public class RoomAvailabilityService {
    
    private RoomDAO roomDAO;
    private ReservationDAO reservationDAO;
    
    /**
     * Constructor with dependency injection
     */
    public RoomAvailabilityService() {
        this.roomDAO = new RoomDAO();
        this.reservationDAO = new ReservationDAO();
    }
    
    /**
     * Constructor for testing (allows mock DAOs)
     */
    public RoomAvailabilityService(RoomDAO roomDAO, ReservationDAO reservationDAO) {
        this.roomDAO = roomDAO;
        this.reservationDAO = reservationDAO;
    }
    
    /**
     * Check if a specific room is available for the given date range
     * 
     * @param roomId The ID of the room to check
     * @param checkIn The check-in date
     * @param checkOut The check-out date
     * @return true if the room is available, false otherwise
     * 
     * ACADEMIC NOTE: This method delegates to the DAO layer for the actual
     * database check, maintaining proper separation of concerns.
     */
    public boolean isRoomAvailable(int roomId, LocalDate checkIn, LocalDate checkOut) {
        // Input validation
        if (checkIn == null || checkOut == null) {
            return false;
        }
        
        if (checkIn.isAfter(checkOut) || checkIn.isEqual(checkOut)) {
            return false;
        }
        
        // Delegate to DAO for database check
        return reservationDAO.isRoomAvailable(roomId, checkIn, checkOut);
    }
    
    /**
     * Get all available rooms for a specific room type and date range
     * 
     * @param roomTypeId The type of room requested
     * @param checkIn The check-in date
     * @param checkOut The check-out date
     * @return List of available rooms, empty list if none available
     * 
     * ACADEMIC NOTE: This method uses advanced SQL subqueries (implemented in DAO)
     * to find rooms NOT booked during the overlapping period.
     */
    public List<Room> getAvailableRooms(int roomTypeId, LocalDate checkIn, LocalDate checkOut) {
        // Input validation
        if (checkIn == null || checkOut == null) {
            return List.of(); // Return empty list
        }
        
        if (checkIn.isAfter(checkOut) || checkIn.isEqual(checkOut)) {
            return List.of(); // Return empty list
        }
        
        // Delegate to DAO for complex query execution
        return roomDAO.getAvailableRooms(roomTypeId, checkIn, checkOut);
    }
    
    /**
     * Validate date range for reservations
     * 
     * @param checkIn The check-in date
     * @param checkOut The check-out date
     * @return true if dates are valid, false otherwise
     * 
     * BUSINESS RULES:
     * - Check-out must be after check-in
     * - Check-in cannot be in the past
     * - Minimum stay of 1 night
     */
    public boolean isValidDateRange(LocalDate checkIn, LocalDate checkOut) {
        if (checkIn == null || checkOut == null) {
            return false;
        }
        
        // Check-out must be after check-in
        if (!checkOut.isAfter(checkIn)) {
            return false;
        }
        
        // Check-in cannot be in the past
        if (checkIn.isBefore(LocalDate.now())) {
            return false;
        }
        
        return true;
    }
    
    /**
     * Check if there are any available rooms for a room type
     * 
     * @param roomTypeId The room type to check
     * @param checkIn The check-in date
     * @param checkOut The check-out date
     * @return true if at least one room is available
     */
    public boolean hasAvailableRooms(int roomTypeId, LocalDate checkIn, LocalDate checkOut) {
        List<Room> availableRooms = getAvailableRooms(roomTypeId, checkIn, checkOut);
        return availableRooms != null && !availableRooms.isEmpty();
    }
    
    /**
     * Get the count of available rooms for a specific room type
     * 
     * @param roomTypeId The room type to check
     * @param checkIn The check-in date
     * @param checkOut The check-out date
     * @return Number of available rooms
     */
    public int getAvailableRoomCount(int roomTypeId, LocalDate checkIn, LocalDate checkOut) {
        List<Room> availableRooms = getAvailableRooms(roomTypeId, checkIn, checkOut);
        return (availableRooms != null) ? availableRooms.size() : 0;
    }
    
    /**
     * FULL INVENTORY VIEW: Get ALL rooms with availability status
     * 
     * ACADEMIC NOTE: This method implements the "Full Inventory" requirement.
     * Instead of showing only available rooms, it shows ALL rooms and marks them
     * as either Available (green) or Occupied (red).
     * 
     * BUSINESS BENEFIT:
     * - Prevents the "empty list looks broken" problem
     * - Shows staff the complete hotel inventory
     * - Allows them to say "Room 101 is taken" instead of "I don't see Room 101"
     * 
     * @param roomTypeId The room type to check
     * @param checkIn The check-in date
     * @param checkOut The check-out date
     * @return List of ALL rooms with availability status set
     */
    public List<Room> getAllRoomsWithAvailability(int roomTypeId, LocalDate checkIn, LocalDate checkOut) {
        // Input validation
        if (checkIn == null || checkOut == null) {
            return List.of(); // Return empty list
        }
        
        if (checkIn.isAfter(checkOut) || checkIn.isEqual(checkOut)) {
            return List.of(); // Return empty list
        }
        
        // Delegate to DAO for full inventory query
        return roomDAO.getAllRoomsWithAvailability(roomTypeId, checkIn, checkOut);
    }
}
