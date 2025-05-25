package com.smartsyllabus.service;

import com.smartsyllabus.dto.NotificationDto;
import com.smartsyllabus.repository.NotificationRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NotificationService {

    private final NotificationRepository repository;

    public NotificationService(NotificationRepository repository) {
        this.repository = repository;
    }

    public List<NotificationDto> getUnreadNotifications(int limit) {
        return repository.fetchUnread(limit);
    }
}