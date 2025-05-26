package com.smartsyllabus.dto;

import java.util.Date;
import java.util.List;

public class ExamDto {
    private String id;
    private String title;
    private String type;
    private String criteria;
    private Date date;
    private List<String> questions;

    public ExamDto() {}

    public ExamDto(String id, String title, String type, String criteria, Date date, List<String> questions) {
        this.id = id;
        this.title = title;
        this.type = type;
        this.criteria = criteria;
        this.date = date;
        this.questions = questions;
    }

    // Getters and setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getCriteria() { return criteria; }
    public void setCriteria(String criteria) { this.criteria = criteria; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public List<String> getQuestions() { return questions; }
    public void setQuestions(List<String> questions) { this.questions = questions; }
}