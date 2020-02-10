import 'dart:async';
import 'package:celery_with_me/data/drink_scores.dart';

abstract class LiveService {
  /// Emits everytime the status of the connection to the server changes.
  ///
  /// Initially emits [ConnectionStatus.notConnected].
  Stream<ConnectionStatus> get statusStream;

  /// The latest value of [statusStream].
  ConnectionStatus get status;

  /// Emits everytime the server sent updated drink scores data.
  Stream<DrinkScores> get drinkScoresStream;

  /// Whether [dispose()] has been called.
  bool get isDisposed;

  /// Connects the client to the server.
  ///
  /// While the client tries to connect [statusStream] will emit
  /// [ConnectionStatus.connecting].
  /// If successful, [statusStream] will emit [ConnectionStatus.connected] and
  /// the exposed data streams will emit real-time data from the server.
  /// Otherwise, the [statusStream] will emit [ConnectionStatus.notConnected].
  ///
  /// Nothing will happen, if the client is already connecting or connected
  /// to the server.
  ///
  /// Throws [AlreadyDisposedError] if the client has already been disposed.
  void connect();

  /// Tells the server to increment today´s drink score.
  ///
  /// Returns [true] if [status == ConnectionStatus.connected] and the message
  /// could be sent to the server. Otherwise [false] is returned.
  ///
  /// Throws [AlreadyDisposedError] if the client has already been disposed.
  bool incrementTodayScore();

  /// Disconnects from the server and closes all exposed streams.
  ///
  /// After calling [dispose()], this client object can no longer be used.
  ///
  /// Throws [AlreadyDisposedError] if the client has already been disposed.
  void dispose();
}

enum ConnectionStatus {
  notConnected,
  connecting,
  connected,
}

class AlreadyDisposedError extends Error {}
