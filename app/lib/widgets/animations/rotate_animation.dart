import 'dart:async';

import 'package:flutter/material.dart';

class RotateAnimation extends StatefulWidget {
  RotateAnimation({
    this.initialDelay = Duration.zero,
    this.duration = const Duration(milliseconds: 2000),
    this.curve = Curves.elasticOut,
    @required this.fromAngle,
    @required this.toAngle,
    @required this.child,
  });

  final Duration initialDelay;
  final Duration duration;
  final Curve curve;
  final double fromAngle;
  final double toAngle;
  final Widget child;

  @override
  _RotateAnimationState createState() => _RotateAnimationState();
}

class _RotateAnimationState extends State<RotateAnimation>
    with SingleTickerProviderStateMixin {
  Timer _timer;
  AnimationController _animContr;
  Animation<double> _rotateAnim;
  Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();

    _animContr = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _rotateAnim = _buildRotateAnimation();
    _opacityAnim = _buildOpacityAnimation();

    _timer = Timer(widget.initialDelay, () {
      _animContr.forward(from: 0.0);
    });
  }

  @override
  void dispose() {
    _animContr.dispose();
    _timer.cancel();
    super.dispose();
  }

  Animation<double> _buildRotateAnimation() =>
      Tween<double>(begin: widget.fromAngle, end: widget.toAngle).animate(
        CurvedAnimation(
          curve: widget.curve,
          parent: _animContr,
        ),
      );

  Animation<double> _buildOpacityAnimation() =>
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          curve: widget.curve,
          parent: _animContr,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotateAnim,
      builder: (context, child) => Transform.rotate(
        angle: _rotateAnim.value,
        alignment: Alignment.bottomCenter,
        child: Opacity(
          opacity: _opacityAnim.value < 0.0
              ? 0.0
              : (_opacityAnim.value > 1.0 ? 1.0 : _opacityAnim.value),
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}
