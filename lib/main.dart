import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:monexo/config/config.dart';
import 'package:monexo/generated/l10n.dart';
import 'package:monexo/screens/screens.dart';
import 'package:monexo/services/category_provider.dart';
import 'package:monexo/services/currency_provider.dart';
import 'package:monexo/services/services.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await CurrencyProvider().init();

  runApp(const MyApp());
}

final class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final FirebaseAnalytics _analytics;

  @override
  void initState() {
    super.initState();
    _analytics = FirebaseAnalytics.instance;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<AppUser?>.value(
          value: AuthService().user,
          initialData: null,
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: _analytics),
          ],
          title: 'Monexo',
          theme: appTheme(),
          initialRoute: SplashScreen.routeName,
          routes: routes,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        ),
      ),
    );
  }
}
