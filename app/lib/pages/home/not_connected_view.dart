import 'package:flutter/material.dart';

import 'package:celery_with_me/theme.dart';
import 'package:celery_with_me/widgets/icons/animated_glasses_icon.dart';
import 'package:celery_with_me/pages/home/connect_button.dart';
import 'package:celery_with_me/widgets/margin.dart';

class NotConnectedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedGlassesIcon(),
                Margin.vertical(24.0),
                Text(
                  'woops ...',
                  style: CeleryWithMeTheme.headingTextStyle,
                  textAlign: TextAlign.center,
                ),
                Margin.vertical(16.0),
                Text(
                  '... looks like many people are online.\n'
                  'Check your internet connection and try again.',
                  style: CeleryWithMeTheme.bodyTextStyle.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          ConnectButton(),
        ],
      ),
    );
  }
}
