package com.smartsyllabus.controller;

import com.smartsyllabus.dto.SyllabusDto;
import com.smartsyllabus.repository.SyllabusRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

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

    @PostMapping("/create")
    public ResponseEntity<String> create(@RequestBody Map<String, Object> payload) {
        try {
            syllabusRepository.save(payload);
            return ResponseEntity.ok("Силабус создан");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Ошибка: " + e.getMessage());
        }
    }

}