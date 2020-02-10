import 'package:flutter/material.dart';

class BinaryWidgetMultiplexer extends StatefulWidget {
  BinaryWidgetMultiplexer({
    @required this.builder0,
    @required this.builder1,
    this.showWidget0 = true,
    @required this.duration,
    @required this.curve,
  });

  final AnimatedBuilder builder0;
  final AnimatedBuilder builder1;
  final bool showWidget0;

  final Duration duration;
  final Curve curve;

  @override
  _BinaryWidgetMultiplexerState createState() =>
      _BinaryWidgetMultiplexerState();
}

class _BinaryWidgetMultiplexerState extends State<BinaryWidgetMultiplexer>
    with SingleTickerProviderStateMixin {
  AnimationController _animContr;
  Animation<double> _anim;

  @override
  void initState() {
    super.initState();

    _animContr = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _anim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animContr,
        curve: widget.curve,
      ),
    );

    _animContr.forward();
  }

  @override
  void didUpdateWidget(BinaryWidgetMultiplexer oldWidget) {
    super.didUpdateWidget(oldWidget);

    final prevShowWidget0 = oldWidget.showWidget0;
    if (prevShowWidget0 && !widget.showWidget0) {
      // first animate widget 0 out
      // then animate widget 1 in
    } else if (!prevShowWidget0 && widget.showWidget0) {
      // first animate widget 1 out
      // then animate widget 0 in
    }
  }

  @override
  void dispose() {
    _animContr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
