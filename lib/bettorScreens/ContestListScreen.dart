import 'package:crick_team/apiRelatedFiles/rest_apis.dart';
import 'package:crick_team/loginSignupRelatedFiles/LoginScreen.dart';
import 'package:crick_team/main.dart';
import 'package:crick_team/modalClasses/GetContestModel.dart';
import 'package:crick_team/modalClasses/GetMatchModel.dart';
import 'package:crick_team/modalClasses/MyContestModel.dart';
import 'package:crick_team/scoreRelatedScreens/ScoreBoardscreen.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:crick_team/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../startMatchRelatedScreens/TossScreen.dart';
import '../utils/CommonFunctions.dart';
import '../utils/constant.dart';
import '../utils/shared_pref.dart';

class ContestListScreen extends StatefulWidget {
  final UpcomingListArr matchData;

  const ContestListScreen({super.key, required this.matchData});

  @override
  State<ContestListScreen> createState() => _ContestListScreenState();
}

class _ContestListScreenState extends State<ContestListScreen> {
  List<GetContestData> contestList = [];
  List<MyContestData> myContestList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getContestListApi();
    });
    Future.delayed(Duration.zero, () {
      getContestListApi();
    });
  }

  Future getContestListApi() async {
    await getContestList(widget.matchData.id.toString()).then((res) async {
      hideLoader();
      if (res.success == 1) {
        setState(() {
          contestList = [];
          contestList.addAll(res.body!);
        });
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
  Future getMyContestListApi() async {
    await getMyContestList(widget.matchData.id.toString()).then((res) async {
      hideLoader();
      if (res.success == 1) {
        setState(() {
          myContestList = [];
          myContestList.addAll(res.body!);
        });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 5.0,
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
        title: Text(
          "${widget.matchData.team1Name} vs ${widget.matchData.team2Name.toString()}",
          style: const TextStyle(
            fontSize: 20,
            fontFamily: "Lato_Semibold",
            color: AppColor.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              contestList.isEmpty
                  ? SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/crick_layout_background.png",
                            width: 90,
                            height: 90,
                          ),
                          const Text(
                            "No Data Found!!",
                            style: TextStyle(
                                fontFamily: "Ubuntu_Bold",
                                color: AppColor.brown_0,
                                fontSize: 16),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: contestList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            elevation: 0.5,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  AppColor.yellowV2.withOpacity(0.2),
                                  AppColor.yellowV2.withOpacity(0.2),
                                ]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Center(
                                        child: Image.asset(
                                          "assets/crick_layout_background.png",
                                          fit: BoxFit.contain,
                                          height: 140,
                                          width: 140,
                                          opacity:
                                              const AlwaysStoppedAnimation(.09),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Prize Pool",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "Lato_Semibold",
                                                      color: AppColor.brown2,
                                                      fontSize: 16),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  "Entry",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "Lato_Semibold",
                                                      color: AppColor.brown2,
                                                      fontSize: 16),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "₹${contestList[index].prizePool}",
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          "Lato_Semibold",
                                                      color: AppColor.brown2,
                                                      fontSize: 22),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: AppColor.green),
                                                  child: Text(
                                                    "₹${contestList[index].entryFee}",
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            "Lato_Semibold",
                                                        color: AppColor.white,
                                                        fontSize: 16),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                        Container(
                                          height: 5,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [AppColor.brown2, AppColor.red], // Define gradient colors
                                              begin: Alignment.centerLeft, // Define start point
                                              end: Alignment.centerRight, // Define end point
                                            ),
                                            borderRadius: BorderRadius.circular(5.0), // Optional: border radius
                                          ),
                                          child:  LinearProgressIndicator(
                                            value: 0.1, // Adjust value as needed
                                            backgroundColor: AppColor.grey,
                                            color: AppColor.orange_light,// Make background transparent
                                          ),
                                        ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                  "${contestList[index].totalParticipants!-contestList[index].count!} spots left",
                                                  style: const TextStyle(
                                                      fontFamily:
                                                      "Lato_Semibold",
                                                      color: AppColor.red,
                                                      fontSize: 14),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  "${contestList[index].totalParticipants!} spots",
                                                  style: const TextStyle(
                                                      fontFamily:
                                                      "Lato_Semibold",
                                                      color: AppColor.black,
                                                      fontSize: 14),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                /*  Container(
                                    alignment: Alignment.bottomCenter,
                                    height: 40,
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: BoxDecoration(
                                      color: AppColor.grey.withOpacity(0.4),
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    child: const Row(
                                      children: [],
                                    ),
                                  ),*/
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }}
