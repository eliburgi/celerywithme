import 'package:celery_with_me/theme.dart';
import 'package:celery_with_me/widgets/animations/pop_animation.dart';
import 'package:celery_with_me/widgets/icons/celery_icon.dart';
import 'package:celery_with_me/widgets/margin.dart';
import 'package:flutter/material.dart';

class CeleryAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: preferredSize.height,
        color: CeleryWithMeTheme.primaryColor,
        child: Center(
          child: PopAnimation(
            delay: const Duration(milliseconds: 500),
            duration: const Duration(seconds: 2),
            curve: Curves.decelerate,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CeleryIcon(),
                Margin.horizontal(12.0),
                Text(
                  'Celery With Me',
                  style: CeleryWithMeTheme.appLogoTextStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
