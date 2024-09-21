import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';


class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
        onDidReceiveNotificationResponse: (payload){
         // handleMessage(context, message);
        }

      // onSelectNotification: (String? id) async {
      //   print("onSelectNotification");
      //   if (id!.isNotEmpty) {
      //     print("Router Value1234 $id");
      //
      //     // Navigator.of(context).push(
      //     //   MaterialPageRoute(
      //     //     builder: (context) => DemoScreen(
      //     //       id: id,
      //     //     ),
      //     //   ),
      //     // );
      //
      //
      //   }
      // },
    );
  }
  static void createanddisplaynotification(RemoteMessage message) async {
    try {
        final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

        // Download the image
        String? imageUrl = message.notification?.android?.imageUrl ??
            message.notification?.apple?.imageUrl;

        String? largeIconPath = await _downloadAndSaveFile(
          'lib/assets/logo/logoo.png', // Logo URL
          'logo',
        );

        String? bigPicturePath;
        if (imageUrl != null) {
          bigPicturePath = await _downloadAndSaveFile(imageUrl, 'bigPicture');
        }

        final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
          FilePathAndroidBitmap(bigPicturePath!),
          largeIcon: FilePathAndroidBitmap(largeIconPath!), // App logo
          contentTitle: message.notification?.title,
          summaryText: message.notification?.body,
        );

        const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "ndconnectpushnotification",
          "ndconnectpushnotificationchannel",
          importance: Importance.high,
          priority: Priority.high,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
  static Future<String?> _downloadAndSaveFile(
      String url, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      final response = await http.get(Uri.parse(url));
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } catch (e) {
      print('Error downloading image: $e');
      return null;
    }
  }

}