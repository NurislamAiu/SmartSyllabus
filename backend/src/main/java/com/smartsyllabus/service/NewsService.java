package com.smartsyllabus.service;

import com.smartsyllabus.dto.NewsItemDto;
import com.smartsyllabus.repository.NewsRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NewsService {

    private final NewsRepository repository;

    public NewsService(NewsRepository repository) {
        this.repository = repository;
    }

    public List<NewsItemDto> getLatestNews(int limit) {
        return repository.fetchLatest(limit);
    }
}