import 'package:crick_team/apiRelatedFiles/rest_apis.dart';
import 'package:crick_team/loginSignupRelatedFiles/LoginScreen.dart';
import 'package:crick_team/startMatchRelatedScreens/SelectTeam.dart';
import 'package:crick_team/startMatchRelatedScreens/StartMatch.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:crick_team/utils/CommonFunctions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../mainScreens/MainScreen.dart';
import '../modalClasses/GetMatchModel.dart';
import '../utils/common.dart';
import 'StartInningsScreen.dart';

class TossScreen extends StatefulWidget {
  final GetMatchData matchData;

  const TossScreen({super.key, required this.matchData});

  @override
  State<TossScreen> createState() => _TossScreenState();
}

class _TossScreenState extends State<TossScreen> {
  bool isTeamASelected = false;
  bool isTeamBSelected = false;
  bool isBatSelected = false;
  bool isBallSelected = false;
  var tossWinnerId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tossWinnerId = "";
  }

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
                    'Who won the toss?',
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
                              isTeamASelected = true;
                              isTeamBSelected = false;
                              tossWinnerId =
                                  widget.matchData.team1Id.toString();
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: isTeamASelected
                                  ? const LinearGradient(colors: [
                                      AppColor.red,
                                      AppColor.brown2,
                                    ])
                                  : const LinearGradient(colors: [
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
                                  backgroundColor: Colors.white,
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
                                    widget.matchData.team1Name.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Lato_Sembold",
                                      color: isTeamASelected
                                          ? Colors.white
                                          : AppColor.text_grey,
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
                              tossWinnerId =
                                  widget.matchData.team2Id.toString();
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: isTeamBSelected
                                  ? const LinearGradient(colors: [
                                      AppColor.red,
                                      AppColor.brown2,
                                    ])
                                  : const LinearGradient(colors: [
                                      AppColor.grey,
                                      AppColor.grey,
                                    ]),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
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
                                    widget.matchData.team2Name.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Lato_Sembold",
                                      color: isTeamBSelected
                                          ? Colors.white
                                          : AppColor.text_grey,
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
                    'Winner of the toss elected to?',
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
                              isBatSelected = true;
                              isBallSelected = false;
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: isBatSelected
                                  ? const LinearGradient(colors: [
                                      AppColor.red,
                                      AppColor.brown2,
                                    ])
                                  : const LinearGradient(colors: [
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
                                  color: isBatSelected
                                      ? Colors.white
                                      : AppColor.text_grey,
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
                                      color: isBatSelected
                                          ? Colors.white
                                          : AppColor.text_grey,
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
                              gradient: isBallSelected
                                  ? const LinearGradient(colors: [
                                      AppColor.red,
                                      AppColor.brown2,
                                    ])
                                  : const LinearGradient(colors: [
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
                                  color: isBallSelected
                                      ? Colors.white
                                      : AppColor.text_grey,
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
                                      color: isBallSelected
                                          ? Colors.white
                                          : AppColor.text_grey,
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
                if (checkValidations()) {
                  tossResultApi();
                }
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
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  bool checkValidations() {
    if (tossWinnerId.isEmpty) {
      CommonFunctions()
          .showToastMessage(getContext, "Please select who won the toss.");
      return false;
    } else if (isBatSelected == false && isBallSelected == false) {
      CommonFunctions().showToastMessage(
          getContext, "Please select winner of the toss elected to.");
      return false;
    } else {
      return true;
    }
  }

  tossResultApi() async {
    var request = {
      'match_id': widget.matchData.id.toString(),
      'toss_winner_id': tossWinnerId,
      'toss_decision': isBatSelected ? "1" : "2",
    };
    await tossResult(request).then((res) async {
      if (res.success == 1) {
        Navigator.push(
            getContext,
            MaterialPageRoute(
                builder: (context) =>  StartInningsScreen(matchData: widget.matchData,tossWinnerId:tossWinnerId,tossWinnerElected: isBatSelected ? "1" : "2",)));
      } else if (res.success != 1 && res.code == 401) {
        toast(res.message);
        Navigator.pushAndRemoveUntil(
            getContext,
            MaterialPageRoute(
              builder: (getContext) => const LoginScreen(),
            ),
            (route) => false);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
      } else {
        CommonFunctions().showToastMessage(context, res.message!);
      }
    });
  }
}
