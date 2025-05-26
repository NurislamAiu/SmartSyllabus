package com.smartsyllabus.controller;

import com.smartsyllabus.dto.KpiResponse;
import com.smartsyllabus.service.HomeService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/home")
public class HomeController {

    private final HomeService homeService;

    public HomeController(HomeService homeService) {
        this.homeService = homeService;
    }

    @GetMapping("/kpi")
    public KpiResponse getKpi() {
        return homeService.getKpiStats();
    }
}