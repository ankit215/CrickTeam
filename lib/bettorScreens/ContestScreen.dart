import 'package:crick_team/loginSignupRelatedFiles/LoginScreen.dart';
import 'package:crick_team/main.dart';
import 'package:crick_team/modalClasses/GetMatchModel.dart';
import 'package:crick_team/modalClasses/MyContestModel.dart';
import 'package:crick_team/utils/CommonFunctions.dart';
import 'package:crick_team/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apiRelatedFiles/rest_apis.dart';
import '../modalClasses/GetContestModel.dart';
import '../modalClasses/MatchDetailModel.dart';
import '../utils/AppColor.dart';
import 'ContestDetailScreen.dart';
import 'MakeBettorTeam.dart';

class ContestScreen extends StatefulWidget {
  final UpcomingListArr matchData;

  const ContestScreen({super.key, required this.matchData});

  @override
  State<ContestScreen> createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  List<GetContestData> contestList = [];
  List<MyContestData> myContestList = [];
  MatchDetailData ?getMatchDetailData;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getMatchDetailApi();
    });

    tabController = TabController(
      initialIndex: 0,
      length: 2,
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
          for(int i =0;i<contestList.length;i++){
            if(contestList[i].count==contestList[i].totalParticipants){
              replicateContestApi(contestList[i].id.toString());
            }
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
            ();
          });
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
                                      widget.matchData.team2Name.toString()),
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
                                style: TextStyle(color: Colors.white),
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
                                    widget.matchData.team1Name.toString()),
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
                TabBar(
                  controller: tabController,
                  labelColor: AppColor.yellowV2,
                  unselectedLabelColor: AppColor.grey,
                  indicatorColor: AppColor.yellowV2,
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        'Contests(${contestList.length})',
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
                        'My Contests(${myContestList.length})',
                        style: TextStyle(
                          fontSize: 16,
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
        child: TabBarView(
          controller: tabController,
          children: <Widget>[
            contestList.isEmpty ? noDataFound() : contestScreen(),
            myContestList.isEmpty ? noDataFound() : myContestScreen(),
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
                                    padding: EdgeInsets.symmetric(
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
                                  value: (contestList[index].count! / contestList[index].totalParticipants!).clamp(0.0, 1.0),                                  backgroundColor: AppColor.grey,
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
                      builder: (context) =>   ContestDetailScreen(matchData:getMatchDetailData!,contestData: contestList[index],from: "my_contest",))).then((value) {
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
                                    "₹${myContestList[index].contestId}",
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
                                      "₹${myContestList[index].id}",
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
                                child: const LinearProgressIndicator(
                                  value: 0.1, // Adjust value as needed
                                  backgroundColor: AppColor.grey,
                                  color: AppColor
                                      .orange_light, // Make background transparent
                                ),
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
