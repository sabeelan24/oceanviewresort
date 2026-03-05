package com.oceanview.model;

import java.math.BigDecimal;

public class RoomType {
    private int typeId;
    private String name;
    private BigDecimal basePrice;
    private String description;

    // Constructors, Getters, Setters
    public RoomType() {}

    public RoomType(int typeId, String name, BigDecimal basePrice, String description) {
        this.typeId = typeId;
        this.name = name;
        this.basePrice = basePrice;
        this.description = description;
    }

    public int getTypeId() { return typeId; }
    public String getName() { return name; }
    public BigDecimal getBasePrice() { return basePrice; }
    public String getDescription() { return description; }
    
    public void setTypeId(int typeId) { this.typeId = typeId; }
    public void setName(String name) { this.name = name; }
    public void setBasePrice(BigDecimal basePrice) { this.basePrice = basePrice; }
    public void setDescription(String description) { this.description = description; }
}