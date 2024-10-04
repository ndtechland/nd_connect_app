import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nd_connect_techland/modules/all_pages/attendance/attendance.dart';
import 'package:nd_connect_techland/modules/all_pages/events/events_calender.dart';
import 'package:nd_connect_techland/modules/all_pages/task/task.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/settings.dart';
import 'package:nd_connect_techland/services_apis/auto_login_employee.dart';

import '../modules/all_pages/pages/notification.dart';
import '../modules/bottom_bar/bottom_bar.dart';
class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void notificationRequestPermission() async {
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  if (settings.authorizationStatus == AuthorizationStatus.authorized){
    print("User granted permission");
  } else if(settings.authorizationStatus == AuthorizationStatus.provisional){
    print("User provisional granted permission");
  } else {
    Get.snackbar('Notification Denied',
      "Plese allow Notification to recieve updates!",
        snackPosition: SnackPosition.BOTTOM,
    );
    Future.delayed(Duration(seconds: 2),(){
      AppSettings.openAppSettings(type: AppSettingsType.notification);
    });
  }
}
//get device token
Future<String> getDeviceToken() async {
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true
  );
  String? token = await messaging.getToken();
  print("tokennn==> $token");
  return token!;
}
//inti
void initLocalNotification(BuildContext context,RemoteMessage message)async{
  var androidInitSetting = const AndroidInitializationSettings("@mipmap/ic_launcher");
  var iosInitSetting = const DarwinInitializationSettings();
  var initializationSetting = InitializationSettings(
    android: androidInitSetting,
    iOS: iosInitSetting,
  );
  await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payload){
        handleMessage(context, message);
      });
}

//firebaseinit
void firebaseInit(BuildContext context) {
  FirebaseMessaging.onMessage.listen((message){
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification!.android;

    if(kDebugMode){
      print("notification title: ${notification!.title}");
      print("notification body: ${notification.body}");
    }
    if(Platform.isIOS){
      iosForgroundMessage();
    }
    if(Platform.isAndroid){
      initLocalNotification(context, message);
      // handleMessage(context, message);
      showNotification(message);
    }
  });
}
//function show notification
  Future<void> showNotification(RemoteMessage message) async {
  AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
    importance: Importance.high,
    showBadge: true,
    playSound: true,
  );
  //android setting
  AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
  channelDescription: "Channel Discription",
  priority: Priority.high,
  playSound: true,
  sound: channel.sound,
    icon: '@mipmap/ic_launcher'
  );
  //ios setting
    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
//merge settings
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    //show notification after merge
Future.delayed(Duration.zero,(){
  _flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title.toString(),
      message.notification!.body.toString(),
      notificationDetails,
  payload: "my_data");
});
  }

//background and terminated
  Future<void> setupInteractMessage(BuildContext context) async{
  //backgraound state
    FirebaseMessaging.onMessageOpenedApp.listen((message){
      handleMessage(context, message);
    });

    //terminated state
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message){
if(message !=null && message.data.isNotEmpty){
  handleMessage(context, message);
}
    });
  }

  //handle message
  Future<void> handleMessage(BuildContext context,RemoteMessage message) async {
    if (message.data['type'] == 'notify') {
      await Future.delayed(Duration(microseconds: 200));
      accountService2.getAccountData2.then((accountData2) {
        Timer(

          const Duration(milliseconds: 300),

              () {
            print("dataa1${message.data['id']}");

            // nearlistdriverApi();

            Navigator.push(

                context,

                MaterialPageRoute(

                    builder: (context) =>
                        NotificationScreen(

                          id: message.data['id'],

                        )));
          },

        );
      });
    } else if (message.data['type'] == 'task') {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => TaskList(id: message.data['id'],)));
    } else if (message.data['type'] == 'event') {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => EventCalendarScreen(id: message.data['id'],)));
    } else if (message.data['type'] == 'attendance') {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Attendance(id: message.data['id'],)));
    } else if (message.data['type'] == 'setting') {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Settings(id: message.data['id'],)));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomBar()));
    }
  }

//ios message
  Future iosForgroundMessage() async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
