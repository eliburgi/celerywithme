import 'dart:async';

import 'package:flutter/material.dart';

class LiveStreamNotifier<T> with ChangeNotifier {
  LiveStreamNotifier({
    @required Stream stream,
  }) : assert(stream != null) {
    _streamSub = stream.listen(_handleData);
  }

  StreamSubscription _streamSub;

  T get latestData => _latestData;
  T _latestData;

  bool get hasData => _latestData != null;

  void _handleData(T data) {
    _latestData = data;
    notifyListeners();
  }

  @override
  void dispose() {
    _streamSub.cancel();
    super.dispose();
  }
}
