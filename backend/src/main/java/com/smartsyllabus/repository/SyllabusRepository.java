package com.smartsyllabus.repository;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import com.smartsyllabus.dto.KpiResponse;
import org.springframework.stereotype.Repository;

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
}