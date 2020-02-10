import 'dart:async';

import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:celery_with_me/services/live_service.dart' as ls;

class LiveConnectionNotifier with ChangeNotifier {
  LiveConnectionNotifier({
    @required ls.LiveService liveService,
  })  : assert(liveService != null),
        _liveService = liveService {
    _liveSub = _liveService.statusStream.listen(_handleStatusChange);
    connect();
  }

  final ls.LiveService _liveService;
  StreamSubscription _liveSub;

  ConnectionStatus get status => _status;
  ConnectionStatus _status = ConnectionStatus.notConnected;

  void connect() => _liveService.connect();

  void _handleStatusChange(ls.ConnectionStatus status) {
    _status = _mapStatus(status);
    notifyListeners();
  }

  @override
  void dispose() {
    _liveSub.cancel();
    super.dispose();
  }
}

enum ConnectionStatus {
  notConnected,
  connecting,
  connected,
}

ConnectionStatus _mapStatus(ls.ConnectionStatus status) {
  switch (status) {
    case ls.ConnectionStatus.notConnected:
      return ConnectionStatus.notConnected;
    case ls.ConnectionStatus.connecting:
      return ConnectionStatus.connecting;
    case ls.ConnectionStatus.connected:
      return ConnectionStatus.connected;
    default:
      throw ArgumentError('unknown connection status: $status');
  }
}
