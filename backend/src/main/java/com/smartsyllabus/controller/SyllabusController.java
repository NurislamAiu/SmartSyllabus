package com.smartsyllabus.controller;

import com.smartsyllabus.dto.SyllabusDto;
import com.smartsyllabus.repository.SyllabusRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/syllabus")
public class SyllabusController {

    private final SyllabusRepository syllabusRepository;

    public SyllabusController(SyllabusRepository syllabusRepository) {
        this.syllabusRepository = syllabusRepository;
    }

    @GetMapping("/all")
    public List<SyllabusDto> getAllSyllabuses() {
        return syllabusRepository.fetchAll();
    }
}