import 'package:celery_with_me/data/drink_scores.dart';
import 'package:celery_with_me/services/live_service.dart';
import 'package:rxdart/rxdart.dart';

const _kInitialScores = DrinkScores(
  todayScore: 51200,
  yesterdayScore: 12112,
  highScore: 125289,
);

class MockedLiveService extends LiveService {
  @override
  Stream<ConnectionStatus> get statusStream => _statusSubj.stream;
  final _statusSubj = BehaviorSubject.seeded(ConnectionStatus.notConnected);

  @override
  ConnectionStatus get status => _statusSubj.value;

  @override
  Stream<DrinkScores> get drinkScoresStream => _scoresSubj.stream;
  final _scoresSubj = BehaviorSubject<DrinkScores>();

  @override
  bool get isDisposed => _statusSubj.isClosed;

  @override
  void connect() {
    if (isDisposed) {
      throw AlreadyDisposedError();
    }
    if (status != ConnectionStatus.notConnected) return;

    _statusSubj.add(ConnectionStatus.connecting);
    Future.delayed(Duration(seconds: 1), () {
      _statusSubj.add(ConnectionStatus.connected);
      _scoresSubj.add(_kInitialScores);
    });
  }

  @override
  bool incrementTodayScore() {
    if (isDisposed) {
      throw AlreadyDisposedError();
    }
    if (status != ConnectionStatus.connected) return false;
    if (!_scoresSubj.hasValue) return false;

    final scores = _scoresSubj.value;
    final newScores = scores.copyWith(todayScore: scores.todayScore + 1);
    _scoresSubj.add(newScores);
    return true;
  }

  @override
  void dispose() {
    if (isDisposed) {
      throw AlreadyDisposedError();
    }

    _statusSubj.close();
    _scoresSubj.close();
  }
}
