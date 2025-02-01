/*
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../ui/screens/splash_screen.dart';




class NotificationHelper {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  GlobalKey<NavigatorState>? navigatorKey;
  bool initialized = false;
  var globalContext;
  AndroidNotificationChannel? channel;
  final storageService = StorageService();

  Future<void> initNotification( key) async {
    try {
      if (!initialized) {
        print(
            'notifiction helper initialized*');
*/
/*
        globalContext = context;
*//*

        navigatorKey = key;
        flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

        await flutterLocalNotificationsPlugin
            ?.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

        channel = const AndroidNotificationChannel(
            'high_importance_channel', // id
            'High Importance Notifications', // title
            description:
            'This channel is used for important notifications.', // description
            importance: Importance.high,
            showBadge: true);

        await flutterLocalNotificationsPlugin
            ?.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel!);

        await flutterLocalNotificationsPlugin
            ?.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();

        configLocalNotification();
        NotificationSettings settings =
        await firebaseMessaging.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: true,
          sound: true,
        );
        if (Platform.isIOS) {
          await firebaseMessaging.setForegroundNotificationPresentationOptions(
            alert: true, // Required to display a heads up notification
            badge: true,
            sound: true,
          );
        }
        String? token = await firebaseMessaging.getToken();
        assert(token != null);
        */
/*await Preferences.setStringToSF(
            Constants.deviceToken, token.toString());
*//*

        await storageService.setString(
            AppConstants.fcmtokenPr, token);
        print("Device token :---------------------------------->" + token!);

        setupInteractedMessage();

        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          print('Got a message whilst in the foreground!');
          if (!Platform.isIOS) {
            if (message.notification != null) {
              showNotification(message.notification, message.data);
            } else {
              showNotification1(message.data, message.data);
              print(
                  'Message also contained a notification: ${message.notification}');
            }
          }
        });

        //When App is in background
        FirebaseMessaging.onMessageOpenedApp.listen((event) {
          onSelectNotification(event.data);
        });

        initialized = true;
      }
    } catch (e) {
      print(e);
    }
  }

  //When App is Closed/Killed
  Future<void> setupInteractedMessage() async {
    await FirebaseMessaging.instance.getInitialMessage().then((value) =>
        _handleMessage(value != null ? value.data : Map(), isKill: true));
  }

  Future<void> _handleMessage(Map<String, dynamic> data,
      {isKill = false}) async {
//    print("data4454----------------->${data}");

    if (data.isNotEmpty) {


      Get.to(SplashScreen(

      ));
    }
  }

  void configLocalNotification() async {
    try {
      // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
      const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@drawable/ic_launcher');
      final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(onDidReceiveLocalNotification: ondidRec);
      */
/*  final LinuxInitializationSettings initializationSettingsLinux =
          LinuxInitializationSettings(defaultActionName: 'Open notification');*//*

      final InitializationSettings initializationSettings =
      InitializationSettings(
          android: initializationSettingsAndroid,
          iOS:
          initializationSettingsDarwin,
      );

      flutterLocalNotificationsPlugin?.initialize(initializationSettings,
          onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
    } catch (e) {
      print(e);
    }
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {

    final String? payload = notificationResponse.payload;
    var json = jsonDecode(notificationResponse.payload ?? "");


    }


  ondidRec(id, title, body, payload) {


  }

  Future<dynamic> onSelectNotification(message) async {
    if (message != null) {


    }
  }

  void showNotification(RemoteNotification? message, data) async {
    try {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        Platform.isAndroid
            ? 'high_importance_channel'
            : 'high_importance_channel',
        'High Importance Notifications',
        playSound: true,
        enableVibration: true,
        importance: Importance.max,
        priority: Priority.high,
      );
      var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin
          ?.show(0, message?.title, message?.body, platformChannelSpecifics,
          payload: jsonEncode(data))
          .catchError((error, stackTrace) => {print(error)})
          .onError((error, stackTrace) => {print(error)});
    } catch (e) {
      print(e);
    }
  }

  void showNotification1(message, data) async {
    print(message);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      Platform.isAndroid
          ? 'high_importance_channel'
          : 'high_importance_channel',
      'High Importance Notifications',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin?.show(0, message["title"].toString(),
        message["message"].toString(), platformChannelSpecifics,
        payload: jsonEncode(data));
  }
}*/
