import 'package:crick_team/splashOnBoardRelatedFiles/SplashScreen.dart';
import 'package:crick_team/utils/constant.dart';
import 'package:crick_team/utils/shared_pref.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
final navigatorKey = GlobalKey<NavigatorState>();

get getContext => navigatorKey.currentState?.overlay?.context;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // await LocalNotificationService.initMainFCM();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    // LocalNotificationService.initNotification();
    // init();
    chooseUser();
  }

/*
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    getPermissions();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCrWBUbpZ3Gbp1y_cewjgNACoNP7nLJ8Xk",
          appId: "1:107063697561:android:56dff05956c6c7ecf75808",
          messagingSenderId: "107063697561",
          projectId: "raves-and-rants"),
    );
  }
*/

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorSchemeSeed: Colors.white,
          primaryColor: Colors.white,
          colorScheme: Theme.of(context).colorScheme.copyWith(
            background: Colors.white
            //..here
          )
      ),
      navigatorKey: navigatorKey,
      home: const MyHomePage(),
    );
  }

  Future<void> getPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
    if (await Permission.notification.request().isGranted) {
      try {
        // Either the permission was already granted before or the user just granted it.
        getDeviceToken();
      } catch (e) {
        debugPrint('ERROR__$e');
      }
    }
  }
  Future<void> getDeviceToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint('FCM_TOKEN__$fcmToken');
    setValue(deviceToken, fcmToken);
  }
  Future<void> chooseUser() async {
    await iniSharePref();
  }
}
