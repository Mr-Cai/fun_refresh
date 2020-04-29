import 'package:flutter/rendering.dart';

class BezierClipper extends CustomClipper<Path> {
  BezierClipper(this.curveMargin);

  final double curveMargin;

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(-curveMargin, size.height);
    var start = Offset(size.width / 2, size.height - curveMargin);
    var end = Offset(size.width, size.height);
    path.quadraticBezierTo(start.dx, start.dy, end.dx + curveMargin, end.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class CornerClipper extends CustomClipper<RRect> {
  @override
  RRect getClip(Size size) => RRect.fromLTRBAndCorners(
        32.0,
        32.0,
        32.0,
        32.0,
        topLeft: Radius.circular(32.0)
      );

  @override
  bool shouldReclip(CustomClipper<RRect> oldClipper) => true;
}
