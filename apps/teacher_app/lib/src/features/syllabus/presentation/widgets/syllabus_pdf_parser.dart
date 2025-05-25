import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<Map<String, dynamic>?> parseSyllabusFromPdf() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result == null || result.files.single.path == null) return null;

  final file = File(result.files.single.path!);
  final bytes = await file.readAsBytes();
  final document = PdfDocument(inputBytes: bytes);
  final rawText = PdfTextExtractor(document).extractText();
  document.dispose();

  final text = rawText.replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ');

  String? extract(String start, String end) {
    final startIndex = text.indexOf(start);
    final endIndex = text.indexOf(end, startIndex + start.length);
    if (startIndex != -1 && endIndex != -1) {
      return text.substring(startIndex + start.length, endIndex).trim();
    }
    return '';
  }

  final title = extract('по дисциплине', '(код');
  final code = extract('по дисциплине', 'Программирование')
      ?.split(' ')
      .firstWhere((e) => e.startsWith('JP'), orElse: () => '');
  final program = extract('по образовательной программе', 'осенний');
  final credits = extract('Кол-во кредитов -', 'Всего');
  final controlType = extract('итогового контроля', 'Лекции')?.toLowerCase();
  final lecturer = extract('Лектор', 'e-mail');
  final contact = extract('e-mail и телефон:', 'Zoom ID');
  final zoom = extract('Zoom ID', 'Ассистент');
  final assistant = extract('Ассистент', 'e-mail и телефон:');
  final assistantContact = extract('e-mail и телефон:', 'Академическая информация');

  var description = extract('Краткое описание дисциплины', 'Результаты обучения (согласно ЕСУВО)');
  if (description!.isEmpty) {
    description = extract('Краткое описание дисциплины', 'РО');
  }

  final prerequisite = extract('Пререквизиты', 'Постреквизиты');
  final postrequisite = extract('Постреквизиты', 'Литература');
  final resources = extract('Интернет ресурсы', 'Программное обеспечение');
  final software = extract('Программное обеспечение', 'Политика дисциплины');
  final policy = extract('Политика дисциплины', 'Политика оценивания');
  final assessment = extract('Политика оценивания', 'ТЕМАТИЧЕСКИЙ ПЛАН');
  final topicsPlan = extract('ТЕМАТИЧЕСКИЙ ПЛАН', 'Экзаменационные вопросы');

  final outcomes = RegExp(r'(РО\d{1,2})\s*[-–—]\s*(.*?)(?=(РО\d{1,2})|$)', dotAll: true)
      .allMatches(text)
      .map((match) => '${match.group(1)} — ${match.group(2)?.trim()}')
      .toList();

  final litStart = text.indexOf('Литература');
  final litEnd = text.indexOf('Интернет ресурсы');
  String rawBlock = '';
  if (litStart != -1 && litEnd != -1) {
    rawBlock = text.substring(litStart, litEnd);
  }

  final cleanedBlock = rawBlock.replaceAll(RegExp(r'[\u00AD\u2028\r\n\t]+'), ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
  final literature = RegExp(r'\d+\.\s+(.*?)(?=(\d+\.\s+|$))', dotAll: true)
      .allMatches(cleanedBlock)
      .map((m) => m.group(1)!.trim())
      .where((e) => e.isNotEmpty)
      .toList();

  final exStart = text.indexOf('Экзаменационные вопросы');
  final examQuestions = exStart != -1
      ? RegExp(r'\d+\.\s(.*?)(?=\d+\.\s|$)', dotAll: true).allMatches(text.substring(exStart)).map((m) => m.group(1)!.trim()).toList()
      : [];

  return {
    'title': title,
    'code': code,
    'program': program,
    'credits': credits?.trim(),
    'lecturer': lecturer,
    'contact': contact,
    'zoom': zoom,
    'assistant': assistant,
    'assistantContact': assistantContact,
    'description': description,
    'prerequisite': prerequisite,
    'postrequisite': postrequisite,
    'resources': resources,
    'software': software,
    'policy': policy,
    'assessment': assessment,
    'topicsPlan': topicsPlan,
    'controlType': controlType,
    'outcomes': outcomes,
    'literature': literature,
    'examQuestions': examQuestions,
  };
}