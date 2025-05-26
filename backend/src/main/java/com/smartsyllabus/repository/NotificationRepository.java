package com.smartsyllabus.repository;

import com.google.api.core.ApiFuture;
import com.google.cloud.Timestamp;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import com.smartsyllabus.dto.NotificationDto;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public class NotificationRepository {

    public List<NotificationDto> fetchUnread(int limit) {
        List<NotificationDto> result = new ArrayList<>();

        try {
            Firestore db = FirestoreClient.getFirestore();
            ApiFuture<QuerySnapshot> future = db.collection("notifications")
                    .whereEqualTo("read", false)
                    .orderBy("createdAt", Query.Direction.DESCENDING)
                    .limit(limit)
                    .get();

            List<QueryDocumentSnapshot> documents = future.get().getDocuments();

            for (QueryDocumentSnapshot doc : documents) {
                Map<String, Object> data = doc.getData();

                String id = doc.getId();
                String title = (String) data.getOrDefault("title", "Без заголовка");
                String message = (String) data.getOrDefault("message", "");
                String createdAt = "";

                Object createdAtObj = data.get("createdAt");
                if (createdAtObj instanceof Timestamp ts) {
                    createdAt = ts.toDate().toString();
                }

                result.add(new NotificationDto(id, title, message, createdAt));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}