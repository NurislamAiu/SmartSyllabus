package com.smartsyllabus.controller;

import com.smartsyllabus.dto.ExamDto;
import com.smartsyllabus.repository.ExamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/api/exams")
@CrossOrigin(origins = "*")
public class ExamController {

    @Autowired
    private ExamRepository examRepository;

    @PostMapping("/create")
    public void createExam(@RequestBody ExamDto exam) throws ExecutionException, InterruptedException {
        examRepository.createExam(exam);
    }

    @GetMapping("/all")
    public List<ExamDto> getAllExams() throws ExecutionException, InterruptedException {
        return examRepository.fetchAllExams();
    }
}
