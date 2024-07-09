import 'package:app_cf_marvel/main_store/main_state.dart';
import 'package:app_cf_marvel/view/login_screen.dart';
import 'package:app_cf_marvel/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  double turns = 0.0;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);

    MainState mainState = Provider.of<MainState>(context, listen: false);
    mainState.sessionState.init().whenComplete(() {
      if (mainState.sessionState.hasSession.value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const MainScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: RotationTransition(
        turns: animationController,
        alignment: Alignment.center,
        child: Icon(
          Icons.settings_sharp,
          size: 200,
          color: Colors.purple.withOpacity(0.7),
        ),
      ),
    ));
  }
}
