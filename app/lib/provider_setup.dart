import 'package:celery_with_me/data/drink_scores.dart';
import 'package:celery_with_me/notifiers/drink_juice.dart';
import 'package:celery_with_me/notifiers/live_connection.dart';
import 'package:celery_with_me/notifiers/live_stream.dart';
import 'package:celery_with_me/services/live_service.dart';
import 'package:celery_with_me/services/live_service_mocked.dart';
import 'package:provider/provider.dart';

final providers = [
  Provider<LiveService>(
    create: (_) => MockedLiveService(),
    dispose: (_, service) => service.dispose(),
  ),
  ChangeNotifierProvider<LiveConnectionNotifier>(
    create: (context) => LiveConnectionNotifier(
      liveService: Provider.of(context, listen: false),
    ),
  ),
  ChangeNotifierProvider<LiveStreamNotifier<DrinkScores>>(
    create: (context) => LiveStreamNotifier(
      stream:
          Provider.of<LiveService>(context, listen: false).drinkScoresStream,
    ),
  ),
  ChangeNotifierProvider<DrinkJuiceNotifier>(
    create: (context) => DrinkJuiceNotifier(
      liveService: Provider.of<LiveService>(context, listen: false),
    ),
  ),
];
