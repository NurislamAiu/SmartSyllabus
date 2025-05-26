package com.smartsyllabus.entity;

import java.util.Date;

public class NewsItem {
    private String id;
    private String title;
    private String content;
    private Date date;

    public NewsItem() {}

    public NewsItem(String id, String title, String content, Date date) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.date = date;
    }

    public String getId() { return id; }
    public String getTitle() { return title; }
    public String getContent() { return content; }
    public Date getDate() { return date; }

    public void setId(String id) { this.id = id; }
    public void setTitle(String title) { this.title = title; }
    public void setContent(String content) { this.content = content; }
    public void setDate(Date date) { this.date = date; }
}