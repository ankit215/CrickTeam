import 'dart:convert';

import 'package:crick_team/loginSignupRelatedFiles/LoginScreen.dart';
import 'package:crick_team/main.dart';
import 'package:crick_team/modalClasses/GetMatchModel.dart';
import 'package:crick_team/modalClasses/MyContestModel.dart';
import 'package:crick_team/utils/CommonFunctions.dart';
import 'package:crick_team/utils/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apiRelatedFiles/rest_apis.dart';
import '../modalClasses/GetContestModel.dart';
import '../modalClasses/MatchDetailModel.dart';
import '../modalClasses/MyContestModel.dart';
import '../utils/AppColor.dart';
import '../utils/constant.dart';
import 'ContestDetailScreen.dart';
import 'PreviewTeamScreen.dart';

class ContestScreen extends StatefulWidget {
  final String?from;
  final UpcomingListArr matchData;

  const ContestScreen({super.key, required this.matchData, this.from});

  @override
  State<ContestScreen> createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  List<GetContestData> contestList = [];
  List<MyContestData> myContestList = [];
  MatchDetailData? getMatchDetailData;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getMatchDetailApi();
    });

    tabController = TabController(
      initialIndex: 0,
      length: widget.from=="current"?2:3,
      vsync: this,
    );
    tabController.addListener(_handleTabSelection);
  }

  Future getContestListApi() async {
    await getContestList(widget.matchData.id.toString()).then((res) async {
      hideLoader();
      if (res.success == 1) {
        setState(() {
          contestList = [];
          contestList.addAll(res.body!);
          for (int i = 0; i < contestList.length; i++) {
            if (contestList[i].count == contestList[i].totalParticipants) {
              replicateContestApi(contestList[i].id.toString());
            }
          }
        });
      } else if (res.message == "Invalid Token" && res.code == 400) {
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

  Future getMatchDetailApi() async {
    await getMatchDetail(widget.matchData.id.toString()).then((res) async {
      hideLoader();
      if (res.success == 1) {
        setState(() {
          getMatchDetailData = res.body;
          Future.delayed(Duration.zero, () {
            getContestListApi();
          });
          Future.delayed(Duration.zero, () {
            getMyContestListApi();
          });
        });
      } else if (res.message == "Invalid Token" && res.code == 400) {
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
          getMergedTeamList(res);
        });
      } else if (res.message == "Invalid Token" && res.code == 400) {
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
        // CommonFunctions().showToastMessage(context, res.message!);
      }
    });
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.sizeOf(context).height * 0.2),
        child: AppBar(
          elevation: 0,
          backgroundColor: AppColor.brown2,
          scrolledUnderElevation: 0.0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/back_arrow.png",
                height: 20,
                width: 20,
                color: Colors.white,
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(200),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: 47,
                              width: MediaQuery.sizeOf(context).width * 0.22,
                              decoration: BoxDecoration(
                                color: AppColor.yellowMed.withOpacity(0.4),
                              ),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(left: 20),
                                child: Text(
                                  getFirstLetters(
                                      widget.matchData.team1Name.toString()),
                                  style: const TextStyle(
                                      fontFamily: "Lato_Semibold",
                                      color: AppColor.white,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.15,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 40,
                                child: ClipOval(
                                    child: widget.matchData.team1Photo != null
                                        ? Image.network(
                                            mediaUrl +
                                                widget.matchData.team1Photo
                                                    .toString(),
                                            height: 45,
                                            width: 45,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            "assets/team_placeholder.png",
                                            fit: BoxFit.contain,
                                            height: 45,
                                            width: 45,
                                          )),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 120,
                        child: widget.matchData.tossWinnerId.toString() ==
                                    widget.matchData.team1Id.toString() ||
                                widget.matchData.tossWinnerId.toString() ==
                                    widget.matchData.team2Id.toString()
                            ? Text(
                                widget.matchData.tossDecision.toString() ==
                                            "1" &&
                                        widget.matchData.tossWinnerId
                                                .toString() ==
                                            widget.matchData.team1Id.toString()
                                    ? "${getFirstLetters(widget.matchData.team1Name!)} is winner and elected to bat."
                                    : widget.matchData.tossDecision
                                                    .toString() ==
                                                "1" &&
                                            widget.matchData.tossWinnerId
                                                    .toString() ==
                                                widget.matchData.team2Id
                                                    .toString()
                                        ? "${getFirstLetters(widget.matchData.team2Name!)} is winner and elected to bat."
                                        : "-",
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
                              )
                            : Center(
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.timer,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  Text(
                                    DateFormat('h:mm a').format(DateFormat.Hm()
                                        .parse(widget.matchData.matchTime
                                            .toString())),
                                    style: const TextStyle(
                                        fontFamily: "Lato_Semibold",
                                        color: Colors.white,
                                        fontSize: 16),
                                  ),
                                ],
                              )),
                      ),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 45,
                            width: MediaQuery.sizeOf(context).width * 0.22,
                            decoration: BoxDecoration(
                              color: AppColor.yellowMed.withOpacity(0.4),
                            ),
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: const EdgeInsets.only(right: 20),
                              child: Text(
                                getFirstLetters(
                                    widget.matchData.team2Name.toString()),
                                style: const TextStyle(
                                    fontFamily: "Lato_Semibold",
                                    color: AppColor.white,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 40,
                                child: ClipOval(
                                    child: widget.matchData.team2Photo != null
                                        ? Image.network(
                                            mediaUrl +
                                                widget.matchData.team2Photo
                                                    .toString(),
                                            height: 45,
                                            width: 45,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            "assets/team_placeholder.png",
                                            fit: BoxFit.contain,
                                            height: 45,
                                            width: 45,
                                          )),
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.15,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                widget.from=="current"?TabBar(
                  controller: tabController,
                  labelColor: AppColor.yellowV2,
                  unselectedLabelColor: AppColor.grey,
                  indicatorColor: AppColor.yellowV2,
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        'My Contests(${myContestList.length})',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: tabController.index == 1
                              ? "Lato_Semibold"
                              : "Lato_Regular",
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'My Team(${myContestList.length})',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: tabController.index == 1
                              ? "Lato_Semibold"
                              : "Lato_Regular",
                        ),
                      ),
                    ),
                  ],
                ):TabBar(
                  controller: tabController,
                  labelColor: AppColor.yellowV2,
                  unselectedLabelColor: AppColor.grey,
                  indicatorColor: AppColor.yellowV2,
                  tabs: <Widget>[
                  Tab(
                      child: Text(
                        'Contests(${contestList.length})',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: tabController.index == 0
                              ? "Lato_Semibold"
                              : "Lato_Regular",
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'My Contests(${myContestList.length})',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: tabController.index == 1
                              ? "Lato_Semibold"
                              : "Lato_Regular",
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'My Team(${myContestList.length})',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: tabController.index == 1
                              ? "Lato_Semibold"
                              : "Lato_Regular",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: widget.from=="current"?TabBarView(
          controller: tabController,
          children: <Widget>[
            myContestList.isEmpty ? noDataFound() : myContestScreen(),
            myContestList.isEmpty ? noDataFound() : myTeamScreen(),
          ],
        ):TabBarView(
          controller: tabController,
          children: <Widget>[
            widget.from=="current"?const SizedBox(): contestList.isEmpty ? noDataFound() : contestScreen(),
            myContestList.isEmpty ? noDataFound() : myContestScreen(),
            myContestList.isEmpty ? noDataFound() : myTeamScreen(),
          ],
        ),
      ),
    );
  }

  contestScreen() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: contestList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              var isContestJoined = false;
              for (int i = 0; i < myContestList.length; i++) {
                if (myContestList[i].contestId == contestList[index].id) {
                  isContestJoined = true;
                }
              }
              if (isContestJoined &&
                  contestList[index].totalParticipants! < 10) {
                CommonFunctions()
                    .showToastMessage(context, "For this contest you can only join with one team.");
              } else {
                Navigator.push(
                    getContext,
                    MaterialPageRoute(
                        builder: (context) => ContestDetailScreen(
                              matchData: getMatchDetailData!,
                              contestData: contestList[index],
                            ))).then((value) {
                  if (value != null && value == "create_contest") {
                    Future.delayed(Duration.zero, () {
                      getContestListApi();
                    });
                    Future.delayed(Duration.zero, () {
                      getMyContestListApi();
                    });
                  }
                });
              }
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                            opacity: const AlwaysStoppedAnimation(.09),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Prize Pool",
                                    style: TextStyle(
                                        fontFamily: "Lato_Semibold",
                                        color: AppColor.brown2,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Entry",
                                    style: TextStyle(
                                        fontFamily: "Lato_Semibold",
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
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "₹${contestList[index].prizePool}",
                                    style: const TextStyle(
                                        fontFamily: "Lato_Semibold",
                                        color: AppColor.brown2,
                                        fontSize: 22),
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColor.green),
                                    child: Text(
                                      "₹${contestList[index].entryFee}",
                                      style: const TextStyle(
                                          fontFamily: "Lato_Semibold",
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
                                    colors: [AppColor.brown2, AppColor.red],
                                    // Define gradient colors
                                    begin: Alignment.centerLeft,
                                    // Define start point
                                    end: Alignment
                                        .centerRight, // Define end point
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      5.0), // Optional: border radius
                                ),
                                child: LinearProgressIndicator(
                                  value: (contestList[index].count! /
                                          contestList[index].totalParticipants!)
                                      .clamp(0.0, 1.0),
                                  backgroundColor: AppColor.grey,
                                  color: AppColor
                                      .orange_light, // Make background transparent
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${contestList[index].totalParticipants! - contestList[index].count!} spots left",
                                    style: const TextStyle(
                                        fontFamily: "Lato_Semibold",
                                        color: AppColor.red,
                                        fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "${contestList[index].totalParticipants!} spots",
                                    style: const TextStyle(
                                        fontFamily: "Lato_Semibold",
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
    );
  }

  replicateContestApi(var contestId) async {
    var request = {
      'contest_id': contestId.toString(),
    };
    await replicateContest(request).then((res) async {
      if (res.success == 1) {
      } else if (res.message == "Invalid Token" && res.code == 400) {
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

  myContestScreen() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: myContestList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  getContext,
                  MaterialPageRoute(
                      builder: (context) => ContestDetailScreen(
                            matchData: getMatchDetailData!,
                            contestData: contestList[index],
                            from: "my_contest",
                          ))).then((value) {
                if (value != null && value == "create_contest") {
                  Future.delayed(Duration.zero, () {
                    getContestListApi();
                  });
                }
              });
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                            opacity: const AlwaysStoppedAnimation(.09),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Prize Pool",
                                    style: TextStyle(
                                        fontFamily: "Lato_Semibold",
                                        color: AppColor.brown2,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Entry",
                                    style: TextStyle(
                                        fontFamily: "Lato_Semibold",
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
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "₹${myContestList[index].contestDetail!.prizePool!}",
                                    style: const TextStyle(
                                        fontFamily: "Lato_Semibold",
                                        color: AppColor.brown2,
                                        fontSize: 22),
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColor.green),
                                    child: Text(
                                      "₹${myContestList[index].contestDetail!.entryFee!}",
                                      style: const TextStyle(
                                          fontFamily: "Lato_Semibold",
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Number of winner",
                                    style: TextStyle(
                                        fontFamily: "Lato_Semibold",
                                        color: AppColor.brown2,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "${myContestList[index].contestDetail!.numberOfWinners!}",
                                    style: const TextStyle(
                                        fontFamily: "Lato_Semibold",
                                        color: AppColor.brown2,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  myTeamScreen() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: myContestList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  getContext,
                  MaterialPageRoute(
                      builder: (context) => PreviewTeamScreen(
                            players: myContestList[index].playerList!,
                            captainId: 0,
                            viceCaptainId: 0,
                          )));
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              elevation: 0.5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.9,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/team_bg.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              "Team ${index + 1}",
                              style: const TextStyle(
                                  fontFamily: "Lato_Bold",
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Card(
                                          color: Colors.white,
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundColor:
                                                  AppColor.greenDark,
                                              child: ClipOval(
                                                  child: Image.asset(
                                                "assets/player.png",
                                                fit: BoxFit.contain,
                                                height: 35,
                                                width: 35,
                                              )),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 25,
                                          width: 25,
                                          margin: const EdgeInsets.only(
                                              left: 35, top: 35),
                                          decoration: BoxDecoration(
                                            color: AppColor.orange_light,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "C",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: "Lato_Bold",
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 3),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: AppColor.brown3),
                                      child: Text(
                                        "${getCaptain(myContestList[index].playerList)}",
                                        style: const TextStyle(
                                            fontFamily: "Lato_Semibold",
                                            color: AppColor.white,
                                            fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Card(
                                          color: Colors.white,
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundColor:
                                                  AppColor.greenDark,
                                              child: ClipOval(
                                                  child: Image.asset(
                                                "assets/player.png",
                                                fit: BoxFit.contain,
                                                height: 35,
                                                width: 35,
                                              )),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 25,
                                          width: 25,
                                          margin: const EdgeInsets.only(
                                              left: 35, top: 35),
                                          decoration: BoxDecoration(
                                            color: AppColor.orange_light,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "VC",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: "Lato_Bold",
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 3),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: AppColor.brown3),
                                      child: Text(
                                        "${getViceCaptain(myContestList[index].playerList)}",
                                        style: const TextStyle(
                                            fontFamily: "Lato_Semibold",
                                            color: AppColor.white,
                                            fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  noDataFound() {
    return SizedBox(
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
                fontFamily: "Lato_Bold", color: AppColor.brown_0, fontSize: 16),
          )
        ],
      ),
    );
  }

  getViceCaptain(List<PlayerList>? playerList) {
    for (int i = 0; i < playerList!.length; i++) {
      if (playerList[i].isViceCaption == 1) {
        return playerList[i].playerName.toString();
      }
    }
    return "";
  }
}

class PlayerLists {
  List<PlayerList>? mainLis;

  PlayerLists({required List<PlayerList> mainLis}) {
    this.mainLis = mainLis;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is PlayerLists) {
      // Check if the mainLis lists have the same length
      if (this.mainLis!.length != other.mainLis!.length) return false;

      // Check if each element in the mainLis lists is equal
      for (int i = 0; i < this.mainLis!.length; i++) {
        if (this.mainLis![i] != other.mainLis![i]) return false;
      }
      return true;
    }

    return false;
  }

  @override
  int get hashCode => mainLis.hashCode;
}

getMergedTeamList(MyContestModel res) {
// Extract player data
  List<PlayerLists> main = [];
  List<PlayerList> allPlayers = [];
  for (var i = 0; i < res.body!.length; i++) {
    allPlayers.clear();
    PlayerLists list = PlayerLists(mainLis: []);
    list.mainLis = res.body![i].playerList!;
    main.add(list);
  }
  List<PlayerLists> mNewList = main.toSet().toList();

  print('Common Players: ${mNewList.length.toString()}');
}

List<Map<String, dynamic>> getSameItems(List<Map<String, dynamic>> inputList) {
  List<Map<String, dynamic>> result = [];
  Set<String> uniqueSet = Set<String>();

  for (var item in inputList) {
    // Sort the keys of the map to ensure consistent comparison
    List<String> sortedKeys = item.keys.toList()..sort();

    // Create a string representation of the sorted keys and values
    String keyValues = sortedKeys.map((key) => '${key}:${item[key]}').join(',');

    // If the string representation is not in the unique set, add it to the result
    if (!uniqueSet.contains(keyValues)) {
      result.add(item);
      uniqueSet.add(keyValues);
    }
  }

  return result;
}

bool containsDuplicate(PlayerList player, List<PlayerList> players) {
  for (var otherPlayer in players) {
    if (player.playerId == otherPlayer.playerId &&
        ((player.isCaptain == 1 && otherPlayer.isCaptain == 1) ||
            (player.isViceCaption == 1 && otherPlayer.isViceCaption == 1))) {
      return true;
    }
  }
  return false;
}

bool isCaptainViceCaptainDifferent(
    PlayerList player, List<PlayerList> allPlayers) {
  bool isCaptain = false;
  bool isViceCaptain = false;
  for (var otherPlayer in allPlayers) {
    if (otherPlayer.playerId != player.playerId) {
      if (otherPlayer.isCaptain == 1 && otherPlayer.teamId == player.teamId) {
        isCaptain = true;
      }
      if (otherPlayer.isViceCaption == 1 &&
          otherPlayer.teamId == player.teamId) {
        isViceCaptain = true;
      }
    }
  }
  return !(isCaptain && isViceCaptain);
}

void comparePlayerLists(List<dynamic> list1, List<dynamic> list2,
    List<dynamic> matched, List<dynamic> unique) {
  for (var player1 in list1) {
    var found = false;
    for (var player2 in list2) {
      if (player1['player_id'] == player2['player_id']) {
        matched.add(player1);
        found = true;
        break;
      }
    }
    if (!found) {
      var uniquePlayer = {
        'player_id': player1['player_id'],
        'player_type': player1['player_type'],
        'player_name': player1['player_name'],
        'team_name': player1['team_name'],
        'is_captain': player1['is_captain'],
        'is_vice_caption': player1['is_vice_caption']
      };
      unique.add(uniquePlayer);
    }
  }
}

String getCaptain(List<PlayerList>? playerList) {
  for (int i = 0; i < playerList!.length; i++) {
    if (playerList[i].isCaptain == 1) {
      return playerList[i].playerName.toString();
    }
  }
  return "";
}

class MyParallelogram extends CustomPainter {
  final bool isFlipped;

  MyParallelogram(this.isFlipped);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isFlipped ? Colors.green : Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.7, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.3, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
