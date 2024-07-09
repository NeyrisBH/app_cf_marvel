import 'package:app_cf_marvel/model/comics_model.dart';
import 'package:app_cf_marvel/services/notifications_service.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool isSelectedHourly = false;
  bool isSelectedDaily = false;
  bool isSelectedWeekly = false;

  List<ComicModel> comics = [];

  @override
  void initState() {
    NotificationsService.askForNotificationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                    NotificationsService.sendPeriodicNotificationWithRandomComic(
                      id: 0,
                      title: 'Recurrencia horaria',
                      comics: comics,
                    );
                  } else {
                    NotificationsService.cancelPeriodicNotification(id: 0);
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
                      id: 1,
                      title: 'Recurrencia diaria',
                      body: 'Cuerpo del mensaje',
                      playload: 'playload',
                    );
                  } else {
                    NotificationsService.cancelPeriodicNotificationDay(id: 1);
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
                      id: 2,
                      title: 'Recurrencia semanal',
                      body: 'Cuerpo del mensaje',
                      playload: 'playload',
                    );
                  } else {
                    NotificationsService.cancelPeriodicNotificationWeek(id: 2);
                  }
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    NotificationsService.sendInstantNotificationWithRandomComic(
                      comics,
                      title: 'Notificación instantánea',
                    );
                  },
                  child: const Text('Recibir un detalle'),
                ),
              )
            ],
          ),
        ),
      ),
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