import 'exam_model.dart';

final List<ExamModel> mockExamList = [
  ExamModel(
    title: 'Основы Flutter',
    type: 'Проект',
    questions: [
      'Разработайте TODO-приложение на Flutter',
      'Реализуйте хранение данных с помощью Firebase',
    ],
    criteria: 'Функциональность, UI, архитектура, защита проекта',
    date: DateTime.now().add(const Duration(days: 7)),
  ),
  ExamModel(
    title: 'История Казахстана',
    type: 'Тест',
    questions: [
      'Когда была принята первая Конституция РК?',
      'Назовите этапы Великой Отечественной войны',
    ],
    criteria: 'Правильность ответов, время выполнения',
    date: DateTime.now().add(const Duration(days: 14)),
  ),
];