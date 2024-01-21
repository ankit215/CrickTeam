import 'package:crick_team/startMatchRelatedScreens/SelectTeam.dart';
import 'package:crick_team/startMatchRelatedScreens/StartMatch.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../mainScreens/MainScreen.dart';
import 'StartInningsScreen.dart';

class TossScreen extends StatefulWidget {
  const TossScreen({super.key});

  @override
  State<TossScreen> createState() => _TossScreenState();
}

class _TossScreenState extends State<TossScreen> {
  bool isTeamASelected = false;
  bool isTeamBSelected = false;
  bool isBatSelected = false;
  bool isBallSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: AppColor.brown2,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(
              "assets/back_arrow.png",
              color: Colors.white,
            ),
          ),
        ),
        title: const Text(
          "Toss",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Lato_Semibold",
            color: AppColor.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.sizeOf(context).height * 0.9,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Who won the toss?',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Lato_Semibold",
                        color: AppColor.brown2),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isTeamASelected = true;
                              isTeamBSelected = false;

                            });

                          },
                          child: Container(
                            width: 150,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient:isTeamASelected? const LinearGradient(colors: [
                                AppColor.red,
                                AppColor.brown2,
                              ]):const LinearGradient(colors: [
                                AppColor.grey,
                                AppColor.grey,
                              ]),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  child: ClipOval(
                                      child: Image.asset(
                                    "assets/team_placeholder.png",
                                    fit: BoxFit.contain,
                                    height: 45,
                                    width: 45,
                                  )),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                 Center(
                                  child: Text(
                                    "Team A",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Lato_Sembold",
                                      color: isTeamASelected?Colors.white:AppColor.text_grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isTeamASelected = false;
                              isTeamBSelected = true;
                            });

                          },
                          child: Container(
                            width: 150,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: isTeamBSelected? const LinearGradient(colors: [
                                AppColor.red,
                                AppColor.brown2,
                              ]):const LinearGradient(colors: [
                                AppColor.grey,
                                AppColor.grey,
                              ]),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  child: ClipOval(
                                      child: Image.asset(
                                    "assets/team_placeholder.png",
                                    fit: BoxFit.contain,
                                    height: 45,
                                    width: 45,
                                  )),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                 Center(
                                  child: Text(
                                    "Team B",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Lato_Sembold",
                                      color: isTeamBSelected?Colors.white:AppColor.text_grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Winner of the toss elected to?',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Lato_Semibold",
                        color: AppColor.brown2),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isBatSelected = true;
                              isBallSelected = false;
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: isBatSelected? const LinearGradient(colors: [
                                AppColor.red,
                                AppColor.brown2,
                              ]):const LinearGradient(colors: [
                                AppColor.grey,
                                AppColor.grey,
                              ]),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/bats.png",
                                  height: 50,
                                  width: 60,
                                  color: isBatSelected?Colors.white:AppColor.text_grey,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                 Center(
                                  child: Text(
                                    "BAT",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Lato_Sembold",
                                      color: isBatSelected?Colors.white:AppColor.text_grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isBatSelected = false;
                              isBallSelected = true;
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: isBallSelected? const LinearGradient(colors: [
                                AppColor.red,
                                AppColor.brown2,
                              ]):const LinearGradient(colors: [
                                AppColor.grey,
                                AppColor.grey,
                              ]),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/ball.png",
                                  height: 50,
                                  width: 60,
                                  color: isBallSelected?Colors.white:AppColor.text_grey,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                 Center(
                                  child: Text(
                                    "BALL",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Lato_Sembold",
                                      color: isBallSelected?Colors.white:AppColor.text_grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    getContext,
                    MaterialPageRoute(
                        builder: (context) => const StartInningsScreen()));
              },
              child: Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    AppColor.red,
                    AppColor.brown2,
                  ]),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Lato_Sembold",
                      color: AppColor.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
