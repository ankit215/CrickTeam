import 'package:crick_team/splashOnBoardRelatedFiles/SplashScreen.dart';
import 'package:crick_team/utils/constant.dart';
import 'package:crick_team/utils/shared_pref.dart';
import 'package:firebase_core/firebase_core.dart';
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
  // Initialize sharedPreferences before using it
  await iniSharePref();
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
    init();


  }

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    chooseUser();
    // getPermissions();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCh9GawQsp5_W4jx34qNXx6FvVqxcfs0SQ",
          appId: "1:258723223868:android:6ead204196d792e0852639",
          messagingSenderId: "258723223868",
          projectId: "cric-team-35e34"),
    );
  }

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
