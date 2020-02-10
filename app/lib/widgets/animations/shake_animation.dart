import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ShakeAnimation extends StatefulWidget {
  ShakeAnimation({
    this.periodic = true,
    this.initialDelay = Duration.zero,
    this.delayBetweenPeriods = const Duration(milliseconds: 2000),
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.elasticInOut,
    this.shakeAngle = pi / 12.0,
    @required this.child,
  });

  final bool periodic;
  final Duration initialDelay;
  final Duration delayBetweenPeriods;
  final Duration duration;
  final Curve curve;
  final double shakeAngle;
  final Widget child;

  @override
  _ShakeAnimationState createState() => _ShakeAnimationState();
}

class _ShakeAnimationState extends State<ShakeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _animContr;
  Animation<double> _rotAnim;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _animContr = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    if (widget.periodic) {
      _animContr.addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          await Future.delayed(widget.delayBetweenPeriods);
          _animContr?.forward(from: 0.0);
        }
      });
    }
    _rotAnim = _buildRotationAnimation();

    _timer = Timer(widget.initialDelay, () {
      _animContr.forward(from: 0.0);
    });
  }

  @override
  void dispose() {
    _animContr.dispose();
    _animContr = null;
    _timer.cancel();
    super.dispose();
  }

  Animation<double> _buildRotationAnimation() {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        curve: widget.curve,
        parent: _animContr,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotAnim,
      builder: (context, child) {
        final angle = sin(_rotAnim.value * 2 * pi) * widget.shakeAngle;
        return Transform.rotate(
          angle: angle,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}