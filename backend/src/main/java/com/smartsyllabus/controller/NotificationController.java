package com.smartsyllabus.controller;

import com.smartsyllabus.dto.NotificationDto;
import com.smartsyllabus.service.NotificationService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/notifications")
public class NotificationController {

    private final NotificationService notificationService;

    public NotificationController(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    @GetMapping("/unread")
    public List<NotificationDto> getUnreadNotifications(@RequestParam(name = "limit", defaultValue = "10") int limit) {
        return notificationService.getUnreadNotifications(limit);
    }
}