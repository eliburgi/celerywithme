import 'package:celery_with_me/notifiers/drink_juice.dart';
import 'package:celery_with_me/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:celery_with_me/widgets/animations/pop_animation.dart';
import 'package:celery_with_me/widgets/animations/shake_animation.dart';
import 'package:celery_with_me/widgets/circular_button.dart';
import 'package:celery_with_me/widgets/icons/glas_icon.dart';

class DrinkButton extends StatefulWidget {
  @override
  _DrinkButtonState createState() => _DrinkButtonState();
}

class _DrinkButtonState extends State<DrinkButton> {
  bool _loading = false;

  void _drinkCeleryJuice() async {
    if (_loading) return;

    final drinkJuiceNotifier =
        Provider.of<DrinkJuiceNotifier>(context, listen: false);

    _setLoading(true);
    final success = await drinkJuiceNotifier.drink();
    if (success) {
      // TODO: play audio and animate out
    } else {
      _showErrorMessage();
    }
    _setLoading(false);
  }

  void _showErrorMessage() => Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Failed! Try again!'),
        duration: const Duration(seconds: 1),
        backgroundColor: CeleryWithMeTheme.errorColor,
      ));

  void _setLoading(bool loading) => setState(() => _loading = loading);

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return CircularButton(
        onTap: () {},
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      );
    }

    return PopAnimation(
      duration: const Duration(milliseconds: 2000),
      curve: Curves.elasticOut,
      child: CircularButton(
        child: ShakeAnimation(
          child: FilledGlasIcon.large(),
        ),
        title: 'DRINK',
        onTap: _drinkCeleryJuice,
      ),
    );
  }
}
