import 'dart:convert';

import 'package:crick_team/bettorScreens/SelectCaptainAndVice.dart';
import 'package:crick_team/loginSignupRelatedFiles/LoginScreen.dart';
import 'package:crick_team/main.dart';
import 'package:crick_team/modalClasses/GetMatchModel.dart';
import 'package:crick_team/modalClasses/TeamSelected.dart';
import 'package:crick_team/utils/CommonFunctions.dart';
import 'package:crick_team/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apiRelatedFiles/rest_apis.dart';
import '../modalClasses/ScorerMatchModel.dart';
import '../scoreRelatedScreens/ScoreBoardscreen.dart';
import '../startMatchRelatedScreens/StartInningsScreen.dart';
import '../startMatchRelatedScreens/TossScreen.dart';
import '../utils/AppColor.dart';
import '../utils/constant.dart';
import '../utils/shared_pref.dart';

class MakeBettorTeam extends StatefulWidget {
  const MakeBettorTeam({super.key});

  @override
  State<MakeBettorTeam> createState() => _MakeBettorTeamState();
}

class _MakeBettorTeamState extends State<MakeBettorTeam>
    with TickerProviderStateMixin {
  late TabController tabController;
  List<UpcomingListArr> currentMatchList = [];
  List<UpcomingListArr> upcomingMatchList = [];
  List<UpcomingListArr> completedMatchList = [];
  List<Players> wicketKeeperList = [];
  List<Players> batingPlayerList = [];
  List<Players> allRounderList = [];
  List<Players> bowlList = [];
  List<Players> selectedPlayerList = [];
  int batCount = 0;
  int wkCount = 0;
  int arCount = 0;
  int bowlCount = 0;
  double _currentSliderValue = 11;

  @override
  void initState() {
    super.initState();
    selectedPlayerList.clear();
    tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    tabController.addListener(_handleTabSelection);
    Future.delayed(Duration.zero, () {
      getMatchListApi();
    });
  }

  void _handleTabSelection() {
    setState(() {});
  }

  Future getMatchListApi() async {
    await getMatchList().then((res) async {
      hideLoader();
      if (res.success == 1) {
        setState(() {
          currentMatchList = [];
          upcomingMatchList = [];
          completedMatchList = [];
          currentMatchList.addAll(res.body!.currentListArr!);
          upcomingMatchList.addAll(res.body!.upcomingListArr!);
          completedMatchList.addAll(res.body!.completedListArr!);
          allRounderList = [];
          batingPlayerList = [];
          bowlList = [];
          wicketKeeperList = [];
          // Parse JSON data
          List<dynamic> parsedJson =
              jsonDecode(res.body!.upcomingListArr![0].playerList.toString());
          // Create a list to hold player objects
          List<Players> players = [];
          // Add player objects to the list
          for (var json in parsedJson) {
            players.add(Players.fromJson(json));
          }
          for (int i = 0; i < players.length; i++) {
            if (players[i].playerType == "ALD") {
              allRounderList.add(players[i]);
            } else if (players[i].playerType == "BAT") {
              batingPlayerList.add(players[i]);
            } else if (players[i].playerType == "BOW") {
              bowlList.add(players[i]);
            } else if (players[i].playerType == "WK") {
              wicketKeeperList.add(players[i]);
            }
          }

          debugPrint("LENGTH__${wicketKeeperList.length}");
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
      appBar: PreferredSize(
        preferredSize:  Size.fromHeight(MediaQuery.sizeOf(context).height*0.3),
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
          title: const Center(
            child: Text(
              "Create Team",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Lato_Semibold",
                color: AppColor.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            /* Image.asset(
              "assets/wallet.png",
              height: 25,
              width: 25,
            ),
            const SizedBox(
              width: 5,
            ),*/
            GestureDetector(
              onTap: () {
                Navigator.push(
                    getContext,
                    MaterialPageRoute(
                        builder: (context) =>
                            SelectCaptainAndVice(players: selectedPlayerList)));
              },
              child: const Center(
                child: Text(
                  "Proceed",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Lato_Semibold",
                    color: AppColor.brown2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(200),
            child: Column(
              children: [
                Container(
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
                                  getFirstLetters(upcomingMatchList[0]
                                      .team2Name
                                      .toString()),
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
                                radius: 30,
                                child: ClipOval(
                                    child: Image.asset(
                                  "assets/team_placeholder.png",
                                  fit: BoxFit.cover,
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
                        child: Text(
                          upcomingMatchList[0].tossDecision.toString() == "1" &&
                                  upcomingMatchList[0]
                                          .tossWinnerId
                                          .toString() ==
                                      upcomingMatchList[0].team1Id.toString()
                              ? "${getFirstLetters(upcomingMatchList[0].team1Name!)} is winner and elected to bat."
                              : "${getFirstLetters(upcomingMatchList[0].team2Name!)} is winner and elected to bat.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
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
                                    upcomingMatchList[0].team1Name.toString()),
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
                                radius: 30,
                                child: ClipOval(
                                    child: Image.asset(
                                  "assets/team_placeholder.png",
                                  fit: BoxFit.cover,
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
                Text(
                  "Players ${selectedPlayerList.length}/11",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
                Container(margin: EdgeInsets.symmetric(vertical: 20),width: 600, child: Center(child: progressBar())),
                TabBar(
                  controller: tabController,
                  labelColor: AppColor.yellowV2,
                  unselectedLabelColor: AppColor.grey,
                  indicatorColor: AppColor.yellowV2,
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        'WK($wkCount)',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: tabController.index == 0
                              ? "Lato_Semibold"
                              : "Lato_Regular",
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'BAT($batCount)',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: tabController.index == 1
                              ? "Lato_Semibold"
                              : "Lato_Regular",
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'AR($arCount)',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: tabController.index == 2
                              ? "Lato_Semibold"
                              : "Lato_Regular",
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'BOWL($bowlCount)',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: tabController.index == 2
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
        child: TabBarView(
          controller: tabController,
          children: <Widget>[
            wicketKeeperList.isEmpty ? noDataFound() : wkScreen(),
            batingPlayerList.isEmpty ? noDataFound() : batScreen(),
            allRounderList.isEmpty ? noDataFound() : aRScreen(),
            bowlList.isEmpty ? noDataFound() : bowlScreen(),
          ],
        ),
      ),
    );
  }

  wkScreen() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: wicketKeeperList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (wicketKeeperList[index].playerSelected ||
                  selectedPlayerList.length < 11) {
                setState(() {
                  wicketKeeperList[index].playerSelected =
                      wicketKeeperList[index].playerSelected ? false : true;
                  wkCount = wicketKeeperList[index].playerSelected
                      ? wkCount + 1
                      : wkCount - 1;
                  if (wicketKeeperList[index].playerSelected) {
                    selectedPlayerList.add(wicketKeeperList[index]);
                  } else {
                    selectedPlayerList.remove(wicketKeeperList[index]);
                  }
                });
              } else {
                CommonFunctions().showToastMessage(
                    getContext, "Already 11 players selected.");
              }
            },
            child: Card(
                color: AppColor.transparent,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    decoration: BoxDecoration(
                      gradient: wicketKeeperList[index].playerSelected
                          ? const LinearGradient(
                              colors: [AppColor.red, AppColor.brown2],
                            )
                          : LinearGradient(
                              colors: [
                                AppColor.grey.withOpacity(0.2),
                                AppColor.grey.withOpacity(0.2),
                              ],
                            ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                      child: Image.asset(
                                    "assets/player.png",
                                    fit: BoxFit.contain,
                                    height: 45,
                                    width: 45,
                                  )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      wicketKeeperList[index].playerId == null
                                          ? "Player"
                                          : wicketKeeperList[index]
                                              .playerId
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Lato_Semibold",
                                        color: wicketKeeperList[index]
                                                .playerSelected
                                            ? Colors.white
                                            : AppColor.medGrey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          color: wicketKeeperList[index]
                                                  .playerSelected
                                              ? Colors.white
                                              : AppColor.medGrey,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          wicketKeeperList[index]
                                              .playerType
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Lato_Semibold",
                                            color: wicketKeeperList[index]
                                                    .playerSelected
                                                ? Colors.white
                                                : AppColor.medGrey,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          wicketKeeperList[index].playerSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : const SizedBox(),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ))),
          );
        },
      ),
    );
  }

  batScreen() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: batingPlayerList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (batingPlayerList[index].playerSelected ||
                  selectedPlayerList.length < 11) {
                setState(() {
                  batingPlayerList[index].playerSelected =
                      batingPlayerList[index].playerSelected ? false : true;
                  batCount = batingPlayerList[index].playerSelected
                      ? batCount + 1
                      : batCount - 1;
                  if (batingPlayerList[index].playerSelected) {
                    selectedPlayerList.add(batingPlayerList[index]);
                  } else {
                    selectedPlayerList.remove(batingPlayerList[index]);
                  }
                  /* for (int i = 0; i < batingPlayerList.length; i++) {
                    if (batingPlayerList[i].playerSelected) {
                      batCount = i;
                    } else {
                      batCount = i;
                    }
                  }*/
                });
              } else {
                CommonFunctions().showToastMessage(
                    getContext, "Already 11 players selected.");
              }
            },
            child: Card(
                color: AppColor.transparent,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    decoration: BoxDecoration(
                      gradient: batingPlayerList[index].playerSelected
                          ? const LinearGradient(
                              colors: [AppColor.red, AppColor.brown2],
                            )
                          : LinearGradient(
                              colors: [
                                AppColor.grey.withOpacity(0.2),
                                AppColor.grey.withOpacity(0.2),
                              ],
                            ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                      child: Image.asset(
                                    "assets/player.png",
                                    fit: BoxFit.contain,
                                    height: 45,
                                    width: 45,
                                  )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      batingPlayerList[index].playerId == null
                                          ? "Player"
                                          : batingPlayerList[index]
                                              .playerId
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Lato_Semibold",
                                        color: batingPlayerList[index]
                                                .playerSelected
                                            ? Colors.white
                                            : AppColor.medGrey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          color: batingPlayerList[index]
                                                  .playerSelected
                                              ? Colors.white
                                              : AppColor.medGrey,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          batingPlayerList[index]
                                              .playerType
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Lato_Semibold",
                                            color: batingPlayerList[index]
                                                    .playerSelected
                                                ? Colors.white
                                                : AppColor.medGrey,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          batingPlayerList[index].playerSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : const SizedBox(),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ))),
          );
        },
      ),
    );
  }

  aRScreen() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: allRounderList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (allRounderList[index].playerSelected ||
                  selectedPlayerList.length < 11) {
                setState(() {
                  allRounderList[index].playerSelected =
                      allRounderList[index].playerSelected ? false : true;
                  arCount = allRounderList[index].playerSelected
                      ? arCount + 1
                      : arCount - 1;
                  if (allRounderList[index].playerSelected) {
                    selectedPlayerList.add(allRounderList[index]);
                  } else {
                    selectedPlayerList.remove(allRounderList[index]);
                  }
                });
              } else {
                CommonFunctions().showToastMessage(
                    getContext, "Already 11 players selected.");
              }
            },
            child: Card(
                color: AppColor.transparent,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    decoration: BoxDecoration(
                      gradient: allRounderList[index].playerSelected
                          ? const LinearGradient(
                              colors: [AppColor.red, AppColor.brown2],
                            )
                          : LinearGradient(
                              colors: [
                                AppColor.grey.withOpacity(0.2),
                                AppColor.grey.withOpacity(0.2),
                              ],
                            ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                      child: Image.asset(
                                    "assets/player.png",
                                    fit: BoxFit.contain,
                                    height: 45,
                                    width: 45,
                                  )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      allRounderList[index].playerId == null
                                          ? "Player"
                                          : allRounderList[index]
                                              .playerId
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Lato_Semibold",
                                        color:
                                            allRounderList[index].playerSelected
                                                ? Colors.white
                                                : AppColor.medGrey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          color: allRounderList[index]
                                                  .playerSelected
                                              ? Colors.white
                                              : AppColor.medGrey,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          allRounderList[index]
                                              .playerType
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Lato_Semibold",
                                            color: allRounderList[index]
                                                    .playerSelected
                                                ? Colors.white
                                                : AppColor.medGrey,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          allRounderList[index].playerSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : const SizedBox(),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ))),
          );
        },
      ),
    );
  }

  bowlScreen() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: bowlList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (bowlList[index].playerSelected ||
                  selectedPlayerList.length < 11) {
                setState(() {
                  bowlList[index].playerSelected =
                      bowlList[index].playerSelected ? false : true;
                  bowlCount = bowlList[index].playerSelected
                      ? bowlCount + 1
                      : bowlCount - 1;
                  if (bowlList[index].playerSelected) {
                    selectedPlayerList.add(bowlList[index]);
                  } else {
                    selectedPlayerList.remove(bowlList[index]);
                  }
                });
              } else {
                CommonFunctions().showToastMessage(
                    getContext, "Already 11 players selected.");
              }
            },
            child: Card(
                color: AppColor.transparent,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    decoration: BoxDecoration(
                      gradient: bowlList[index].playerSelected
                          ? const LinearGradient(
                              colors: [AppColor.red, AppColor.brown2],
                            )
                          : LinearGradient(
                              colors: [
                                AppColor.grey.withOpacity(0.2),
                                AppColor.grey.withOpacity(0.2),
                              ],
                            ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                      child: Image.asset(
                                    "assets/player.png",
                                    fit: BoxFit.contain,
                                    height: 45,
                                    width: 45,
                                  )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bowlList[index].playerId == null
                                          ? "Player"
                                          : bowlList[index].playerId.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Lato_Semibold",
                                        color: bowlList[index].playerSelected
                                            ? Colors.white
                                            : AppColor.medGrey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          color: bowlList[index].playerSelected
                                              ? Colors.white
                                              : AppColor.medGrey,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          bowlList[index].playerType.toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Lato_Semibold",
                                            color:
                                                bowlList[index].playerSelected
                                                    ? Colors.white
                                                    : AppColor.medGrey,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          bowlList[index].playerSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : const SizedBox(),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ))),
          );
        },
      ),
    );
  }

  verifyScorerApi(UpcomingListArr getMatchData) async {
    var request = {
      'match_id': getMatchData.id.toString(),
      'scorer_id': getStringAsync(userId),
    };
    await verifyScorer(request).then((res) async {
      if (res.success == 1) {
        setState(() {
          setValue(bowlerRunsPerOver, [""]);
          ScorerMatchData scorerMatchData = res.body!;
          if (scorerMatchData.tossDecision > 0) {
            Navigator.push(
                getContext,
                MaterialPageRoute(
                    builder: (context) => StartInningsScreen(
                          matchData: getMatchData,
                          tossWinnerId: scorerMatchData.tossWinnerId.toString(),
                          tossWinnerElected:
                              scorerMatchData.tossDecision.toString(),
                          inningStatus: scorerMatchData.inningStatus.toString(),
                        )));
          } else {
            Navigator.push(
                getContext,
                MaterialPageRoute(
                    builder: (context) => TossScreen(
                          matchData: getMatchData,
                        )));
          }
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
        setValue(bowlerRunsPerOver, [""]);
        Navigator.push(
            getContext,
            MaterialPageRoute(
                builder: (context) =>
                    ScoreBoardScreen(getMatchData: getMatchData)));
        // builder: (context) =>  TossScreen(matchData:matchList[index])));
      }
    });
  }

  Widget progressBar() {
    List<Widget> list = [];
    double margin = 0;
    List<bool> selected = [];
    // int? selectedPlayers = 2;

    for (int i = 0; i < 11; i++) {
      if (i < selectedPlayerList.length) {
        selected.add(true);
      } else {
        selected.add(false);
      }
    }
    for (var i = 0; i < 11; i++) {
      list.add(
        Container(
          margin: EdgeInsets.only(left: margin),
          child: Stack(
            children: [
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.14159), // Flips horizontally
                child: SizedBox(
                  width: 30,
                  height: 15,
                  child: CustomPaint(
                    painter: MyParallelogram(selected[i]),
                  ),
                ),
              ),
              i==10?Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text((i+1).toString(),style: TextStyle(color:i==10? Colors.white:Colors.black,fontSize: 10),),
              ):SizedBox()
            ],
          ),
        ),
      );
      margin = margin + 25.0;
    }
    return Stack(children: list,);
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
                fontFamily: "Ubuntu_Bold",
                color: AppColor.brown_0,
                fontSize: 16),
          )
        ],
      ),
    );
  }
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
