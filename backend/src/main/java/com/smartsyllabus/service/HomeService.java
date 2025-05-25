package com.smartsyllabus.service;

import com.smartsyllabus.dto.KpiResponse;
import com.smartsyllabus.repository.SyllabusRepository;
import org.springframework.stereotype.Service;

@Service
public class HomeService {

    private final SyllabusRepository repository;

    public HomeService(SyllabusRepository repository) {
        this.repository = repository;
    }

    public KpiResponse getKpiStats() {
        return repository.fetchKpi();
    }
}