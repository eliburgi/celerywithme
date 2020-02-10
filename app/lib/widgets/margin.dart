import 'package:flutter/material.dart';

class Margin extends StatelessWidget {
  const Margin.horizontal(this.horizontal) : vertical = 0;
  const Margin.vertical(this.vertical) : horizontal = 0;

  final double horizontal;
  final double vertical;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: horizontal,
      height: vertical,
    );
  }
}
