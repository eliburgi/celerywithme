import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:celery_with_me/theme.dart';
import 'package:celery_with_me/widgets/celery_app_bar.dart';
import 'package:celery_with_me/notifiers/live_connection.dart';

import 'connected_view.dart';
import 'connecting_view.dart';
import 'not_connected_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CeleryWithMeTheme.primaryColor,
      appBar: CeleryAppBar(),
      body: Consumer<LiveConnectionNotifier>(
        builder: (_, liveConnection, child) {
          switch (liveConnection.status) {
            case ConnectionStatus.notConnected:
              return NotConnectedView();
            case ConnectionStatus.connecting:
              return ConnectingView();
            case ConnectionStatus.connected:
              return ConnectedView();
            default:
              return Text('ERROR: invalid connection status!');
          }
        },
      ),
    );
  }
}
