import 'dart:async';
import 'package:flutter/material.dart';
import 'package:teacher_app/src/features/syllabus/data/syllabus.dart';

class AIGeneratedController {
  final TextEditingController topicController = TextEditingController();

  bool isLoading = false;
  String currentPhrase = "";
  int phraseIndex = 0;
  Map<String, dynamic>? syllabusData;

  final List<String> loadingPhrases = [
    "🔍 Ищем лучшие практики...",
    "🧠 Подключаем искусственный интеллект...",
    "📚 Формируем структуру курса...",
    "📊 Добавляем оценивание и темы...",
    "✅ Завершаем генерацию..."
  ];

  final Map<String, dynamic> mockSyllabus = {
    "title": "Основы Flutter",
    "code": "FL101",
    "program": "Бакалавриат Информатики",
    "credits": 3,
    "lecturer": "Асанова Дина",
    "contact": "dina.asanova@aiu.edu.kz",
    "zoom": "https://zoom.us/flutter101",
    "assistant": "Нурислам Ильясов",
    "assistantContact": "+77001234567",
    "goal": "Научить студентов создавать мобильные приложения с использованием Flutter.",
    "description": "Курс охватывает основы разработки на Flutter, включая UI, state management и работу с API.",
    "prerequisite": "Основы программирования",
    "postrequisite": "Мобильная разработка II",
    "resources": "Flutter Docs, DartPad",
    "software": "Android Studio, VS Code",
    "policy": "Регулярное посещение и сдача всех заданий обязательны.",
    "assessment": "30% задания, 30% проекты, 40% экзамен",
    "topicsPlan": "Неделя 1: Введение в Flutter\nНеделя 2: Виджеты\nНеделя 3: Состояния\n...",
    "semester": "Осенний 2025",
    "controlType": "Экзамен",
    "outcomes": ["Уметь создавать UI", "Работать с REST API", "Применять паттерны управления состоянием"],
    "literature": ["Flutter Apprentice", "Flutter in Action"],
    "examQuestions": ["Что такое StatelessWidget?", "Как работает setState()?"]
  };

  Future<void> generateSyllabus(VoidCallback onUpdate) async {
    isLoading = true;
    syllabusData = null;
    currentPhrase = loadingPhrases[0];
    phraseIndex = 0;
    onUpdate();

    _startPhraseAnimation(onUpdate);

    await Future.delayed(const Duration(seconds: 6));

    syllabusData = mockSyllabus;
    isLoading = false;
    onUpdate();
  }

  void _startPhraseAnimation(VoidCallback onUpdate) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isLoading || phraseIndex >= loadingPhrases.length) {
        timer.cancel();
        return;
      }
      currentPhrase = loadingPhrases[phraseIndex++];
      onUpdate();
    });
  }

  void dispose() {
    topicController.dispose();
  }
}