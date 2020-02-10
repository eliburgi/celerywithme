import 'dart:async';

import 'package:flutter/material.dart';

class PopAnimation extends StatefulWidget {
  PopAnimation({
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 2000),
    this.curve = Curves.elasticOut,
    @required this.child,
  });

  final Duration delay;
  final Duration duration;
  final Curve curve;
  final Widget child;

  @override
  _PopAnimationState createState() => _PopAnimationState();
}

class _PopAnimationState extends State<PopAnimation>
    with SingleTickerProviderStateMixin {
  Timer _timer;
  AnimationController _animContr;
  Animation<double> _scaleAnim;
  Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();

    _animContr = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _scaleAnim = _buildScaleAnimation();
    _opacityAnim = _buildOpacityAnimation();

    _timer = Timer(widget.delay, () {
      _animContr.forward(from: 0.0);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animContr.dispose();
    super.dispose();
  }

  Animation<double> _buildScaleAnimation() =>
      Tween<double>(begin: 0.0, end: 1.0).animate(
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
      animation: _scaleAnim,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnim.value < 0.0 ? 0.0 : _scaleAnim.value,
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
