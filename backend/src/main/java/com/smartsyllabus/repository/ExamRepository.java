package com.smartsyllabus.repository;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import com.smartsyllabus.dto.ExamDto;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Repository
public class ExamRepository {

    public void createExam(ExamDto exam) throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        db.collection("exams").add(exam);
    }

    public List<ExamDto> fetchAllExams() {
        List<ExamDto> result = new ArrayList<>();
        try {
            Firestore db = FirestoreClient.getFirestore();

            ApiFuture<QuerySnapshot> future = db.collection("exams")
                    .orderBy("date", Query.Direction.DESCENDING)
                    .get();

            List<QueryDocumentSnapshot> documents = future.get().getDocuments();

            for (QueryDocumentSnapshot doc : documents) {
                ExamDto exam = doc.toObject(ExamDto.class);
                result.add(exam);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}