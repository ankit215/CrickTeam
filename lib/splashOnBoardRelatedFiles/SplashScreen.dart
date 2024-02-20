import 'package:crick_team/profileRelatedScrees/EditProfileScreen.dart';
import 'package:crick_team/utils/constant.dart';
import 'package:crick_team/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../mainScreens/MainScreen.dart';
import 'OnBoardScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    super.initState();
    // init();
    debugPrint("wdddddwded"+getStringAsync(userId).toString());
    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
              getContext,
              MaterialPageRoute(builder: (context) => getStringAsync(userName).isEmpty&&getStringAsync(userId).isNotEmpty?const EditProfileScreen(from: "splash_screen"):getStringAsync(userName).isNotEmpty&&getStringAsync(userId).isNotEmpty?MainScreen(index: 0,):const OnBoardScreen()),
              // MaterialPageRoute(builder: (context) =>  NavigationScreen(index: 0,)),
            ));
  }
 @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 450,
              height: 450,
            ),
          ],
        ));
  }
}
