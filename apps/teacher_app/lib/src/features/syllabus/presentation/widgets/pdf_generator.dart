import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> generatePdfSkeleton() async {
  final pdf = pw.Document();

  final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
  final ttf = pw.Font.ttf(fontData);

  final bold = pw.TextStyle(
    font: ttf,
    fontWeight: pw.FontWeight.bold,
    fontSize: 8,
  );
  final normal = pw.TextStyle(font: ttf, fontSize: 9);

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(24),
      theme: pw.ThemeData.withFont(base: ttf),
      build:
          (context) => [
        pw.Center(
          child: pw.Text('АСТАНА ХАЛЫҚАРАЛЫҚ УНИВЕРСИТЕТІ', style: bold),
        ),
        pw.Center(
          child: pw.Text('МЕЖДУНАРОДНЫЙ УНИВЕРСИТЕТ АСТАНА', style: bold),
        ),
        pw.SizedBox(height: 20),

        /// Заголовок "Общая информация"
        pw.Table(
          border: pw.TableBorder.all(),
          columnWidths: {0: pw.FlexColumnWidth(1)},
          children: [
            pw.TableRow(
              children: [
                pw.Container(
                  alignment: pw.Alignment.center,
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text('Общая информация', style: bold),
                ),
              ],
            ),
          ],
        ),

        /// Таблица с данными
        pw.Table(
          border: pw.TableBorder.all(),
          columnWidths: {
            0: pw.FlexColumnWidth(3),
            1: pw.FlexColumnWidth(5),
            2: pw.FlexColumnWidth(2),
            3: pw.FlexColumnWidth(2),
          },
          children: [
            /// Первая строка
            pw.TableRow(
              children: [
                pw.Container(
                  alignment: pw.Alignment.center,
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    'Код и название дисциплины',
                    style: bold,
                  ),
                ),
                pw.Column(
                  children: [
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text('Кол-во кредитов – 6', style: bold),
                    ),
                    pw.Table(
                      border: pw.TableBorder.all(),
                      columnWidths: {
                        0: pw.FlexColumnWidth(1),
                        1: pw.FlexColumnWidth(2.5),
                        2: pw.FlexColumnWidth(1),
                        3: pw.FlexColumnWidth(1),
                      },
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Center(
                              child: pw.Padding(
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text('Лекции', style: bold),
                              ),
                            ),
                            pw.Center(
                              child: pw.Padding(
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  'Семинары/\nпракт./лаб. занятия',
                                  style: bold,
                                ),
                              ),
                            ),
                            pw.Center(
                              child: pw.Padding(
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text('СРСП', style: bold),
                              ),
                            ),
                            pw.Center(
                              child: pw.Padding(
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text('СРС', style: bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                pw.Center(child: pw.Text('Всего\nчасов', style: bold)),
                pw.Center(
                  child: pw.Text(
                    'Форма\nитогового\nконтроля',
                    style: bold,
                  ),
                ),
              ],
            ),

            /// Вторая строка (пустая, можно будет заполнить)
            pw.TableRow(
              children: [
                pw.Container(height: 20),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(1),
                    1: pw.FlexColumnWidth(2.5),
                    2: pw.FlexColumnWidth(1),
                    3: pw.FlexColumnWidth(1),
                  },
                  children: [
                    pw.TableRow(
                      children: List.generate(4, (_) {
                        return pw.Container(height: 20);
                      }),
                    ),
                  ],
                ),
                pw.Container(height: 20),
                pw.Container(height: 20),
              ],
            ),
          ],
        ),

        pw.Table(
          border: pw.TableBorder.all(),
          columnWidths: {0: pw.FlexColumnWidth(1)},
          children: [
            pw.TableRow(
              children: [
                pw.Container(
                  alignment: pw.Alignment.center,
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text('Контактная информация', style: bold),
                ),
              ],
            ),
          ],
        ),

        pw.Table(
          border: pw.TableBorder.all(),
          columnWidths: {
            0: pw.FlexColumnWidth(3),
            1: pw.FlexColumnWidth(9),
          },
          children: [
            pw.TableRow(
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text('Высшая школа', style: bold),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text(
                    'Информационных технологий и инженерии',
                    style: normal,
                  ),
                ),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text('Лектор', style: bold),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text(
                    'Қайұпов Е.К., старший преподаватель',
                    style: normal,
                  ),
                ),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text('e-mail и телефон:', style: bold),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text('yerik.kai@gmail.com', style: normal),
                ),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text('Zoom ID', style: bold),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text('', style: normal),
                ),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text('Ассистент', style: bold),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text('', style: normal),
                ),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text('e-mail и телефон:', style: bold),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text('', style: normal),
                ),
              ],
            ),
          ],
        ),

        pw.SizedBox(height: 10),
        pw.Table(
          border: pw.TableBorder.all(),
          columnWidths: {0: pw.FlexColumnWidth(1)},
          children: [
            pw.TableRow(
              children: [
                pw.Container(
                  alignment: pw.Alignment.center,
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text('Академическая информация', style: bold),
                ),
              ],
            ),
          ],
        ),

        pw.Table(
          border: pw.TableBorder.all(),
          columnWidths: {
            0: pw.FlexColumnWidth(4),
            1: pw.FlexColumnWidth(6),
          },
          children: [
            pw.TableRow(
              children: [
                pw.Text(
                  'Краткое описание дисциплины\n(согласно ЕСУВО)',
                  style: bold,
                ),
                pw.Text(
                  'Результаты обучения\n(согласно ЕСУВО)',
                  style: bold,
                ),
              ],
            ),

            pw.TableRow(
              children: [
                pw.Text(' ', style: normal),

                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(' ', style: normal),

                    pw.SizedBox(height: 6),

                    pw.Table(
                      border: pw.TableBorder.all(),
                      columnWidths: {
                        0: pw.FlexColumnWidth(1),
                        1: pw.FlexColumnWidth(1),
                      },
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Text(
                              'PO 10,11,15 по дисциплине',
                              style: bold,
                            ),
                            pw.Text(
                              'Индикаторы достижения PO по дисциплине',
                              style: bold,
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.Text(' ', style: normal),
                            pw.Text(' ', style: normal),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        pw.Table(
          border: pw.TableBorder.all(),
          columnWidths: {
            0: pw.FlexColumnWidth(4),
            1: pw.FlexColumnWidth(6),
          },
          children: [
            pw.TableRow(
              children: [
                pw.Text('Пререквизиты', style: bold),
                pw.Text('', style: normal),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('Постреквизиты', style: bold),
                pw.Text('', style: normal),
              ],
            ),
          ],
        ),

        pw.Table(
          border: pw.TableBorder.all(),
          columnWidths: {
            0: pw.FlexColumnWidth(4),
            1: pw.FlexColumnWidth(6),
          },
          children: [
            pw.TableRow(
              children: [
                pw.Text('Литература и ресурсы**', style: bold),
                pw.Text('', style: normal),
              ],
            ),
          ],
        ),

        pw.SizedBox(height: 10),

        pw.Table(
          border: pw.TableBorder.all(),
          columnWidths: {0: pw.FlexColumnWidth(10)},
          children: [
            pw.TableRow(
              children: [
                pw.Container(
                  alignment: pw.Alignment.center,
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text('Политика дисциплины', style: bold),
                ),
              ],
            ),

            pw.TableRow(
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  height: 150,
                  child: pw.Text('', style: normal),
                ),
              ],
            ),
          ],
        ),

        pw.Table(
          border: pw.TableBorder.all(),
          columnWidths: {
            0: pw.FlexColumnWidth(3),
            1: pw.FlexColumnWidth(7),
          },
          children: [
            pw.TableRow(
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    'Политика оценивания и аттестации',
                    style: bold,
                  ),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  height: 200,
                  child: pw.Text('', style: normal),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/syllabus_skeleton.pdf');
  await file.writeAsBytes(await pdf.save());

  debugPrint('✅ Каркас PDF сохранён: ${file.path}');
}