package com.smartsyllabus.dto;

public class NewsItemDto {
    private String id;
    private String title;
    private String content;
    private String imageUrl;
    private String date;

    public NewsItemDto(String id, String title, String content, String imageUrl, String date) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.imageUrl = imageUrl;
        this.date = date;
    }

    public String getId() { return id; }
    public String getTitle() { return title; }
    public String getContent() { return content; }
    public String getImageUrl() { return imageUrl; }
    public String getDate() { return date; }
}