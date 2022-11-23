import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TicketPainter extends CustomPainter {
  final Color borderColor;
  final Color bgColor;

  TicketPainter({
    required this.bgColor,
    required this.borderColor,
  });
  static const _cornerGap = 20.0;
  static const _cutoutRadius = 10.0;
  static const _cutoutDiameter = _cutoutRadius * 2;
  // _drawCutout(path, maxWidth, rightCutoutStartY1-(_cutoutDiameter*2.25));
  @override
  void paint(Canvas canvas, Size size) {
    final maxWidth = size.width;
    final maxHeight = size.height;
    final cutoutStartPos = maxHeight - maxHeight * 0.12;
    final leftCutoutStartY = cutoutStartPos/4;
    final rightCutoutStartY = cutoutStartPos/4 - _cutoutDiameter;
    final dottedLineY = cutoutStartPos/4 - _cutoutRadius;
    final leftCutoutStartY1 = cutoutStartPos/1.8;
    final rightCutoutStartY1 = cutoutStartPos/1.8 - _cutoutDiameter;
    final dottedLineY1 = cutoutStartPos/1.8 - _cutoutRadius;
    final leftCutoutStartY2 = cutoutStartPos/1.35;
    final rightCutoutStartY2 = cutoutStartPos/1.35 - _cutoutDiameter;
    final dottedLineY2 = cutoutStartPos/1.35 - _cutoutRadius;
    final leftCutoutStartY3 = cutoutStartPos;
    final rightCutoutStartY3 = cutoutStartPos - _cutoutDiameter;
    final dottedLineY3 = cutoutStartPos - _cutoutRadius;
    double dottedLineStartX = _cutoutRadius;
    final double dottedLineEndX = maxWidth - _cutoutRadius;
    const double dashWidth = 10;
    const double dashSpace = 4;

    final paintBg = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..color = bgColor;

    final paintBorder = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = borderColor;

    final paintDottedLine = Paint()
      ..color = AppColors.grayC4C$C$
      ..strokeWidth = 1;

    var path = Path();
    path.moveTo(_cornerGap, 0);
    path.lineTo(maxWidth - _cornerGap, 0);
    _drawCornerArc(path, maxWidth, _cornerGap);
    path.lineTo(maxWidth, rightCutoutStartY);
    _drawCutout(path, maxWidth, rightCutoutStartY + _cutoutDiameter);
    path.lineTo(maxWidth, rightCutoutStartY1);
    _drawCutout(path, maxWidth, rightCutoutStartY1 + _cutoutDiameter);
    path.lineTo(maxWidth, rightCutoutStartY2);
    _drawCutout(path, maxWidth, rightCutoutStartY2 + _cutoutDiameter);
    path.lineTo(maxWidth, rightCutoutStartY3);
    _drawCutout(path, maxWidth, rightCutoutStartY3 + _cutoutDiameter);
    path.lineTo(maxWidth, maxHeight - _cornerGap);
    _drawCornerArc(path, maxWidth - _cornerGap, maxHeight);
    path.lineTo(_cornerGap, maxHeight);
    _drawCornerArc(path, 0, maxHeight - _cornerGap);
    path.lineTo(0, leftCutoutStartY3);
    _drawCutout(path, 0.0, leftCutoutStartY3 - _cutoutDiameter);
    path.lineTo(0, leftCutoutStartY2);
    _drawCutout(path, 0.0, leftCutoutStartY2 - _cutoutDiameter);
    path.lineTo(0, leftCutoutStartY1);
    _drawCutout(path, 0.0, leftCutoutStartY1 - _cutoutDiameter);
    path.lineTo(0, leftCutoutStartY);
    _drawCutout(path, 0.0, leftCutoutStartY - _cutoutDiameter);
    path.lineTo(0, _cornerGap);
    _drawCornerArc(path, _cornerGap, 0);

    canvas.drawShadow(path, Colors.black45, 3.0, false);
    canvas.drawPath(path, paintBg);
    canvas.drawPath(path, paintBorder);

    Path path2= Path();
    while (dottedLineStartX+40 < dottedLineEndX) {
      // path2.moveTo(_cornerGap, 0);
      // path2.quadraticBezierTo(dottedLineStartX, dottedLineY, dottedLineStartX + dashWidth, dottedLineY);
      canvas.drawLine(
        Offset(dottedLineStartX+25, dottedLineY),
        Offset(dottedLineStartX + dashWidth+10, dottedLineY),
        paintDottedLine,
      );
      canvas.drawLine(
        Offset(dottedLineStartX+25, dottedLineY1),
        Offset(dottedLineStartX + dashWidth+10, dottedLineY1),
        paintDottedLine,
      );
      canvas.drawLine(
        Offset(dottedLineStartX+25, dottedLineY2),
        Offset(dottedLineStartX + dashWidth+10, dottedLineY2),
        paintDottedLine,
      );
      canvas.drawLine(
        Offset(dottedLineStartX+25, dottedLineY3),
        Offset(dottedLineStartX + dashWidth+10, dottedLineY3),
        paintDottedLine,
      );
      dottedLineStartX += dashWidth + dashSpace;
    }
    canvas.drawPath(path2, paintDottedLine);
  }
  _drawCutout(Path path, double startX, double endY) {
    path.arcToPoint(
      Offset(startX, endY),
      radius: const Radius.circular(_cutoutRadius),
      clockwise: false,
    );
  }

  _drawCornerArc(Path path, double endPointX, double endPointY) {
    path.arcToPoint(
      Offset(endPointX, endPointY),
      radius: const Radius.circular(_cornerGap),
    );
  }
  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(TicketPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(TicketPainter oldDelegate) => false;
}
