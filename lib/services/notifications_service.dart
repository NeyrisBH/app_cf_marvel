import 'package:app_cf_marvel/widgets/display_notification_widget.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationsService {
  // Inicializar el plugin de notificaciones locales
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Llave global para gestionar la navegación
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  // Detalles de la notificación
  static NotificationDetails notificationDetails = const NotificationDetails(
    android: AndroidNotificationDetails(
      'channelId',
      'channelName',
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    ),
    iOS: DarwinNotificationDetails(threadIdentifier: 'thread_id'),
  );

  // Método para inicializar el plugin
  static Future<void> init() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings iosInitializationSettings =
        const DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
      onDidReceiveNotificationResponse: onDidReciveNotificationResponse,
    );
  }

  // Método para solicitar permiso de notificaciones
  static void askForNotificationPermission() {
    Permission.notification.request().then((permissionStatus) {
      if (permissionStatus != PermissionStatus.granted) {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      }
    });
  }

  // Método para enviar notificaciones instantáneas
  static void sendInstantNotification({
    required String title,
    required String body,
    required String playload,
  }) {
    flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: playload,
    );
  }

  // Método para enviar notificaciones periódicas cada hora
  static void sendPeriodicNotification({
    required int id,
    required String title,
    required String body,
    required String playload,
  }) {
    flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.hourly,
      notificationDetails,
      payload: playload,
    );
  }

  // Método para cancelar notificaciones periódicas por hora
  static Future<void> cancelPeriodicNotification({
    required int id,
  }) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  // Método para enviar notificaciones periódicas cada día
  static void sendPeriodicNotificationDay({
    required int id,
    required String title,
    required String body,
    required String playload,
  }) {
    flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.daily,
      notificationDetails,
      payload: playload,
    );
  }

  // Método para cancelar notificaciones periódicas por día
  static Future<void> cancelPeriodicNotificationDay({
    required int id,
  }) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  // Método para enviar notificaciones periódicas cada semana
  static void sendPeriodicNotificationWeek({
    required int id,
    required String title,
    required String body,
    required String playload,
  }) {
    flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.weekly,
      notificationDetails,
      payload: playload,
    );
  }

  // Método para cancelar notificaciones periódicas por semana
  static Future<void> cancelPeriodicNotificationWeek({
    required int id,
  }) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  // Manejar respuesta de notificación
  static void onDidReciveNotificationResponse(NotificationResponse response) {
    debugPrint('metodo para manipular respuesta');
    globalKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            DisplayNotification(payloadData: response.payload),
      ),
    );
  }

  // Manejar respuesta de notificación en segundo plano
  static void onDidReceiveBackgroundNotificationResponse(
      NotificationResponse response) {
    debugPrint('metodo para manipular desde segundo plano');
    globalKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            DisplayNotification(payloadData: response.payload),
      ),
    );
  }
}