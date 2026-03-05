package com.oceanview.model;

public class Guest {
    private int guestId;
    private String fullName;
    private String contactNumber;
    private String email;

    // Constructors
    public Guest() {}

    public Guest(int guestId, String fullName, String contactNumber, String email) {
        this.guestId = guestId;
        this.fullName = fullName;
        this.contactNumber = contactNumber;
        this.email = email;
    }

    // Getters and Setters
    public int getGuestId() {
        return guestId;
    }

    public void setGuestId(int guestId) {
        this.guestId = guestId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}