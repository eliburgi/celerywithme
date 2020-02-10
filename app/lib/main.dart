import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:celery_with_me/theme.dart';
import 'package:celery_with_me/pages/home/home_page.dart';
import 'package:celery_with_me/provider_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: CeleryWithMeTheme.primaryColor,
  ));
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(CeleryWithMeApp());
}

class CeleryWithMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Celery With Me',
        home: HomePage(),
        theme: ThemeData.light().copyWith(
          primaryColor: CeleryWithMeTheme.primaryColor,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
