package com.smartsyllabus.entity;

import java.util.Date;

public class Notification {
    private String id;
    private String title;
    private String message;
    private boolean read;
    private Date createdAt;

    public Notification() {}

    public Notification(String id, String title, String message, boolean read, Date createdAt) {
        this.id = id;
        this.title = title;
        this.message = message;
        this.read = read;
        this.createdAt = createdAt;
    }

    public String getId() { return id; }
    public String getTitle() { return title; }
    public String getMessage() { return message; }
    public boolean isRead() { return read; }
    public Date getCreatedAt() { return createdAt; }

    public void setId(String id) { this.id = id; }
    public void setTitle(String title) { this.title = title; }
    public void setMessage(String message) { this.message = message; }
    public void setRead(boolean read) { this.read = read; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}