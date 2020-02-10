import 'package:celery_with_me/services/live_service.dart';
import 'package:flutter/material.dart';

class DrinkJuiceNotifier with ChangeNotifier {
  DrinkJuiceNotifier({
    @required LiveService liveService,
  })  : assert(liveService != null),
        _liveService = liveService {
    // TODO: read userDrankToday from local storage
  }

  final LiveService _liveService;

  bool get userDrankToday => _userDrankToday;
  bool _userDrankToday = false;

  Future<bool> drink() async {
    final isConnected = _liveService.status == ConnectionStatus.connected;
    if (!isConnected) return false;

    await Future.delayed(Duration(seconds: 1));
    final success = _liveService.incrementTodayScore();
    if (success) {
      // TODO: store that user drank today in local storage
      _userDrankToday = true;
      notifyListeners();
    }
    return success;
  }
}
