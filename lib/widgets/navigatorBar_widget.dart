import 'package:app_cf_marvel/res/theme/light_color.dart';
import 'package:flutter/material.dart';

class NavigatorBarWidget extends StatefulWidget {
  const NavigatorBarWidget({ super.key });

  @override
  NavigatorBarWidgetState createState() => NavigatorBarWidgetState();
}

class NavigatorBarWidgetState extends State<NavigatorBarWidget> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior = NavigationDestinationLabelBehavior.alwaysShow;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index){
        setState(() {
          currentPageIndex = index;
        });
      },
      labelBehavior: labelBehavior,
      indicatorColor: LightColor.purple,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Inicio'
        ),
        NavigationDestination(
          icon: Icon(Icons.star),
          label: 'Favoritos'
        ),
        NavigationDestination(
          icon: Icon(Icons.notifications),
          label: 'Notificaciones'
        )
      ],
    );
  }
}