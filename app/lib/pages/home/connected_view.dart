import 'package:celery_with_me/pages/home/drink_button.dart';
import 'package:flutter/material.dart';
import 'package:celery_with_me/pages/home/live_scores_ticker.dart';

class ConnectedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: LiveScoresTicker(),
            ),
          ),
          DrinkButton(),
        ],
      ),
    );
  }
}
