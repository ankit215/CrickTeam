import 'package:crick_team/bettorScreens/MakeBettorTeam.dart';
import 'package:crick_team/bettorScreens/SelectCaptainAndVice.dart';
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
import '../modalClasses/UserTeamDetailModel.dart';
import '../utils/AppColor.dart';
import 'ContestDetailScreen.dart';
import 'PreviewTeamScreen.dart';

class TeamListScreen extends StatefulWidget {
  final MatchDetailData matchData;
  final GetContestData contestData;
  final String? from;
  final String? userId;

  const TeamListScreen(
      {super.key,
      required this.matchData,
      required this.contestData,
      this.from, this.userId});

  @override
  State<TeamListScreen> createState() => _TeamListScreenState();
}

class _TeamListScreenState extends State<TeamListScreen> {
  List<GetContestData> contestList = [];
  List<MyContestData> myContestList = [];
  List<SelectedTeam> selectedTeamList = [];
  MatchDetailData? getMatchDetailData;

  @override
  void initState() {
    super.initState();
    if (widget.from == "bettor_teams") {
      Future.delayed(Duration.zero, () {
        getTeamDetailApi();
      });
    } else {
      Future.delayed(Duration.zero, () {
        getMatchDetailApi();
      });
    }
  }



  Future getTeamDetailApi() async {
    await getUserTeamDetail(widget.contestData.id.toString(),widget.userId!).then((res) async {
      hideLoader();
      if (res.success == 1) {
        setState(() {
          selectedTeamList.clear();
          selectedTeamList.addAll(res.body!.selectedTeam!);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.brown2,
        scrolledUnderElevation: 0.0,
        title: const Text(
          "My Teams",
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Lato_Semibold",
            color: AppColor.white,
          ),
          textAlign: TextAlign.center,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(
              "assets/back_arrow.png",
              height: 20,
              width: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(color: Colors.white, child: widget.from=="bettor_teams"?myTeamScreen2():myTeamScreen()),
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

  myTeamScreen() {
    return Column(
      children: [
        Expanded(
          child: Container(
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
                            builder: (context) => SelectCaptainAndVice(
                                  matchData: widget.matchData,
                                  contestData: widget.contestData,
                                  players: myContestList[index].playerList!,
                                  from: 'team_list',
                                ))).then((value) {
                      if (value != null && value == "create_contest") {
                        Future.delayed(Duration.zero, () {
                          Navigator.pop(context, "create_contest");
                        });
                      }
                    });
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
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
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
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
                                                      fontWeight:
                                                          FontWeight.w900,
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
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
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
                                                      fontWeight:
                                                          FontWeight.w900,
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
          ),
        ),
        GestureDetector(
          onTap: () {
            // createContestApi();
            Navigator.push(
                getContext,
                MaterialPageRoute(
                    builder: (context) => MakeBettorTeam(
                          matchData: widget.matchData,
                          contestData: widget.contestData,
                        ))).then((value) {
              if (value != null && value == "create_contest") {
                Future.delayed(Duration.zero, () {
                  Navigator.pop(context, "create_contest");
                });
              }
            });
          },
          child: Card(
              color: AppColor.grey,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              elevation: 0.2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColor.brown2,
                        AppColor.brown2,
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
                          "+ Create New Team",
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
        const SizedBox(height: 30)
      ],
    );
  }

  myTeamScreen2() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            getContext,
            MaterialPageRoute(
                builder: (context) => PreviewTeamScreen(
                  captainId: 0,
                  viceCaptainId: 0,
                  players2: selectedTeamList,
                ))).then((value) {
          if (value != null && value == "create_contest") {
            Future.delayed(Duration.zero, () {
              Navigator.pop(context, "create_contest");
            });
          }
        });
      },
      child: Card(
        margin:
        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        elevation: 0.5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.9,
          height: 190,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/team_bg.png'),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Team ${1}",
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
                                  BorderRadius.circular(
                                      30.0),
                                ),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.all(3.0),
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
                                      fontWeight:
                                      FontWeight.w900,
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
                              getCaptain2(selectedTeamList),
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
                                  BorderRadius.circular(
                                      30.0),
                                ),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.all(3.0),
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
                                      fontWeight:
                                      FontWeight.w900,
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
                              "${getViceCaptain2(selectedTeamList)}",
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
        ),
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
  getViceCaptain2(List<SelectedTeam>? playerList) {
    for (int i = 0; i < playerList!.length; i++) {
      if (playerList[i].isViceCaption == 1) {
        return playerList[i].playerName.toString();
      }
    }
    return "";
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
String getCaptain2(List<SelectedTeam>? playerList) {
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
