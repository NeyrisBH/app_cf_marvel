import 'package:app_cf_marvel/widgets/display_notification_widget.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationsService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  static NotificationDetails notificationDetails = const NotificationDetails(
    android: AndroidNotificationDetails(
      'channelId',
      'channelName',
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    ),
    iOS: DarwinNotificationDetails(threadIdentifier: 'thread_id'),
  );

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
    );
  }

  static Future<void> askForNotificationPermission() async {
    final permissionStatus = await Permission.notification.request();
    if (permissionStatus != PermissionStatus.granted) {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
    }
  }

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

  static Future<void> cancelPeriodicNotification({required int id}) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

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

  static Future<void> cancelPeriodicNotificationDay({required int id}) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

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

  static Future<void> cancelPeriodicNotificationWeek({required int id}) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static void onDidReceiveNotificationResponse(NotificationResponse response) {
    globalKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => DisplayNotification(payloadData: response.payload),
      ),
    );
  }

  static void onDidReceiveBackgroundNotificationResponse(NotificationResponse response) {
    globalKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => DisplayNotification(payloadData: response.payload),
      ),
    );
  }
}