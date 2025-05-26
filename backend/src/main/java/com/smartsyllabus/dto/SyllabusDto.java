package com.smartsyllabus.dto;

public class SyllabusDto {
    private String title;
    private String description;
    private String createdAt;
    private String status;

    public SyllabusDto(String title, String description, String createdAt, String status) {
        this.title = title;
        this.description = description;
        this.createdAt = createdAt;
        this.status = status;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public String getStatus() {
        return status;
    }
}