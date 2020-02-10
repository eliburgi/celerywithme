import 'package:celery_with_me/data/drink_scores.dart';
import 'package:celery_with_me/notifiers/live_stream.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:celery_with_me/theme.dart';
import 'package:celery_with_me/widgets/icons/animated_glasses_icon.dart';
import 'package:celery_with_me/widgets/margin.dart';

class LiveScoresTicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LiveStreamNotifier<DrinkScores>>(
      builder: (_, liveStream, child) {
        if (!liveStream.hasData) {
          return SizedBox.shrink();
        }

        DrinkScores scores = liveStream.latestData;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AnimatedGlassesIcon(),
            Margin.vertical(24.0),
            AnimatedScoreText(
              score: scores.todayScore,
              style: CeleryWithMeTheme.headingTextStyle,
            ),
            Margin.vertical(12.0),
            Text(
              '... people drank celery juice today.',
              style: CeleryWithMeTheme.bodyTextStyle,
            ),
            Margin.vertical(24.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildScoreColumnSmall('Yesterday', scores.yesterdayScore),
                Margin.horizontal(32.0),
                _buildScoreColumnSmall('Highscore', scores.highScore),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildScoreColumnSmall(String caption, int score) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          caption,
          style: CeleryWithMeTheme.captionTextStyle,
        ),
        Margin.vertical(8.0),
        AnimatedScoreText(
          score: score,
          style: CeleryWithMeTheme.bodyTextStyle,
        )
      ],
    );
  }
}

class AnimatedScoreText extends StatefulWidget {
  AnimatedScoreText({
    @required this.score,
    @required this.style,
    this.duration = const Duration(seconds: 1),
    this.curve = Curves.easeOut,
  })  : assert(score != null),
        assert(style != null);

  final int score;
  final TextStyle style;
  final Duration duration;
  final Curve curve;

  @override
  _AnimatedScoreTextState createState() {
    return _AnimatedScoreTextState();
  }
}

class _AnimatedScoreTextState extends State<AnimatedScoreText>
    with SingleTickerProviderStateMixin {
  AnimationController _animContr;
  Animation<double> _anim;
  IntTween _scoreTween;

  @override
  void initState() {
    super.initState();

    _animContr = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animContr.addListener(() => setState(() {}));

    _anim = CurvedAnimation(
      parent: _animContr,
      curve: widget.curve,
    );

    _scoreTween = IntTween(begin: 0, end: widget.score);
    _animContr.forward();
  }

  @override
  void didUpdateWidget(AnimatedScoreText oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldScore = oldWidget.score;
    if (oldScore != widget.score) {
      _scoreTween = IntTween(begin: oldScore, end: widget.score);
      _animContr.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animContr.dispose();
    super.dispose();
  }

  String _formatScore(int score) {
    String scoreStr = score.toString();
    if (scoreStr.length <= 3) return scoreStr;

    String formattedScore = '';
    int digits = 0;
    for (int i = scoreStr.length - 1; i >= 0; i--) {
      if (digits == 3) {
        formattedScore = '.$formattedScore';
        digits = 0;
      }
      formattedScore = '${scoreStr[i]}$formattedScore';
      digits++;
    }
    return formattedScore;
  }

  @override
  Widget build(BuildContext context) {
    int score = _scoreTween.evaluate(_anim);
    String formattedScore = _formatScore(score);
    return Text(
      formattedScore,
      style: widget.style,
    );
  }
}
