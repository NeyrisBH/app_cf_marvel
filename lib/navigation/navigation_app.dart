
import 'package:app_cf_marvel/navigation/route.dart';
import 'package:app_cf_marvel/navigation/transitions.dart';
import 'package:app_cf_marvel/view/favorites_screen.dart';
import 'package:app_cf_marvel/view/login_screen.dart';
import 'package:app_cf_marvel/view/main_screen.dart';
import 'package:app_cf_marvel/view/notifications_screen.dart';
import 'package:app_cf_marvel/view/slash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case splashScreen:
        return MaterialPageRoute(builder: (_)=>const SplashScreen());
      case homeScreen:
        return TransitionsExample.fadeRoute(const MainScreen());
      case loginScreen:
        return TransitionsExample.fadeRoute(const LoginScreen());
      case favoritesScreen:
        return TransitionsExample.fadeRoute(const FavoritesScreen());
      case notificationsScreen:
        return TransitionsExample.fadeRoute(const NotificationsScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_){
      return const Scaffold(
        body:  Center(
          child:  Text(
            "error!! No se encontro la ventana"
          ),
        ),
      );
    });
  }
}