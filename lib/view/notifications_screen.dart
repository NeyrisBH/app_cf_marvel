import 'package:app_cf_marvel/services/notifications_service.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  NotificationsScreenState createState() => NotificationsScreenState();
}

class NotificationsScreenState extends State<NotificationsScreen> {
  bool isSelectedHourly = false;
  bool isSelectedDaily = false;
  bool isSelectedWeekly = false;

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
                    NotificationsService.sendPeriodicNotification(
                      title: 'Recurrencia horaria',
                      body: 'Cuerpo del mensaje',
                      playload: 'playload',
                      id: 0,
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
                      title: 'Recurrencia diaria',
                      body: 'Cuerpo del mensaje',
                      playload: 'playload',
                      id: 1,
                    );
                  } else {
                    NotificationsService.cancelPeriodicNotification(id: 1);
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
                    NotificationsService.cancelPeriodicNotification(id: 2);
                  }
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    NotificationsService.sendInstantNotification(
                      title: 'title',
                      body: 'body',
                      playload: 'Playload',
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