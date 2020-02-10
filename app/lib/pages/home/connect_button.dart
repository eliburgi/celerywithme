import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:celery_with_me/theme.dart';
import 'package:celery_with_me/widgets/circular_button.dart';
import 'package:celery_with_me/notifiers/live_connection.dart';

class ConnectButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final liveConnection =
        Provider.of<LiveConnectionNotifier>(context, listen: false);
    return CircularButton(
      radius: 100.0,
      child: Icon(
        Icons.refresh,
        size: 32.0,
        color: CeleryWithMeTheme.primaryIconColor,
      ),
      onTap: liveConnection.connect,
    );
  }
}
