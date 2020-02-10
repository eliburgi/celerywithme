import 'dart:async';
import 'dart:convert';

import 'package:celery_with_me/data/drink_scores.dart';
import 'package:celery_with_me/services/live_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:meta/meta.dart';

const _kServerUrl = 'ws://10.0.0.4:8080';
const _kConnectionTimeout = Duration(seconds: 7);

class WebSocketLiveService extends LiveService {
  @override
  Stream<ConnectionStatus> get statusStream => _statusSubj.stream;

  @override
  ConnectionStatus get status => _statusSubj.value;

  final _statusSubj = BehaviorSubject.seeded(ConnectionStatus.notConnected);

  @override
  Stream<DrinkScores> get drinkScoresStream => _scoresSubj.stream;

  final _scoresSubj = BehaviorSubject<DrinkScores>();

  @override
  bool get isDisposed => _statusSubj.isClosed;

  IOWebSocketChannel _serverChannel;
  StreamSubscription _serverChannelSub;

  @override
  void connect() async {
    if (isDisposed) {
      throw AlreadyDisposedError();
    }
    if (status != ConnectionStatus.notConnected) {
      return;
    }

    // check if the client is connected after a few seconds
    // otherwise timeout
    Timer(_kConnectionTimeout, _checkConnectionTimeout);

    // service is now starting to connect to the server
    _statusSubj.add(ConnectionStatus.connecting);

    _serverChannel = IOWebSocketChannel.connect(_kServerUrl);
    _serverChannelSub = _serverChannel.stream.listen(
      _handleServerData,
      onError: _handleConnectionError,
      onDone: _handleConnectionClosed,
    );
  }

  @override
  bool incrementTodayScore() {
    if (isDisposed) {
      throw AlreadyDisposedError();
    }
    if (status != ConnectionStatus.connected) {
      return false;
    }

    final msg = _Message(event: _Event.incrementTodayScore);
    String msgStr = _Message.toJsonString(msg);
    _serverChannel.sink.add(msgStr);
    return true;
  }

  @override
  void dispose() {
    if (isDisposed) {
      throw AlreadyDisposedError();
    }

    _serverChannelSub?.cancel();
    _serverChannel?.sink?.close();

    _statusSubj.close();
    _scoresSubj.close();
  }

  void _handleServerData(dynamic data) {
    if (status != ConnectionStatus.connected) {
      _statusSubj.add(ConnectionStatus.connected);
    }

    if (data == null) return;

    String msgStr = data.toString();
    final msg = _Message.parse(msgStr);
    switch (msg.event) {
      case _Event.scoresUpdated:
        _handleScoresUpdatedMsg(msg);
        break;
      case _Event.todayScoreUpdated:
        _handleTodayScoreUpdatedMsg(msg);
        break;
      default:
        // ignore the message
        break;
    }
    // TODO: remove
    print('Client channel message received: $msgStr');
  }

  void _handleConnectionError(error) {
    // TODO: remove
    print('[ERROR-Client]: $error');
  }

  void _handleConnectionClosed() {
    if (status != ConnectionStatus.notConnected) {
      _statusSubj.add(ConnectionStatus.notConnected);
    }
    // TODO: remove
    print('Client channel closed!');
  }

  void _handleScoresUpdatedMsg(_Message msg) {
    final int todayScore = msg.data['todayScore'] ?? -1;
    final int yesterdayScore = msg.data['yesterdayScore'] ?? -1;
    final int highScore = msg.data['highScore'] ?? -1;

    final drinkScores = DrinkScores(
      todayScore: todayScore,
      yesterdayScore: yesterdayScore,
      highScore: highScore,
    );
    _scoresSubj.add(drinkScores);
  }

  void _handleTodayScoreUpdatedMsg(_Message msg) {
    final int todayScore = msg.data['todayScore'] ?? -1;

    final latestScores = _scoresSubj.value ?? const DrinkScores();
    final updatedScores = latestScores.copyWith(todayScore: todayScore);
    _scoresSubj.add(updatedScores);
  }

  void _checkConnectionTimeout() {
    if (status != ConnectionStatus.connected) {
      _statusSubj.add(ConnectionStatus.notConnected);

      // close the exisiting connection
      _serverChannelSub?.cancel();
      _serverChannel?.sink?.close();
    }
  }
}

class _Message {
  static _Message parse(String jsonStr) {
    try {
      final msgJson = jsonDecode(jsonStr);
      return _Message.fromJson(msgJson);
    } catch (err) {
      return const _Message(event: _Event.ignore);
    }
  }

  static String toJsonString(_Message msg) {
    final json = msg.toJson();
    try {
      return jsonEncode(json);
    } catch (err) {
      return null;
    }
  }

  const _Message({
    @required this.event,
    this.data = const {},
  })  : assert(event != null),
        assert(data != null);

  _Message.fromJson(Map<String, dynamic> json)
      : this(
          event: _mapIntToEvent(json['event']),
          data: json['data'] ?? const {},
        );

  Map<String, dynamic> toJson() => {
        'event': _mapEventToInt(event),
        'data': data,
      };

  final _Event event;
  final Map<String, dynamic> data;
}

enum _Event {
  // used to mark faulty messages which should not be processed
  ignore,

  // messages sent from server to client
  scoresUpdated,
  todayScoreUpdated,

  // messages sent from client to server
  incrementTodayScore,
}

int _mapEventToInt(_Event event) {
  switch (event) {
    case _Event.scoresUpdated:
      return 0;
    case _Event.todayScoreUpdated:
      return 1;
    case _Event.incrementTodayScore:
      return 2;
    default:
      return -1;
  }
}

_Event _mapIntToEvent(int eventCode) {
  switch (eventCode) {
    case 0:
      return _Event.scoresUpdated;
    case 1:
      return _Event.todayScoreUpdated;
    case 2:
      return _Event.incrementTodayScore;
    default:
      return _Event.ignore;
  }
}
