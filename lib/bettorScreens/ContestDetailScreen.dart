import 'package:crick_team/loginSignupRelatedFiles/LoginScreen.dart';
import 'package:crick_team/main.dart';
import 'package:crick_team/modalClasses/ContestDetailModel.dart';
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
import 'MakeBettorTeam.dart';

class ContestDetailScreen extends StatefulWidget {
  final MatchDetailData matchData;
  final GetContestData contestData;
final String?from;
  const ContestDetailScreen(
      {super.key, required this.matchData, required this.contestData, this.from});

  @override
  State<ContestDetailScreen> createState() => _ContestDetailScreenState();
}

class _ContestDetailScreenState extends State<ContestDetailScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  List<GetContestData> contestList = [];
  List<MyContestData> myContestList = [];
  MatchDetailData? getMatchDetailData;
  ContestDetailData? contestDetailData;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getMatchDetailApi();
    });
    Future.delayed(Duration.zero, () {
      getContestDetailApi();
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

  Future getContestDetailApi() async {
    await getContestDetail(widget.contestData.id.toString()).then((res) async {
      hideLoader();
      if (res.success == 1) {
        setState(() {
          contestDetailData = res.body;
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
        preferredSize:widget.from=="my_contest"?Size.fromHeight(MediaQuery.sizeOf(context).height * 0.33): Size.fromHeight(MediaQuery.sizeOf(context).height * 0.41),
        child: AppBar(
          elevation: 0,
          backgroundColor: AppColor.brown2,
          scrolledUnderElevation: 0.0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${getFirstLetters(widget.matchData.team1Name.toString())} vs ${getFirstLetters(widget.matchData.team2Name.toString())}",
                style: const TextStyle(
                    fontFamily: "Lato_Semibold",
                    color: AppColor.white,
                    fontSize: 16),
              ),
              /*SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
              ),*/
            ],
          ),
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
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                                color: Colors.white,
                                opacity: const AlwaysStoppedAnimation(.09),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
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
                                            color: AppColor.brown3,
                                            fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "Entry",
                                        style: TextStyle(
                                            fontFamily: "Lato_Semibold",
                                            color: AppColor.brown3,
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
                                        "₹${widget.contestData.prizePool}",
                                        style: const TextStyle(
                                            fontFamily: "Lato_Semibold",
                                            color: AppColor.brown3,
                                            fontSize: 22),
                                        textAlign: TextAlign.center,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: AppColor.green),
                                        child: Text(
                                          "₹${widget.contestData.entryFee}",
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
                                      value: (widget.contestData.count! /
                                              widget.contestData
                                                  .totalParticipants!)
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
                                        "${widget.contestData.totalParticipants! - widget.contestData.count!} spots left",
                                        style: const TextStyle(
                                            fontFamily: "Lato_Semibold",
                                            color: AppColor.red,
                                            fontSize: 14),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "${widget.contestData.totalParticipants!} spots",
                                        style: const TextStyle(
                                            fontFamily: "Lato_Semibold",
                                            color: AppColor.brown3,
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
                      ],
                    ),
                  ),
                 widget.from=="my_contest"?SizedBox(): GestureDetector(
                    onTap: () {
                      // createContestApi();
                      Navigator.push(
                          getContext,
                          MaterialPageRoute(
                              builder: (context) =>   MakeBettorTeam(matchData: widget.matchData,contestData:widget.contestData,))).then((value) {
                        if (value != null && value == "create_contest") {
                          Future.delayed(Duration.zero, () {
                            Navigator.pop(context,"create_contest");
                          });
                        }
                      });
                    },
                    child: Card(
                        color: AppColor.grey,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        elevation: 0.2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              gradient:  LinearGradient(
                                colors: [
                                  Colors.green.shade700,
                                  Colors.green.shade700,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "JOIN CONTEST",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Lato_Bold",
                                      color: AppColor.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ))),
                  ),
                  TabBar(
                    controller: tabController,
                    labelColor: AppColor.orange_0,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: AppColor.orange_0,
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          'Winnings',
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
                          'Leaderboard',
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
      ),
      body: Container(
        color: Colors.white,
        child: TabBarView(
          controller: tabController,
          children: <Widget>[
            contestList.isEmpty ? noDataFound() : winningsScreen(),
            myContestList.isEmpty ? noDataFound() : leaderBoardScreen(),
          ],
        ),
      ),
    );
  }

  winningsScreen() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rank",
                  style: TextStyle(
                      fontFamily: "Lato_Semibold",
                      color: Colors.grey,
                      fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Winnings",
                  style: TextStyle(
                      fontFamily: "Lato_Semibold",
                      color: Colors.grey,
                      fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/trophy.png",
                      height: 15,
                      width: 15,
                      color: AppColor.yellowV2,
                    ),
                    Text(
                      "1",
                      style: TextStyle(
                          fontFamily: "Lato_Bold",
                          color: AppColor.brown2,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(
                      "assets/trophy.png",
                      height: 15,
                      width: 15,
                      color: AppColor.yellowV2,
                    ),
                  ],
                ),
                Text(
                  "₹${widget.contestData.prizePool}",
                  style: TextStyle(
                      fontFamily: "Lato_Semibold",
                      color: AppColor.brown2,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(height: 1,color: AppColor.grey,),
        ],
      ),
    );
  }



  leaderBoardScreen() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount:contestDetailData!.player!.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              color: AppColor.transparent,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
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
                                    contestDetailData!.player![index].userName == null
                                        ? "Player"
                                        : contestDetailData!.player![index].userName
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Lato_Semibold",
                                      color: AppColor.medGrey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )));
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
