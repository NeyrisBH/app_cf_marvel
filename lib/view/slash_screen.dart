import 'package:app_cf_marvel/main_store/main_state.dart';
import 'package:app_cf_marvel/res/theme/light_color.dart';
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
  late AnimationController rotationController;
  late AnimationController shapeController;
  late Animation<BorderRadius?> borderRadiusAnimation;

  @override
  void initState() {
    super.initState();
    rotationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
    shapeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
    borderRadiusAnimation = BorderRadiusTween(
            begin: BorderRadius.circular(0), end: BorderRadius.circular(100))
        .animate(
            CurvedAnimation(parent: shapeController, curve: Curves.easeOut));
    MainState mainState = Provider.of<MainState>(context, listen: false);
    mainState.sessionState.init().whenComplete(() {
      if (mainState.sessionState.hasSession.value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const MainScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  void dispose() {
    rotationController.dispose();
    shapeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RotationTransition(
          turns: rotationController,
          alignment: Alignment.center,
          child: AnimatedBuilder(
            animation: borderRadiusAnimation,
            builder: (context, child) {
              return Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: LightColor.lightOrange,
                  borderRadius: borderRadiusAnimation.value,
                ),
                child: const Icon(
                  Icons.settings_sharp,
                  size: 100,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}