package com.smartsyllabus.repository;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import com.smartsyllabus.dto.NewsItemDto;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.google.cloud.Timestamp;

@Repository
public class NewsRepository {

    public List<NewsItemDto> fetchLatest(int limit) {
        List<NewsItemDto> result = new ArrayList<>();
        try {
            Firestore db = FirestoreClient.getFirestore();
            ApiFuture<QuerySnapshot> future = db.collection("news")
                    .orderBy("date", Query.Direction.DESCENDING)
                    .limit(limit)
                    .get();

            List<QueryDocumentSnapshot> docs = future.get().getDocuments();
            for (QueryDocumentSnapshot doc : docs) {
                Map<String, Object> data = doc.getData();
                result.add(new NewsItemDto(
                        doc.getId(),
                        (String) data.get("title"),
                        (String) data.get("content"),
                        (String) data.get("imageUrl"),
                        data.get("date") != null ? ((Timestamp) data.get("date")).toDate().toInstant().toString() : ""
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}