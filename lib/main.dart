import 'package:crick_team/splashOnBoardRelatedFiles/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final navigatorKey = GlobalKey<NavigatorState>();

get getContext => navigatorKey.currentState?.overlay?.context;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.orange),
        dividerColor: Colors.white,
        colorScheme: const ColorScheme.light(primary: Colors.white),
      ),
      home: const MyHomePage(),
    );
  }

/*
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
*/
  Future<void> getDeviceToken() async {
    // final fcmToken = await FirebaseMessaging.instance.getToken();
    // debugPrint('FCM_TOKEN__$fcmToken');
    // setValue(deviceToken, fcmToken);
  }

  Future<void> chooseUser() async {
    // await iniSharePref();
  }
}
