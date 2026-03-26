import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Service zur PDF-Generierung für KitaFlow-Dokumente.
///
/// Erzeugt Betreuungsverträge, Einverständniserklärungen
/// und Entwicklungsberichte als PDF (A4).
class PdfGenerator {
  PdfGenerator._();

  // ---------------------------------------------------------------------------
  // 1. Betreuungsvertrag
  // ---------------------------------------------------------------------------

  /// Erzeugt einen Betreuungsvertrag als PDF.
  static Future<Uint8List> generateBetreuungsvertrag({
    required String einrichtungsName,
    required String kindName,
    required String geburtsdatum,
    required String elternName,
    required String adresse,
    String? gruppenName,
    DateTime? vertragsBeginn,
    Uint8List? signatureImage,
  }) async {
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          // Header
          pw.Center(
            child: pw.Text(
              'Betreuungsvertrag',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Center(
            child: pw.Text(
              einrichtungsName,
              style: const pw.TextStyle(fontSize: 14),
            ),
          ),
          pw.SizedBox(height: 12),
          pw.Divider(),
          pw.SizedBox(height: 16),

          // 1. Vertragsparteien
          _buildSection(
            '1. Vertragsparteien',
            'Einrichtung: $einrichtungsName\n'
                'Adresse: $adresse\n\n'
                'Erziehungsberechtigte/r: $elternName',
          ),

          // 2. Kind
          _buildSection(
            '2. Kind',
            'Name: $kindName\n'
                'Geburtsdatum: $geburtsdatum'
                '${gruppenName != null ? '\nGruppe: $gruppenName' : ''}',
          ),

          // 3. Vertragsbeginn
          _buildSection(
            '3. Vertragsbeginn',
            vertragsBeginn != null
                ? '${vertragsBeginn.day.toString().padLeft(2, '0')}.'
                    '${vertragsBeginn.month.toString().padLeft(2, '0')}.'
                    '${vertragsBeginn.year}'
                : 'Nach Vereinbarung',
          ),

          // 4. Betreuungszeiten
          _buildSection(
            '4. Betreuungszeiten',
            'Die Betreuungszeiten werden individuell vereinbart.',
          ),

          // 5. Kosten
          _buildSection(
            '5. Kosten',
            'Die monatlichen Betreuungskosten richten sich nach der '
                'aktuellen Gebührenordnung.',
          ),

          // Unterschriften
          pw.SizedBox(height: 32),
          _buildSignatureArea(signatureImage: signatureImage),
        ],
      ),
    );

    return doc.save();
  }

  // ---------------------------------------------------------------------------
  // 2. Einverständniserklärung
  // ---------------------------------------------------------------------------

  /// Erzeugt eine Einverständniserklärung als PDF.
  static Future<Uint8List> generateEinverstaendnis({
    required String einrichtungsName,
    required String kindName,
    required String elternName,
    required String thema,
    Uint8List? signatureImage,
  }) async {
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          // Header
          pw.Center(
            child: pw.Text(
              'Einverständniserklärung',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Center(
            child: pw.Text(
              einrichtungsName,
              style: const pw.TextStyle(fontSize: 14),
            ),
          ),
          pw.SizedBox(height: 12),
          pw.Divider(),
          pw.SizedBox(height: 24),

          // Erklärungstext
          pw.Text(
            'Hiermit erkläre ich, $elternName, dass mein Kind $kindName '
            'an $thema teilnehmen darf.',
            style: const pw.TextStyle(fontSize: 12),
          ),
          pw.SizedBox(height: 16),

          // Widerrufshinweis
          pw.Text(
            'Diese Einverständniserklärung kann jederzeit schriftlich '
            'widerrufen werden. Der Widerruf ist an die Leitung der '
            'Einrichtung zu richten und gilt ab dem Zeitpunkt des Eingangs.',
            style: const pw.TextStyle(fontSize: 12),
          ),

          // Unterschriften
          pw.SizedBox(height: 48),
          _buildSignatureArea(signatureImage: signatureImage),
        ],
      ),
    );

    return doc.save();
  }

  // ---------------------------------------------------------------------------
  // 3. Entwicklungsbericht
  // ---------------------------------------------------------------------------

  /// Erzeugt einen Entwicklungsbericht als PDF.
  static Future<Uint8List> generateEntwicklungsbericht({
    required String einrichtungsName,
    required String kindName,
    required String geburtsdatum,
    required String zeitraum,
    required Map<String, String> bereiche,
    String? zusammenfassung,
  }) async {
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          final widgets = <pw.Widget>[
            // Header
            pw.Center(
              child: pw.Text(
                'Entwicklungsbericht',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Center(
              child: pw.Text(
                '$einrichtungsName — Zeitraum: $zeitraum',
                style: const pw.TextStyle(fontSize: 14),
              ),
            ),
            pw.SizedBox(height: 12),
            pw.Divider(),
            pw.SizedBox(height: 16),

            // Kind-Info
            _buildSection(
              'Kind',
              'Name: $kindName\nGeburtsdatum: $geburtsdatum',
            ),
          ];

          // Entwicklungsbereiche
          for (final entry in bereiche.entries) {
            widgets.add(_buildSection(entry.key, entry.value));
          }

          // Zusammenfassung
          if (zusammenfassung != null && zusammenfassung.isNotEmpty) {
            widgets.add(_buildSection('Zusammenfassung', zusammenfassung));
          }

          // Footer
          widgets.addAll([
            pw.SizedBox(height: 24),
            pw.Divider(),
            pw.SizedBox(height: 8),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Datum: _______________',
                  style: const pw.TextStyle(fontSize: 10),
                ),
                pw.Text(
                  einrichtungsName,
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ],
            ),
          ]);

          return widgets;
        },
      ),
    );

    return doc.save();
  }

  // ---------------------------------------------------------------------------
  // Hilfsmethoden
  // ---------------------------------------------------------------------------

  /// Erzeugt einen Abschnitt mit fett gedrucktem Titel und Inhalt.
  static pw.Widget _buildSection(String title, String content) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          content,
          style: const pw.TextStyle(fontSize: 12),
        ),
        pw.SizedBox(height: 16),
      ],
    );
  }

  /// Erzeugt den Unterschriftenbereich mit zwei Spalten.
  ///
  /// Links: Einrichtung, Rechts: Erziehungsberechtigte/r.
  /// Falls [signatureImage] übergeben wird, wird die Unterschrift als
  /// Bild über der rechten Unterschriftslinie eingebettet.
  static pw.Widget _buildSignatureArea({Uint8List? signatureImage}) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            // Linke Spalte — Einrichtung
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(width: 1),
                      ),
                    ),
                    width: 200,
                    height: 60,
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'Einrichtung',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            // Rechte Spalte — Erziehungsberechtigte/r
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if (signatureImage != null)
                    pw.Image(
                      pw.MemoryImage(signatureImage),
                      width: 150,
                      height: 60,
                    )
                  else
                    pw.SizedBox(height: 60),
                  pw.Container(
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(width: 1),
                      ),
                    ),
                    width: 200,
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'Erziehungsberechtigte/r',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 12),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Text(
            'Datum: _______________',
            style: const pw.TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}
