import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/theme/app_colors.dart';

/// Signatur-Eingabefeld basierend auf CustomPainter.
/// Keine externen Pakete nötig — zeichnet Striche per Touch/Maus.
class SignaturePad extends StatefulWidget {
  const SignaturePad({
    super.key,
    this.height = 200.0,
    this.strokeColor,
    this.strokeWidth = 2.5,
    this.backgroundColor,
  });

  /// Höhe des Zeichenbereichs.
  final double height;

  /// Strichfarbe (Standard: textPrimary).
  final Color? strokeColor;

  /// Strichbreite in logischen Pixeln.
  final double strokeWidth;

  /// Hintergrundfarbe (Standard: surface).
  final Color? backgroundColor;

  @override
  State<SignaturePad> createState() => SignaturePadState();
}

/// Öffentlicher State, damit der Screen per GlobalKey darauf zugreifen kann.
class SignaturePadState extends State<SignaturePad> {
  final _boundaryKey = GlobalKey();

  List<List<Offset>> _strokes = [];
  List<Offset> _currentStroke = [];

  /// Gibt `true` zurück, wenn noch keine Unterschrift vorhanden ist.
  bool get isEmpty => _strokes.isEmpty && _currentStroke.isEmpty;

  /// Löscht alle Striche.
  void clear() {
    setState(() {
      _strokes = [];
      _currentStroke = [];
    });
  }

  /// Exportiert die aktuelle Unterschrift als PNG-Bytes.
  ///
  /// Gibt `null` zurück, falls das RenderObject nicht verfügbar ist.
  Future<Uint8List?> toImage({double pixelRatio = 3.0}) async {
    final boundary = _boundaryKey.currentContext?.findRenderObject()
        as RenderRepaintBoundary?;
    if (boundary == null) return null;

    final image = await boundary.toImage(pixelRatio: pixelRatio);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return null;

    return byteData.buffer.asUint8List();
  }

  // ---------------------------------------------------------------------------
  // Gesture-Handler
  // ---------------------------------------------------------------------------

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _currentStroke = [details.localPosition];
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _currentStroke = [..._currentStroke, details.localPosition];
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      if (_currentStroke.isNotEmpty) {
        _strokes = [..._strokes, _currentStroke];
      }
      _currentStroke = [];
    });
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.backgroundColor ?? AppColors.surface;
    final fgColor = widget.strokeColor ?? AppColors.textPrimary;

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        color: bgColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        child: Stack(
          children: [
            // Zeichenfläche — innerhalb RepaintBoundary für Export.
            RepaintBoundary(
              key: _boundaryKey,
              child: CustomPaint(
                size: Size(double.infinity, widget.height),
                painter: _SignaturePainter(
                  strokes: _strokes,
                  currentStroke: _currentStroke,
                  color: fgColor,
                  strokeWidth: widget.strokeWidth,
                  backgroundColor: bgColor,
                ),
              ),
            ),

            // Hinweistext — außerhalb der Boundary, erscheint nicht im Export.
            if (isEmpty)
              Center(
                child: Text(
                  'Hier unterschreiben',
                  style: TextStyle(
                    color: AppColors.textHint,
                    fontSize: DesignTokens.fontMd,
                  ),
                ),
              ),

            // Gesture-Layer über allem.
            GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: double.infinity,
                height: widget.height,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// CustomPainter
// -----------------------------------------------------------------------------

class _SignaturePainter extends CustomPainter {
  _SignaturePainter({
    required this.strokes,
    required this.currentStroke,
    required this.color,
    required this.strokeWidth,
    required this.backgroundColor,
  });

  final List<List<Offset>> strokes;
  final List<Offset> currentStroke;
  final Color color;
  final double strokeWidth;
  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    // Hintergrund zeichnen (wird mit exportiert).
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = backgroundColor,
    );

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (final stroke in strokes) {
      _drawStroke(canvas, stroke, paint);
    }
    _drawStroke(canvas, currentStroke, paint);
  }

  void _drawStroke(Canvas canvas, List<Offset> points, Paint paint) {
    if (points.length < 2) return;
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SignaturePainter oldDelegate) => true;
}
