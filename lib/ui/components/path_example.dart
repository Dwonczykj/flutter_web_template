import 'package:flutter/material.dart';

class PathExample extends StatelessWidget {
  const PathExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PathPainter(),
    );
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = Path();
    path.moveTo(
        size.width / 2,
        size.height /
            2); // moveTo method helps us to move the starting point of the sub-path to the point provided within the method.
    path.lineTo(size.width,
        size.height); // lineTo is the method to draw a line from the current point of the path to the point provided within the method.
    canvas.drawPath(path, paint);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class PathExample2 extends StatelessWidget {
  const PathExample2({Key? key}) : super(key: key);

  CustomPainter _drawLine(BuildContext context) {
    return LinePainter();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: _drawLine(context),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final double progress;

  LinePainter({this.progress = 0.0});

  Paint _paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 4.0
    ..style = PaintingStyle.stroke
    ..strokeJoin = StrokeJoin.round;

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width * progress, size.height / 2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
