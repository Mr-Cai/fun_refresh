import 'package:flutter/rendering.dart';

class BTMCurve extends CustomClipper<Path> {
  BTMCurve(this.curveMargin);
  final double curveMargin;
  @override
  getClip(size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    var start = Offset(size.width / 2, size.height - curveMargin);
    var end = Offset(size.width, size.height);
    path.quadraticBezierTo(start.dx, start.dy, end.dx, end.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  shouldReclip(oldClipper) => false;
}

class TopCurve extends CustomClipper<Path> {
  TopCurve(this.curveMargin);
  final double curveMargin;
  @override
  getClip(size) {
    var path = Path();
    path.lineTo(0.0, 0.0);
    var start = Offset(size.width / 2, size.height - curveMargin);
    var end = Offset(size.width, size.height);
    path.quadraticBezierTo(start.dx, start.dy, end.dx, end.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  shouldReclip(oldClipper) => false;
}
