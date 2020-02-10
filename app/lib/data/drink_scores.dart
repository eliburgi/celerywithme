import 'package:equatable/equatable.dart';

class DrinkScores extends Equatable {
  const DrinkScores({
    this.todayScore = 0,
    this.yesterdayScore = 0,
    this.highScore = 0,
  })  : assert(todayScore != null),
        assert(yesterdayScore != null),
        assert(highScore != null);

  final int todayScore;
  final int yesterdayScore;
  final int highScore;

  DrinkScores copyWith({int todayScore}) => DrinkScores(
        todayScore: todayScore ?? this.todayScore,
        yesterdayScore: this.yesterdayScore,
        highScore: this.highScore,
      );

  @override
  List<Object> get props => [
        todayScore,
        yesterdayScore,
        highScore,
      ];
}
