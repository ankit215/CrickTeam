import 'package:crick_team/apiRelatedFiles/rest_apis.dart';
import 'package:crick_team/loginSignupRelatedFiles/LoginScreen.dart';
import 'package:crick_team/main.dart';
import 'package:crick_team/modalClasses/GetMatchModel.dart';
import 'package:crick_team/modalClasses/ScoreboardModel.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:crick_team/utils/CommonFunctions.dart';
import 'package:crick_team/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mainScreens/HomeScreen.dart';

class ScoreBoardScreen extends StatefulWidget {
  final UpcomingListArr getMatchData;

  const ScoreBoardScreen({super.key, required this.getMatchData});

  @override
  State<ScoreBoardScreen> createState() => _ScoreBoardScreenState();
}

class _ScoreBoardScreenState extends State<ScoreBoardScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  List<MatchModel> matchList = [
    MatchModel("India", "Ind", "Australia", "Aus", "37m 56s",
        "07:00 PM (03 Dec)", "assets/india.png", "assets/aus.png"),
    MatchModel("South Africa", "SA", "Sri Lanka", "SL", "37m 56s",
        "10:00 AM (05 Dec)", "assets/sl.png", "assets/sa.png"),
    MatchModel("Sri Lanka", "SL", "West Indies", "WI", "37m 56s",
        "07:00 PM (03 Dec)", "assets/sl.png", "assets/india.png"),
    MatchModel("India", "Ind", "Australia", "Aus", "37m 56s",
        "07:00 PM (03 Dec)", "assets/india.png", "assets/aus.png"),
    MatchModel("India", "Ind", "Australia", "Aus", "37m 56s",
        "07:00 PM (03 Dec)", "assets/india.png", "assets/aus.png"),
  ];
  GetScoreData? getScoreData;
  List<ScoreBoardBatting> battingList = [];
  List<ScoreBoardBatting> yetToBatList = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    Future.delayed(Duration.zero, () {
      getMatchScoreBoard(widget.getMatchData.team1Id.toString(),
          widget.getMatchData.team2Id.toString());
    });
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      if (tabController.index == 0) {
        Future.delayed(Duration.zero, () {
          getMatchScoreBoard(widget.getMatchData.team1Id.toString(),
              widget.getMatchData.team2Id.toString());
        });
      } else {
        getScoreData = null;
        battingList = [];
        yetToBatList = [];
        Future.delayed(Duration.zero, () {
          getMatchScoreBoard(widget.getMatchData.team2Id.toString(),
              widget.getMatchData.team1Id.toString());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0.0,
          leading: GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  "assets/back_arrow.png",
                  width: 15,
                  height: 15,
                ),
              ),
            ),
          ),
          title: Center(
            child: Text(
              '${widget.getMatchData.team1Name} vs ${widget.getMatchData.team2Name}',
              style: const TextStyle(
                fontSize: 20,
                fontFamily: "Lato_Semibold",
                color: AppColor.brown2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          actions: const <Widget>[
            SizedBox(
              width: 5,
            ),
            SizedBox(
              width: 15,
            )
          ],
          bottom: TabBar(
            controller: tabController,
            labelColor: AppColor.orange_light,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColor.orange_light,
            tabs: <Widget>[
              Tab(
                child: Text(
                  widget.getMatchData.team1Name.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: tabController.index == 0
                        ? "Lato_Semibold"
                        : "Lato_Regular",
                  ),
                ),
              ),
              Tab(
                child: Text(
                  widget.getMatchData.team2Name.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: tabController.index == 1
                        ? "Lato_Semibold"
                        : "Lato_Regular",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child:  TabBarView(
                controller: tabController,
                children: <Widget>[
                  getScoreData == null
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
                              fontFamily: "Lato_Bold",
                              color: AppColor.brown_0,
                              fontSize: 16),
                        )
                      ],
                    ),
                  )
                      : team1(),
                  getScoreData == null
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
                              fontFamily: "Lato_Bold",
                              color: AppColor.brown_0,
                              fontSize: 16),
                        )
                      ],
                    ),
                  )
                      :team2(),
                ],
              ),
      ),
    );
  }

  Widget team1() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.orange.shade50,
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Batter",
                  style: TextStyle(
                      fontFamily: "Lato_Semibold",
                      color: AppColor.brown2,
                      fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "R ",
                      style: TextStyle(
                          fontFamily: "Lato_Semibold",
                          color: AppColor.brown2,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "B ",
                      style: TextStyle(
                          fontFamily: "Lato_Semibold",
                          color: AppColor.brown2,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "4s",
                      style: TextStyle(
                          fontFamily: "Lato_Semibold",
                          color: AppColor.brown2,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "6s",
                      style: TextStyle(
                          fontFamily: "Lato_Semibold",
                          color: AppColor.brown2,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "SR",
                      style: TextStyle(
                          fontFamily: "Lato_Semibold",
                          color: AppColor.brown2,
                          fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
          ListView.builder(
            itemCount: battingList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.orange.withOpacity(0.05),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            battingList[index].playerName!,
                            style: const TextStyle(
                                fontFamily: "Lato_Regular",
                                color: AppColor.orange_0,
                                fontSize: 16),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                battingList[index].run!.toString(),
                                style: const TextStyle(
                                    fontFamily: "Lato_Regular",
                                    color: AppColor.brown3,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                battingList[index].balls!.toString(),
                                style: const TextStyle(
                                    fontFamily: "Lato_Regular",
                                    color: AppColor.brown3,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                battingList[index].fours!.toString(),
                                style: const TextStyle(
                                    fontFamily: "Lato_Regular",
                                    color: AppColor.brown3,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                battingList[index].sixs!.toString(),
                                style: const TextStyle(
                                    fontFamily: "Lato_Regular",
                                    color: AppColor.brown3,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                battingList[index].strikeRate!.toString(),
                                style: const TextStyle(
                                    fontFamily: "Lato_Regular",
                                    color: AppColor.brown3,
                                    fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        battingList[index].dismissalType!.toString() == "0" &&
                                battingList[index].position! > 0
                            ? "Not Out"
                            : battingList[index].dismissalType!.toString() ==
                                        "0" &&
                                    battingList[index].position == 0
                                ? "Yet to bat."
                                : "${getDissmissalType(battingList[index].dismissalType, battingList[index].fielderName!=null?battingList[index].fielderName.toString():"N/A")} ${battingList[index].bowlerName}",
                        style: TextStyle(
                            fontFamily: "Lato_Regular",
                            color:
                                battingList[index].dismissalType!.toString() ==
                                            "0" &&
                                        battingList[index].position! > 0
                                    ? AppColor.green
                                    : battingList[index]
                                                    .dismissalType!
                                                    .toString() ==
                                                "0" &&
                                            battingList[index].position == 0
                                        ? AppColor.blackDark
                                        : AppColor.red,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          getScoreData!.extraruns!.isNotEmpty
              ? Container(
                  color: AppColor.orange_light.withOpacity(0.1),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Extras",
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        "${getExtraTotalRuns(getScoreData!.extraruns!)} (${getExtraRuns(getScoreData!.extraruns!)})",
                        style: const TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                )
              : const Text(
                  "",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Lato_Bold",
                      fontSize: 12),
                ),
          yetToBatList.isNotEmpty
              ? Container(
                  color: AppColor.orange_light.withOpacity(0.1),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Yet to bat",
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 4,
                          scrollDirection: Axis.vertical,
                          children: List.generate(yetToBatList.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                yetToBatList[index].playerName! + ",",
                                style: TextStyle(color: AppColor.brown2),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                )
              : const Text(
                  "",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Lato_Bold",
                      fontSize: 12),
                ),
          bowlingTeamScreen()
        ],
      ),
    );
  }
  Widget team2() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.orange.shade50,
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Batter",
                  style: TextStyle(
                      fontFamily: "Lato_Semibold",
                      color: AppColor.brown2,
                      fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "R ",
                      style: TextStyle(
                          fontFamily: "Lato_Semibold",
                          color: AppColor.brown2,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "B ",
                      style: TextStyle(
                          fontFamily: "Lato_Semibold",
                          color: AppColor.brown2,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "4s",
                      style: TextStyle(
                          fontFamily: "Lato_Semibold",
                          color: AppColor.brown2,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "6s",
                      style: TextStyle(
                          fontFamily: "Lato_Semibold",
                          color: AppColor.brown2,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "SR",
                      style: TextStyle(
                          fontFamily: "Lato_Semibold",
                          color: AppColor.brown2,
                          fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
          ListView.builder(
            itemCount: battingList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.orange.withOpacity(0.05),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            battingList[index].playerName!,
                            style: const TextStyle(
                                fontFamily: "Lato_Regular",
                                color: AppColor.orange_0,
                                fontSize: 16),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                battingList[index].run!.toString(),
                                style: const TextStyle(
                                    fontFamily: "Lato_Regular",
                                    color: AppColor.brown3,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                battingList[index].balls!.toString(),
                                style: const TextStyle(
                                    fontFamily: "Lato_Regular",
                                    color: AppColor.brown3,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                battingList[index].fours!.toString(),
                                style: const TextStyle(
                                    fontFamily: "Lato_Regular",
                                    color: AppColor.brown3,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                battingList[index].sixs!.toString(),
                                style: const TextStyle(
                                    fontFamily: "Lato_Regular",
                                    color: AppColor.brown3,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                battingList[index].strikeRate!.toString(),
                                style: const TextStyle(
                                    fontFamily: "Lato_Regular",
                                    color: AppColor.brown3,
                                    fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        battingList[index].dismissalType!.toString() == "0" &&
                                battingList[index].position! > 0
                            ? "Not Out"
                            : battingList[index].dismissalType!.toString() ==
                                        "0" &&
                                    battingList[index].position == 0
                                ? "Yet to bat."
                                : "${getDissmissalType(battingList[index].dismissalType,battingList[index].fielderName!=null?battingList[index].fielderName.toString():"N/A")} ${battingList[index].bowlerName}",
                        style: TextStyle(
                            fontFamily: "Lato_Regular",
                            color:
                                battingList[index].dismissalType!.toString() ==
                                            "0" &&
                                        battingList[index].position! > 0
                                    ? AppColor.green
                                    : battingList[index]
                                                    .dismissalType!
                                                    .toString() ==
                                                "0" &&
                                            battingList[index].position == 0
                                        ? AppColor.blackDark
                                        : AppColor.red,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          getScoreData!.extraruns!.isNotEmpty
              ? Container(
                  color: AppColor.orange_light.withOpacity(0.1),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Extras",
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        "${getExtraTotalRuns(getScoreData!.extraruns!)} (${getExtraRuns(getScoreData!.extraruns!)})",
                        style: const TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                )
              : const Text(
                  "",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Lato_Bold",
                      fontSize: 12),
                ),
          yetToBatList.isNotEmpty
              ? Container(
                  color: AppColor.orange_light.withOpacity(0.1),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Yet to bat",
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 4,
                          scrollDirection: Axis.vertical,
                          children: List.generate(yetToBatList.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                yetToBatList[index].playerName! + ",",
                                style: TextStyle(color: AppColor.brown2),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                )
              : const Text(
                  "",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Lato_Bold",
                      fontSize: 12),
                ),
          bowlingTeamScreen()
        ],
      ),
    );
  }

  bowlingTeamScreen() {
    return Column(
      children: [
        Container(
          color: Colors.orange.shade50,
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bowler",
                style: TextStyle(
                    fontFamily: "Lato_Semibold",
                    color: AppColor.brown2,
                    fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "O ",
                    style: TextStyle(
                        fontFamily: "Lato_Semibold",
                        color: AppColor.brown2,
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    "M ",
                    style: TextStyle(
                        fontFamily: "Lato_Semibold",
                        color: AppColor.brown2,
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    "R ",
                    style: TextStyle(
                        fontFamily: "Lato_Semibold",
                        color: AppColor.brown2,
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    "W ",
                    style: TextStyle(
                        fontFamily: "Lato_Semibold",
                        color: AppColor.brown2,
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    "ER",
                    style: TextStyle(
                        fontFamily: "Lato_Semibold",
                        color: AppColor.brown2,
                        fontSize: 16),
                  ),
                ],
              )
            ],
          ),
        ),
        ListView.builder(
          itemCount: getScoreData!.scoreBoardBowler!.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.orange.withOpacity(0.05),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getScoreData!.scoreBoardBowler![index].bowlerName!,
                          style: const TextStyle(
                              fontFamily: "Lato_Regular",
                              color: AppColor.orange_0,
                              fontSize: 16),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formatOver(getScoreData!
                                      .scoreBoardBowler![index].balls!)
                                  .toString(),
                              style: const TextStyle(
                                  fontFamily: "Lato_Regular",
                                  color: AppColor.brown3,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              getScoreData!
                                  .scoreBoardBowler![index].maindersOver!
                                  .toString(),
                              style: const TextStyle(
                                  fontFamily: "Lato_Regular",
                                  color: AppColor.brown3,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              getScoreData!.scoreBoardBowler![index].runs!
                                  .toString(),
                              style: const TextStyle(
                                  fontFamily: "Lato_Regular",
                                  color: AppColor.brown3,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              getScoreData!.scoreBoardBowler![index].wicket!
                                  .toString(),
                              style: const TextStyle(
                                  fontFamily: "Lato_Regular",
                                  color: AppColor.brown3,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              getScoreData!.scoreBoardBowler![index].economy!
                                  .toString(),
                              style: const TextStyle(
                                  fontFamily: "Lato_Regular",
                                  color: AppColor.brown3,
                                  fontSize: 16),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ) /*Container(
                width: MediaQuery.sizeOf(context).width * 0.9,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    // AppColor.yellow.withOpacity(0.5),
                    AppColor.red.withOpacity(0.3),
                    AppColor.brown2.withOpacity(0.2),
                    // AppColor.yellowMed.withOpacity(0.5),
                  ]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).width * 0.35,
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/bats.png",
                          fit: BoxFit.cover,
                          height: 90,
                          width: 90,
                          opacity: const AlwaysStoppedAnimation(.09),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            Center(
                              child: Text(
                                "${matchList[index].teamAName} vs ${matchList[index].teamBName} T20",
                                style: const TextStyle(
                                    fontFamily: "Lato_Semibold",
                                    color: AppColor.brown2,
                                    fontSize: 16),
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  "assets/live.gif",
                                  height: 20,
                                  width: 60,
                                )),
                          ],
                        ),
                        Container(
                          height: 1,
                          color: AppColor.yellowV2,
                          margin: const EdgeInsets.only(top: 4),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                                      width:
                                          MediaQuery.sizeOf(context).width *
                                              0.29,
                                      padding:
                                          const EdgeInsets.only(right: 22),
                                      decoration: BoxDecoration(
                                        color: AppColor.yellowMed
                                            .withOpacity(0.4),
                                      ),
                                      child: const Text(
                                        "140/6 (20)",
                                        style: TextStyle(
                                            fontFamily: "Lato_Semibold",
                                            color: AppColor.brown2),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.2,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 30,
                                        child: ClipOval(
                                            child: Image.asset(
                                          matchList[index].teamAFlag!,
                                          fit: BoxFit.contain,
                                          height: 45,
                                          width: 45,
                                        )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 45,
                                    padding: const EdgeInsets.only(left: 20),
                                    width: MediaQuery.sizeOf(context).width *
                                        0.29,
                                    decoration: BoxDecoration(
                                      color:
                                          AppColor.yellowMed.withOpacity(0.4),
                                    ),
                                    child: const Text(
                                      "Yet To Bat",
                                      style: TextStyle(
                                          fontFamily: "Lato_Semibold"),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 30,
                                        child: ClipOval(
                                            child: Image.asset(
                                          matchList[index].teamBFlag!,
                                          fit: BoxFit.contain,
                                          height: 45,
                                          width: 45,
                                        )),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.2,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                            color: AppColor.yellowMed.withOpacity(0.4),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.timer,
                                color: Colors.red,
                                size: 20,
                              ),
                              Text(
                                matchList[index].matchTimeRemaining!,
                                style: const TextStyle(
                                    fontFamily: "Lato_Semibold",
                                    color: Colors.red,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )*/
              ,
            );
          },
        ),
      ],
    );
  }

  Future getMatchScoreBoard(String teamId, String team2Id) async {
    await getScoreboard(widget.getMatchData.id.toString(), teamId, team2Id)
        .then((res) async {
      hideLoader();
      if (res.success == 1) {
        setState(() {
          getScoreData = res.body;
          debugPrint("getScoreData__$getScoreData");
          battingList.clear();
          yetToBatList.clear();

          /* for (int i = 0; i < getScoreData!.scoreBoardBatting!.length; i++) {
            if (getScoreData!.scoreBoardBatting![i].dismissalType!.toString() == "0" &&
                getScoreData!.scoreBoardBatting![i].position != 0) {
              battingList.add(getScoreData!.scoreBoardBatting![i]);
            }
          }*/
          for (int i = 0; i < getScoreData!.scoreBoardBatting!.length; i++) {
            if (getScoreData!.scoreBoardBatting![i].dismissalType!.toString() == "0" ) {
              yetToBatList.add(getScoreData!.scoreBoardBatting![i]);
            } else {
              battingList.add(getScoreData!.scoreBoardBatting![i]);
            }
          }
          debugPrint("${yetToBatList.length}  Lemnfgngng");
          debugPrint("${battingList.length}  getScoreData!.scoreBoardBowler!");
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
        debugPrint("${res.message!}  401 MESSAGE");
        // CommonFunctions().showToastMessage(context, res.message!);
      }
    });
  }

  double formatOver(int balls) {
    int overs = (balls / 6).floor();
    int remainingBalls = balls % 6;
    return overs + remainingBalls / 10;
  }

  getDissmissalType(String? dismissalType, String fielderName) {
    var type = "";
    if (dismissalType == "1") {
      type = "b";
    } else if (dismissalType == "2") {
      type = "c $fielderName b";
    } else if (dismissalType == "5") {
      type = "st b";
    } else if (dismissalType == "6") {
      type = "run out";
    } else if (dismissalType == "7") {
      type = "lbw b";
    } else if (dismissalType == "8") {
      type = "retired hurt";
    }
    return type;
  }

  getExtraType(int? typeExtra) {
    var type = "";
    if (typeExtra == 8) {
      type = "w";
    } else if (typeExtra == 9) {
      type = "nb";
    } else if (typeExtra == 10) {
      type = "b";
    } else if (typeExtra == 11) {
      type = "lb";
    }
    return type;
  }

  getExtraRuns(List<Extraruns> list) {
    var extras = [];
    for (int i = 0; i < list.length; i++) {
      extras.add(" ${getExtraType(list[i].type)} ${list[i].count}");
    }
    return extras.join(",");
  }

  getExtraTotalRuns(List<Extraruns> list) {
    var extras = [];
    for (int i = 0; i < list.length; i++) {
      extras.add(list[i].count);
    }
    int total = extras.reduce((value, element) => value + element);
    return total;
  }
}
