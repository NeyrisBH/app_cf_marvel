import 'package:app_cf_marvel/main_store/main_state.dart';
import 'package:app_cf_marvel/navigation/route.dart';
import 'package:app_cf_marvel/res/theme/light_color.dart';
import 'package:app_cf_marvel/services/notifications_service.dart';
import 'package:app_cf_marvel/view/favorites_screen.dart';
import 'package:app_cf_marvel/view/home_screen.dart';
import 'package:app_cf_marvel/view/notifications_screen.dart';
import 'package:app_cf_marvel/view_model/session/session_state.dart';
import 'package:app_cf_marvel/view_model/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late UserState userState;
  late SessionState sessionState;
  int currentPageIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const FavoritesScreen(comicId: 0,),
    const NotificationsScreen(),
  ];

    final List<String> titles = [
    'Inicio',
    'Favoritos',
    'Administrar Notificaciones',
  ];

  @override
  void initState() {
    super.initState();
    NotificationsService.askForNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    MainState mainState = Provider.of<MainState>(context);
    userState = mainState.userState;
    sessionState = mainState.sessionState;

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentPageIndex]),
      ),
      drawer: _buildDrawer(),
      body: IndexedStack(
        index: currentPageIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        indicatorColor: LightColor.purple,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.star), label: 'Favoritos'),
          NavigationDestination(icon: Icon(Icons.notifications), label: 'Notificaciones'),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          Observer(
            builder: (context) => DrawerHeader(
              decoration: BoxDecoration(color: Colors.purple.withOpacity(0.4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(userState.user.value.picture),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userState.user.value.name,
                        style: const TextStyle(color: LightColor.background, fontSize: 20),
                      ),
                      Text(
                        userState.user.value.nickname,
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: LightColor.lightblack,
            elevation: 0.2,
            child: ListTile(
              textColor: LightColor.background,
              trailing: const Icon(Icons.close),
              title: const Text('Cerrar sesión'),
              onTap: () async {
                await sessionState.closeSession();
                Navigator.pushNamed(context, splashScreen);
              },
            ),
          ),
        ],
      ),
    );
  }
}