import 'package:flutter/material.dart';

import 'dart:math' as math;

class TaskCompletionWidget extends StatefulWidget {
  const TaskCompletionWidget({
    Key? key,
    required this.radius,
    this.bgColor = Colors.grey,
    this.fgColor = Colors.black,
    this.duration = const Duration(milliseconds: 500),
    required this.fgchild,
    required this.bgchild,
  }) : super(key: key);

  final double radius;
  final Duration duration;
  final Color bgColor;
  final Color fgColor;
  final Widget fgchild;
  final Widget bgchild;

  @override
  State<TaskCompletionWidget> createState() => _TaskCompletionWidgetState();
}

class _TaskCompletionWidgetState extends State<TaskCompletionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 2 * widget.radius,
      height: 2 * widget.radius,
      child: GestureDetector(
        onTap: () => _controller.forward(),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              painter: TaskPainter(
                  bgColor: widget.bgColor,
                  fgColor: widget.fgColor,
                  animation: _controller.value),
              child: (_controller.isCompleted)
                  ? widget.fgchild
                  : Transform.scale(
                      scale: _controller.value * .3 + 1,
                      child: widget.bgchild,
                    ),
            );
          },
        ),
      ),
    );
  }
}

class TaskPainter extends CustomPainter {
  final Color bgColor;
  final Color fgColor;
  final double animation;
  const TaskPainter(
      {required this.animation, required this.bgColor, required this.fgColor});

  @override
  void paint(Canvas canvas, Size size) {
    Color backgroundColor = bgColor;
    Color foregroundColor = fgColor;
    double radius = size.width / 2.0;
    double stokeWidth = size.width * .08;

    Paint backgroundpaint = Paint()
      ..color = backgroundColor
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = stokeWidth;
    Paint foregroundpaint = Paint()
      ..color = foregroundColor
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = stokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(
        Offset(radius, radius), radius, Paint()..color = bgColor.withAlpha(50));
    canvas.drawCircle(Offset(radius, radius), radius, backgroundpaint);

    canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        -math.pi / 2,
        (2 * math.pi * animation),
        false,
        foregroundpaint);
  }

  @override
  bool shouldRepaint(covariant TaskPainter oldDelegate) =>
      oldDelegate.animation != animation;
}
