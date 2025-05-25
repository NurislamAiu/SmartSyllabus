package com.smartsyllabus.repository;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import com.smartsyllabus.dto.SyllabusDto;
import org.springframework.stereotype.Repository;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public class SyllabusRepository {

    public List<SyllabusDto> fetchAll() {
        List<SyllabusDto> result = new ArrayList<>();
        try {
            Firestore db = FirestoreClient.getFirestore();

            ApiFuture<QuerySnapshot> future = db.collection("syllabus")
                    .orderBy("createdAt", Query.Direction.DESCENDING)
                    .get();

            List<QueryDocumentSnapshot> docs = future.get().getDocuments();

            for (QueryDocumentSnapshot doc : docs) {
                Map<String, Object> data = doc.getData();

                String title = (String) data.getOrDefault("title", "Без названия");
                String description = (String) data.getOrDefault("description", "");
                String status = (String) data.getOrDefault("status", "pending");
                String createdAt = "";

                Object createdAtObj = data.get("createdAt");
                if (createdAtObj instanceof com.google.cloud.Timestamp ts) {
                    createdAt = ts.toDate().toInstant().toString(); // ISO 8601
                }

                result.add(new SyllabusDto(title, description, createdAt, status));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}