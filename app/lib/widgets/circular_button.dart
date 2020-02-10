import 'package:celery_with_me/theme.dart';
import 'package:celery_with_me/widgets/margin.dart';
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  CircularButton({
    this.title,
    @required this.child,
    this.radius = 128.0,
    @required this.onTap,
  });

  final String title;
  final Widget child;
  final double radius;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = CeleryWithMeTheme.primaryColorDark;

    return RawMaterialButton(
      shape: CircleBorder(),
      constraints: BoxConstraints.tightFor(
        width: radius,
        height: radius,
      ),
      fillColor: color,
      highlightColor: color,
      splashColor: Colors.black.withOpacity(0.05),
      elevation: 0.0,
      highlightElevation: 0.0,
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          child,
          if (title != null) ...[
            Margin.vertical(8.0),
            Text(
              title,
              style: CeleryWithMeTheme.titleTextStyle,
            ),
          ]
        ],
      ),
    );
  }
}
