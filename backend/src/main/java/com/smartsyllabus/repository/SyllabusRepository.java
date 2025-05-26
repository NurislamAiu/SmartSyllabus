package com.smartsyllabus.repository;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import com.smartsyllabus.dto.KpiResponse;
import com.smartsyllabus.dto.SyllabusDto;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public class SyllabusRepository {

    private final Firestore db = FirestoreClient.getFirestore();

    public KpiResponse fetchKpi() {
        try {
            int total = getCount(null);
            int pending = getCount("pending");
            int approved = getCount("approved");
            int rejected = getCount("rejected");

            return new KpiResponse(total, pending, approved, rejected);
        } catch (Exception e) {
            e.printStackTrace();
            return new KpiResponse(0, 0, 0, 0);
        }
    }

    private int getCount(String status) throws Exception {
        CollectionReference ref = db.collection("syllabuses");

        Query query = (status == null) ? ref : ref.whereEqualTo("status", status);
        ApiFuture<QuerySnapshot> future = query.get();

        return future.get().size();
    }

    public List<SyllabusDto> fetchAll() {
        List<SyllabusDto> result = new ArrayList<>();
        try {
            Firestore db = FirestoreClient.getFirestore();

            ApiFuture<QuerySnapshot> future = db.collection("syllabuses")
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

    public void save(Map<String, Object> data) throws Exception {
        Firestore db = FirestoreClient.getFirestore();

        // Добавляем дату создания
        data.put("createdAt", FieldValue.serverTimestamp());

        db.collection("syllabuses").add(data).get(); // сразу выполняем
    }
}
