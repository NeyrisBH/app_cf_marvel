import 'package:app_cf_marvel/locator.dart';
import 'package:app_cf_marvel/main_store/main_state.dart';
import 'package:app_cf_marvel/navigation/route.dart';
import 'package:app_cf_marvel/res/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'navigation/navigation_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await setupLocator();
  runApp(Provider(create: (_) => MainState(), child: const MarvelCF()));
}

class MarvelCF extends StatelessWidget {
  const MarvelCF({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: splashScreen,
    );
  }
}
