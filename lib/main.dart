import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_notification/logger_service.dart';
import 'package:flutter_notification/responsive/responsive.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

void main() async {
  // to initialize flutter engine before executing the asynchronous
  WidgetsFlutterBinding.ensureInitialized();
  //used to connect the app to the firebase backend
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromARGB(255, 15, 58, 66)),
            textTheme: GoogleFonts.nunitoTextTheme(
              Theme.of(context).textTheme,
            )),
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Home Page",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp(context), // Now `sp` will work properly
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: const NotificationWidget(),
        ));
  }
}

/*------ stateful widget -----*/
class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});
  @override
  // NotificationWidgetState createState() => NotificationWidgetState();
  NotificationWidgetState createState() => NotificationWidgetState();
}

//state class which manages Notification Widget lifecycle
class NotificationWidgetState extends State<NotificationWidget> {
  //getting the instance which is used to interact with FCM
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((token) {
      if (token != null) {
        print("🔥 FCM Token: $token");
      } else {
        print("❌ Failed to get FCM Token");
      }
    }).catchError((error) {
      print("❌ Error getting FCM Token: $error");
    });
    super.initState();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    //getting permission from user
    _firebaseMessaging.requestPermission();
    //handling incoming message from stream when app is in forground
    //Remote Message represents data and notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LoggerService.loggerInstance.dynamic_d('Message data: ${message.data}');
      //handing display notification payload
      if (message.notification != null) {
        LoggerService.loggerInstance.w(
            'Message also contained a notification: ${message.notification}');
      }
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        _showNotification(notification);
      }
    });
    //handling notification clicks
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked! ${message.messageId}');
    });
  }

  void _showNotification(RemoteNotification notification) async {
    // LoggerService.loggerInstance
    //     .dynamic_d("android is ${notification.android}");
    // LoggerService.loggerInstance.dynamic_d("apple is ${notification.apple}");
    // LoggerService.loggerInstance.dynamic_d("body is ${notification.body}");
    // LoggerService.loggerInstance.dynamic_d("title is ${notification.title}");

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('channel_id', 'channel_name',
            importance: Importance.max,
            priority: Priority.high,
            icon: 'chatapp_logo');

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    final notificationId = const Uuid().v4().hashCode.abs();

    await flutterLocalNotificationsPlugin.show(
      notificationId,
      notification.title,
      notification.body,
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Waiting for messages'),
    );
  }
}
