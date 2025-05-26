package com.smartsyllabus.controller;

import com.smartsyllabus.dto.NewsItemDto;
import com.smartsyllabus.repository.NewsRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/news")
public class NewsController {

    private final NewsRepository newsRepository;

    public NewsController(NewsRepository newsRepository) {
        this.newsRepository = newsRepository;
    }

    @GetMapping("/latest")
    public List<NewsItemDto> getLatestNews(@RequestParam(name = "limit", defaultValue = "2") int limit) {
        return newsRepository.fetchLatest(limit);
    }
}