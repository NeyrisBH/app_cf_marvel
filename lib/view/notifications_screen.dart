import 'dart:math';

import 'package:app_cf_marvel/main_store/main_state.dart';
import 'package:app_cf_marvel/model/comics_model.dart';
import 'package:app_cf_marvel/services/notifications_service.dart';
import 'package:app_cf_marvel/view_model/comics/comics_state.dart';
import 'package:app_cf_marvel/widgets/banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  NotificationsScreenState createState() => NotificationsScreenState();
}

class NotificationsScreenState extends State<NotificationsScreen> {
  bool isSelectedHourly = false;
  bool isSelectedDaily = false;
  bool isSelectedWeekly = false;
  late ComicsState comicsState;

  @override
  void initState() {
    super.initState();
    NotificationsService.askForNotificationPermission();
    comicsState = ComicsState(main: MainState());
    comicsState.fetchComics();
  }

  String getRandomComicTitle(List<ComicModel> comicsList) {
    if (comicsList.isEmpty) {
      return 'No hay cómics disponibles';
    }
    final random = Random();
    final randomIndex = random.nextInt(comicsList.length);
    return comicsList[randomIndex].title;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    MainState mainState = Provider.of<MainState>(context);
    var userState = mainState.userState;

    return Observer(
      builder: (_) {
        if (comicsState.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildNotificationRow(
                      'Recibir notificaciones cada hora',
                      isSelectedHourly,
                      (value) {
                        setState(() {
                          isSelectedHourly = value;
                        });
                        if (isSelectedHourly) {
                          NotificationsService.sendPeriodicNotification(
                            title: 'Recurrencia horaria',
                            body: 'Cuerpo del mensaje',
                            playload: 'playload',
                            id: 0,
                          );
                        } else {
                          NotificationsService.cancelPeriodicNotification(
                              id: 0);
                        }
                      },
                    ),
                    buildNotificationRow(
                      'Recibir notificaciones cada día',
                      isSelectedDaily,
                      (value) {
                        setState(() {
                          isSelectedDaily = value;
                        });
                        if (isSelectedDaily) {
                          NotificationsService.sendPeriodicNotificationDay(
                            title: 'Recurrencia diaria',
                            body: 'Cuerpo del mensaje',
                            playload: 'playload',
                            id: 1,
                          );
                        } else {
                          NotificationsService.cancelPeriodicNotification(
                              id: 1);
                        }
                      },
                    ),
                    buildNotificationRow(
                      'Recibir notificaciones cada semana',
                      isSelectedWeekly,
                      (value) {
                        setState(() {
                          isSelectedWeekly = value;
                        });
                        if (isSelectedWeekly) {
                          NotificationsService.sendPeriodicNotificationWeek(
                            title: 'Recurrencia semanal',
                            body: 'Cuerpo del mensaje',
                            playload: 'playload',
                            id: 2,
                          );
                        } else {
                          NotificationsService.cancelPeriodicNotification(
                              id: 2);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (comicsState.comicsList.isNotEmpty) {
                            NotificationsService.sendInstantNotification(
                              title:
                                  '@${userState.user.value.nickname}, es un buen día para disfrutar de Marvel',
                              body:
                                  '¿Ya conocías este cómic: ${getRandomComicTitle(comicsState.comicsList)}?',
                              playload: 'Playload',
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'No hay cómics disponibles para sugerir.'),
                              ),
                            );
                          }
                        },
                        child: const Text('Recibir sugerencia'),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const BannerAdWidget(),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildNotificationRow(
    String label,
    bool isSelected,
    ValueChanged<bool> onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        Switch(
          value: isSelected,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
