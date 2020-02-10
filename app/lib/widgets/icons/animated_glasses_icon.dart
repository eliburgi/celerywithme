import 'dart:math';

import 'package:celery_with_me/theme.dart';
import 'package:celery_with_me/widgets/animations/pop_animation.dart';
import 'package:celery_with_me/widgets/animations/rotate_animation.dart';
import 'package:celery_with_me/widgets/icons/glas_icon.dart';
import 'package:flutter/material.dart';

// animate show/hide
// animate also a single tick (e.g. when score updates)

class AnimatedGlassesIcon extends StatefulWidget {
  @override
  _AnimatedGlassesIconState createState() => _AnimatedGlassesIconState();
}

class _AnimatedGlassesIconState extends State<AnimatedGlassesIcon> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        RotateAnimation(
          initialDelay: const Duration(milliseconds: 1000),
          duration: const Duration(milliseconds: 1500),
          fromAngle: 0.0,
          toAngle: -pi / 5.0,
          child: FilledGlasIcon.large(),
        ),
        RotateAnimation(
          initialDelay: const Duration(milliseconds: 1000),
          duration: const Duration(milliseconds: 1500),
          fromAngle: 0.0,
          toAngle: pi / 5.0,
          child: FilledGlasIcon.large(),
        ),
        PopAnimation(
          duration: const Duration(milliseconds: 1500),
          child: FilledGlasIcon.large(),
        ),
      ],
    );
  }
}
