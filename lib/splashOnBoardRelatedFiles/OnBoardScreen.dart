
import 'package:flutter/material.dart';

import '../loginSignupRelatedFiles/LoginScreen.dart';
import '../loginSignupRelatedFiles/SignUpScreen.dart';
import '../main.dart';
import '../utils/AppColor.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Image.asset(
                "assets/onboard_image.png",
                height: 390,
                fit: BoxFit.cover,
              ),
            ),
            const Text(
              "Rise and shine, its time to play",
              style: TextStyle(fontSize: 40, fontFamily: "Lato_Bold",color: AppColor.brown2),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "A cricket fantasy app lets you pick real players to form your dream team for live matches. Compete against others based on your players' performances, strategize your lineup, and test your cricket expertise. Enjoy the excitement of managing your team and challenging friends in a thrilling virtual cricket experience.",
              style: TextStyle(fontSize: 14, fontFamily: "Lato_Regular", color: AppColor.text_grey),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: const TextSpan(children: <TextSpan>[
                TextSpan(text: "Join to ", style: TextStyle(fontSize: 16.0, color: AppColor.brown2, fontFamily: "Lato_Bold")),
                TextSpan(text: "start connecting!", style: TextStyle(fontSize: 16.0, color: AppColor.orange_light, fontFamily: "Lato_Bold"))
              ]),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20, top: 20),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 60,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  AppColor.btnGrad2,
                  AppColor.orange_light,
                ]),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<StadiumBorder>(
                      const StadiumBorder(),
                    ),
                    elevation: MaterialStateProperty.all(8),
                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                    // elevation: MaterialStateProperty.all(3),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    Navigator.push(getContext, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                  },
                  child: const Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "Lato_Bold", fontSize: 16,color: AppColor.white),
                  )),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(getContext, MaterialPageRoute(builder: (context) => const LoginScreen()));

              },
              child: Center(
                child: RichText(
                  text: const TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Already have an account? ", style: TextStyle(fontSize: 16.0, color: AppColor.brown2, fontFamily: "Lato_Regular")),
                    TextSpan(text: "Log in", style: TextStyle(fontSize: 16.0, color: AppColor.orange_light, fontFamily: "Lato_Regular"))
                  ]),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 30,)
          ]),
        ),
      ),
    ));
  }
}
