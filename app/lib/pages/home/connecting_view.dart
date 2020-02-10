import 'package:flutter/material.dart';

class ConnectingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ),
    );
  }
}
