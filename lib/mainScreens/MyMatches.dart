import 'package:crick_team/loginSignupRelatedFiles/LoginScreen.dart';
import 'package:crick_team/main.dart';
import 'package:crick_team/modalClasses/GetMatchModel.dart';
import 'package:crick_team/utils/CommonFunctions.dart';
import 'package:crick_team/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apiRelatedFiles/rest_apis.dart';
import '../bettorScreens/ContestScreen.dart';
import '../modalClasses/ScorerMatchModel.dart';
import '../scoreRelatedScreens/ScoreBoardscreen.dart';
import '../startMatchRelatedScreens/StartInningsScreen.dart';
import '../startMatchRelatedScreens/TossScreen.dart';
import '../utils/AppColor.dart';
import '../utils/constant.dart';
import '../utils/shared_pref.dart';
import 'HomeScreen.dart';

class MyMatches extends StatefulWidget {
  const MyMatches({super.key});

  @override
  State<MyMatches> createState() => _MyMatchesState();
}

class _MyMatchesState extends State<MyMatches> with TickerProviderStateMixin {
  late TabController tabController;
  List<UpcomingListArr> currentMatchList = [];
  List<UpcomingListArr> upcomingMatchList = [];
  List<UpcomingListArr> completedMatchList = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    tabController.addListener(_handleTabSelection);
    Future.delayed(Duration.zero, () {
      getMatchListApi();
    });
    Future.delayed(Duration.zero, () {
      getWalletAmountApi();
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
  Future getWalletAmountApi() async {
    await getWalletAmount(getStringAsync(userId)).then((res) async {
      hideLoader();
      if (res.success == 1) {
        setState(() {
          setValue(wallet_amount, res.body!.amount!);
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
          leading: GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.only(left: 5, top: 5),
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 24,
                    child: ClipOval(
                        child: Image.asset(
                      "assets/manager.png",
                      fit: BoxFit.contain,
                      height: 70,
                      width: 70,
                    )),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: AppColor.white,
                        child: ClipOval(
                            child: Image.asset(
                          "assets/menu.png",
                          fit: BoxFit.contain,
                          height: 20,
                          width: 20,
                        )),
                      )),
                ],
              ),
            ),
          ),
          title: const Center(
            child: Text(
              "My Matches",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Lato_Semibold",
                color: AppColor.brown2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            getIntAsync(accountType)==2? Image.asset(
              "assets/wallet.png",
              height: 25,
              width: 25,
            ):const SizedBox(),
            const SizedBox(
              width: 5,
            ),
            getIntAsync(accountType)==2? Text(
              getIntAsync(wallet_amount).toString(),
              style: const TextStyle(
                fontSize: 18,
                fontFamily: "Lato_Semibold",
                color: AppColor.brown2,
              ),
              textAlign: TextAlign.center,
            ):const SizedBox(),
            const SizedBox(
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
                  "Current",
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
                  "Upcoming",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: tabController.index == 1
                        ? "Lato_Semibold"
                        : "Lato_Regular",
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Completed",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: tabController.index == 2
                        ? "Lato_Semibold"
                        : "Lato_Regular",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: TabBarView(
          controller: tabController,
          children: <Widget>[
            currentMatchList.isEmpty
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
                : currentScreen(),
            upcomingMatchList.isEmpty
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
                : upcomingScreen(),
            completedMatchList.isEmpty
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
                : completedScreen(),
          ],
        ),
      ),
    );
  }

  currentScreen() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: currentMatchList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (getIntAsync(accountType) == 3) {
                verifyScorerApi(currentMatchList[index]);
              } else if (getIntAsync(accountType) == 2) {
                Navigator.push(
                    getContext,
                    MaterialPageRoute(
                        builder: (context) => ContestScreen(
                            from: "current",
                            matchData: currentMatchList[index])));
              } else {
                setValue(bowlerRunsPerOver, [""]);
                Navigator.push(
                    getContext,
                    MaterialPageRoute(
                        builder: (context) => ScoreBoardScreen(
                            getMatchData: currentMatchList[index])));
                // builder: (context) =>  TossScreen(matchData:matchList[index])));
              }
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
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
                                "${currentMatchList[index].team1Name} vs ${currentMatchList[index].team2Name}",
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
                                      width: MediaQuery.sizeOf(context).width *
                                          0.29,
                                      padding: const EdgeInsets.only(right: 22),
                                      decoration: BoxDecoration(
                                        color:
                                            AppColor.yellowMed.withOpacity(0.4),
                                      ),
                                      child: Text(
                                        currentMatchList[index]
                                            .team1Name
                                            .toString(),
                                        style: const TextStyle(
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
                                        radius: 40,
                                        child: ClipOval(
                                            child: currentMatchList[index]
                                                        .team1Photo !=
                                                    null
                                                ? Image.network(
                                                    mediaUrl +
                                                        currentMatchList[index]
                                                            .team1Photo
                                                            .toString(),
                                                    height: 50,
                                                    width: 50,
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
                              Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 45,
                                    padding: const EdgeInsets.only(left: 20),
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.29,
                                    decoration: BoxDecoration(
                                      color:
                                          AppColor.yellowMed.withOpacity(0.4),
                                    ),
                                    child: Text(
                                      currentMatchList[index]
                                          .team2Name
                                          .toString(),
                                      style: const TextStyle(
                                          fontFamily: "Lato_Semibold"),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 40,
                                        child: ClipOval(
                                            child: currentMatchList[index]
                                                        .team2Photo !=
                                                    null
                                                ? Image.network(
                                                    mediaUrl +
                                                        currentMatchList[index]
                                                            .team2Photo
                                                            .toString(),
                                                    height: 50,
                                                    width: 50,
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
                                DateFormat('h:mm a').format(DateFormat.Hm()
                                    .parse(currentMatchList[index]
                                        .matchTime
                                        .toString())),
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
              ),
            ),
          );
        },
      ),
    );
  }

  upcomingScreen() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: upcomingMatchList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (getIntAsync(accountType) == 3) {
                verifyScorerApi(upcomingMatchList[index]);
              } else if (getIntAsync(accountType) == 2) {
                Navigator.push(
                    getContext,
                    MaterialPageRoute(
                        builder: (context) => ContestScreen(
                            from: "current",
                            matchData: upcomingMatchList[index])));
              } else {
                setValue(bowlerRunsPerOver, [""]);
                Navigator.push(
                    getContext,
                    MaterialPageRoute(
                        builder: (context) => ScoreBoardScreen(
                            getMatchData: upcomingMatchList[index])));
                // builder: (context) =>  TossScreen(matchData:matchList[index])));
              }
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.9,
                height: MediaQuery.sizeOf(context).width * 0.35,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    // AppColor.yellow.withOpacity(0.5),
                    AppColor.yellowV2.withOpacity(0.3),
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
                        Center(
                            child: Text(
                          "${upcomingMatchList[index].team1Name} vs ${upcomingMatchList[index].team2Name}",
                          style: const TextStyle(
                              fontFamily: "Lato_Semibold",
                              color: AppColor.brown2,
                              fontSize: 16),
                        )),
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
                                      width: MediaQuery.sizeOf(context).width *
                                          0.19,
                                      decoration: BoxDecoration(
                                        color:
                                            AppColor.yellowMed.withOpacity(0.4),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.1,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 40,
                                        child: ClipOval(
                                            child: upcomingMatchList[index]
                                                        .team1Photo !=
                                                    null
                                                ? Image.network(
                                                    mediaUrl +
                                                        upcomingMatchList[index]
                                                            .team1Photo
                                                            .toString(),
                                                    height: 50,
                                                    width: 50,
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
                              Column(
                                children: [
                                  const Icon(
                                    Icons.timer,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  Text(
                                    DateFormat('h:mm a').format(DateFormat.Hm()
                                        .parse(upcomingMatchList[index]
                                            .matchTime
                                            .toString())),
                                    style: const TextStyle(
                                        fontFamily: "Lato_Semibold",
                                        color: Colors.red,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 45,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.2,
                                    decoration: BoxDecoration(
                                      color:
                                          AppColor.yellowMed.withOpacity(0.4),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 40,
                                        child: ClipOval(
                                            child: upcomingMatchList[index]
                                                        .team2Photo !=
                                                    null
                                                ? Image.network(
                                                    mediaUrl +
                                                        upcomingMatchList[index]
                                                            .team2Photo
                                                            .toString(),
                                                    height: 50,
                                                    width: 50,
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
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.1,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          DateFormat('h:mm a').format(DateFormat.Hm().parse(
                              upcomingMatchList[index].matchTime.toString())),
                          style: const TextStyle(
                              fontFamily: "Lato_Semibold",
                              color: AppColor.brown2,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
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

  completedScreen() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: completedMatchList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  getContext,
                  MaterialPageRoute(
                      builder: (context) => ScoreBoardScreen(
                          getMatchData: completedMatchList[index])));
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.9,
                height: MediaQuery.sizeOf(context).width * 0.35,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    // AppColor.yellow.withOpacity(0.5),
                    AppColor.yellowV2.withOpacity(0.1),
                    AppColor.yellowV2.withOpacity(0.1),
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
                        Center(
                            child: Text(
                          "${completedMatchList[index].team1Name} vs ${completedMatchList[index].team2Name}",
                          style: const TextStyle(
                              fontFamily: "Lato_Semibold",
                              color: AppColor.brown2,
                              fontSize: 16),
                        )),
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
                                      width: MediaQuery.sizeOf(context).width *
                                          0.19,
                                      decoration: BoxDecoration(
                                        color:
                                            AppColor.yellowMed.withOpacity(0.4),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.1,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 40,
                                        child: ClipOval(
                                            child: completedMatchList[index]
                                                        .team1Photo !=
                                                    null
                                                ? Image.network(
                                                    mediaUrl +
                                                        completedMatchList[
                                                                index]
                                                            .team1Photo
                                                            .toString(),
                                                    height: 50,
                                                    width: 50,
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
                              Text(
                                completedMatchList[index].matchDate!,
                                style: const TextStyle(
                                    fontFamily: "Lato_Semibold",
                                    color: AppColor.brown2,
                                    fontSize: 16),
                              ),
                              /*Expanded(
                                child: Text(
                                    completedMatchList[index].matchResult==completedMatchList[index].team1Id?"${completedMatchList[index].team1Name} won the match":completedMatchList[index].matchResult==completedMatchList[index].team2Id?"${completedMatchList[index].team2Name} won the match":"",
                                  style: const TextStyle(
                                      fontFamily: "Lato_Semibold",
                                      color: AppColor.brown2,
                                      fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),*/
                              Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 45,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.2,
                                    decoration: BoxDecoration(
                                      color:
                                          AppColor.yellowMed.withOpacity(0.4),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 40,
                                        child: ClipOval(
                                            child: completedMatchList[index]
                                                        .team2Photo !=
                                                    null
                                                ? Image.network(
                                                    mediaUrl +
                                                        completedMatchList[
                                                                index]
                                                            .team2Photo
                                                            .toString(),
                                                    height: 50,
                                                    width: 50,
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
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.1,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/winner.png",
                              height: 25,
                              width: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                completedMatchList[index].matchResult ==
                                        completedMatchList[index].team1Id
                                    ? "${completedMatchList[index].team1Name} won the match"
                                    : completedMatchList[index].matchResult ==
                                            completedMatchList[index].team2Id
                                        ? "${completedMatchList[index].team2Name} won the match"
                                        : "",
                                style: const TextStyle(
                                    fontFamily: "Lato_Semibold",
                                    color: AppColor.orange,
                                    fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Image.asset(
                              "assets/winner.png",
                              height: 25,
                              width: 25,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
