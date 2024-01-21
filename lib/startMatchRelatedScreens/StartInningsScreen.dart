import 'package:crick_team/scoreRelatedScreens/ScorerScreen.dart';
import 'package:crick_team/startMatchRelatedScreens/SelectTeam.dart';
import 'package:crick_team/startMatchRelatedScreens/StartMatch.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../mainScreens/MainScreen.dart';

class StartInningsScreen extends StatefulWidget {
  const StartInningsScreen({super.key});

  @override
  State<StartInningsScreen> createState() => _StartInningsScreenState();
}

class _StartInningsScreenState extends State<StartInningsScreen> {
  bool isStriker = false;
  bool isNonStriker = false;
  bool isBowlerSelected = false;

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
          "Start Innings",
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.sizeOf(context).height * 0.9,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Batting Players',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Lato_Semibold",
                        color: AppColor.brown2),
                  ),
                  const SizedBox(
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
                              isStriker = true;
                              isNonStriker = false;

                            });

                          },
                          child: Container(
                            width: 150,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient:isStriker? const LinearGradient(colors: [
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
                                  "assets/striker.png",
                                  height: 60,
                                  width: 60,
                                  color: isStriker?Colors.white:AppColor.black,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                 Center(
                                  child: Text(
                                    "Select Striker",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Lato_Sembold",
                                      color: isStriker?Colors.white:AppColor.text_grey,
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
                              isStriker = false;
                              isNonStriker = true;
                            });

                          },
                          child: Container(
                            width: 150,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: isNonStriker? const LinearGradient(colors: [
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
                              "assets/non_striker.png",
                              height: 60,
                              width: 60,
                                color: isNonStriker?Colors.white:AppColor.black,
                            ),
                                const SizedBox(
                                  height: 15,
                                ),
                                 Center(
                                  child: Text(
                                    "Select Non Striker",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Lato_Sembold",
                                      color: isNonStriker?Colors.white:AppColor.text_grey,
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Bowling',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Lato_Semibold",
                        color: AppColor.brown2),
                  ),
                  const SizedBox(
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
                              isBowlerSelected = true;
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: isBowlerSelected? const LinearGradient(colors: [
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
                                  "assets/bowler.png",
                                  height: 60,
                                  width: 60,
                                  color: isBowlerSelected?Colors.white:AppColor.text_grey,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                 Center(
                                  child: Text(
                                    "Bowler",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Lato_Sembold",
                                      color: isBowlerSelected?Colors.white:AppColor.text_grey,
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
                        builder: (context) => const ScorerScreen(team: "A")));
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
                child: const Center(
                  child: Text(
                    "Start Scoring",
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
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
