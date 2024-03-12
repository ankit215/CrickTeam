import 'dart:convert';

import 'package:crick_team/modalClasses/GetContestModel.dart';
import 'package:crick_team/modalClasses/GetMatchModel.dart';
import 'package:crick_team/modalClasses/MatchDetailModel.dart';
import 'package:crick_team/utils/search_delay_function.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:flutter/material.dart';
import '../modalClasses/MyContestModel.dart';

class PreviewTeamScreen extends StatefulWidget {
  final List<PlayerList> players;
  final int captainId;
  final int viceCaptainId;

  const PreviewTeamScreen(
      {super.key,
      required this.players,
      required this.captainId,
      required this.viceCaptainId});

  @override
  State<PreviewTeamScreen> createState() => _PreviewTeamScreenState();
}

class _PreviewTeamScreenState extends State<PreviewTeamScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final searchDelay = SearchDelayFunction();
  var searchStr = "";
  List<PlayerList> wicketKeeperList = [];
  List<PlayerList> batingPlayerList = [];
  List<PlayerList> allRounderList = [];
  List<PlayerList> bowlList = [];
  int? captainId;
  int? viceCaptainId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("Captain_${widget.captainId}");
    debugPrint("VVVCaptain_${widget.viceCaptainId}");
    if (widget.captainId == 0) {
      for (int i = 0; i < widget.players.length; i++) {
        if (widget.players[i].isCaptain == 1) {
          captainId = widget.players[i].playerId!;
        } else if (widget.players[i].isViceCaption == 1) {
          viceCaptainId = widget.players[i].playerId!;
        }
      }
    }else{
      captainId = widget.captainId;
      viceCaptainId = widget.viceCaptainId;
    }
    Future.delayed(Duration.zero, () {
      getMatchListApi();
    });
  }

  final double runSpacing = 4;
  final double spacing = 4;
  final columns = 4;

  Future getMatchListApi() async {
    setState(() {
      allRounderList = [];
      batingPlayerList = [];
      bowlList = [];
      wicketKeeperList = [];
      // Parse JSON data
      List<dynamic> parsedJson = jsonDecode(jsonEncode(widget.players));
      // Create a list to hold player objects
      List<PlayerList> players = [];
      // Add player objects to the list
      for (var json in parsedJson) {
        players.add(PlayerList.fromJson(json));
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

      debugPrint("LENGTHfrf__${wicketKeeperList[0].isCaptain}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = (MediaQuery.of(context).size.width - runSpacing * (columns - 1)) /
        columns;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        /* appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: AppColor.brown2,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context, "add_teams");
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
            "Choose your Captain and Vice Captain",
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Lato_Semibold",
              color: AppColor.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),*/
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/ground_back_cleanup.jpeg'),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, "add_teams");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset(
                        "assets/back_arrow.png",
                        height: 30,
                        width: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Wicket-Keeper",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
                SingleChildScrollView(
                  child: Wrap(
                    runSpacing: runSpacing,
                    spacing: spacing,
                    alignment: WrapAlignment.center,
                    children: List.generate(wicketKeeperList.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                      backgroundColor: AppColor.greenDark,
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
                                wicketKeeperList[index].playerId ==
                                            captainId ||
                                        wicketKeeperList[index].playerId ==
                                            viceCaptainId
                                    ? Container(
                                        height: 25,
                                        width: 25,
                                        margin: const EdgeInsets.only(
                                            left: 30, top: 35),
                                        decoration: BoxDecoration(
                                          color: AppColor.red,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Text(
                                            wicketKeeperList[index].playerId ==
                                                captainId
                                                ? "C"
                                                : "VC",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: "Lato_Bold",
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: AppColor.brown3),
                              child: Text(
                                "${wicketKeeperList[index].playerName}",
                                style: const TextStyle(
                                    fontFamily: "Lato_Semibold",
                                    color: AppColor.white,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const Text(
                  "Batter",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
                SingleChildScrollView(
                  child: Wrap(
                    runSpacing: runSpacing,
                    spacing: spacing,
                    alignment: WrapAlignment.center,
                    children: List.generate(batingPlayerList.length, (index) {
                      return Padding(
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
                                      backgroundColor: AppColor.greenDark,
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
                                batingPlayerList[index].playerId ==
                                    captainId ||
                                        batingPlayerList[index].playerId ==
                                            viceCaptainId
                                    ? Container(
                                        height: 25,
                                        width: 25,
                                        margin: const EdgeInsets.only(
                                            left: 30, top: 35),
                                        decoration: BoxDecoration(
                                          color: AppColor.red,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Text(
                                            batingPlayerList[index].playerId ==
                                                    captainId
                                                ? "C"
                                                : "VC",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: "Lato_Bold",
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: AppColor.brown3),
                              child: Text(
                                "${batingPlayerList[index].playerName}",
                                style: const TextStyle(
                                    fontFamily: "Lato_Semibold",
                                    color: AppColor.white,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const Text(
                  "All-Rounder",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
                SingleChildScrollView(
                  child: Wrap(
                    runSpacing: runSpacing,
                    spacing: spacing,
                    alignment: WrapAlignment.center,
                    children: List.generate(allRounderList.length, (index) {
                      return Padding(
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
                                      backgroundColor: AppColor.greenDark,
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
                                allRounderList[index].playerId ==
                                            captainId ||
                                        allRounderList[index].playerId ==
                                            viceCaptainId
                                    ? Container(
                                        height: 25,
                                        width: 25,
                                        margin: const EdgeInsets.only(
                                            left: 30, top: 35),
                                        decoration: BoxDecoration(
                                          color: AppColor.red,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Text(
                                            allRounderList[index].playerId ==
                                                    captainId
                                                ? "C"
                                                : "VC",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: "Lato_Bold",
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: AppColor.brown3),
                              child: Text(
                                "${allRounderList[index].playerName}",
                                style: const TextStyle(
                                    fontFamily: "Lato_Semibold",
                                    color: AppColor.white,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const Text(
                  "Bowler",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
                SingleChildScrollView(
                  child: Wrap(
                    runSpacing: runSpacing,
                    spacing: spacing,
                    alignment: WrapAlignment.center,
                    children: List.generate(bowlList.length, (index) {
                      return Padding(
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
                                      backgroundColor: AppColor.greenDark,
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
                                bowlList[index].playerId == captainId ||
                                        bowlList[index].playerId ==
                                           viceCaptainId
                                    ? Container(
                                        height: 25,
                                        width: 25,
                                        margin: const EdgeInsets.only(
                                            left: 30, top: 35),
                                        decoration: BoxDecoration(
                                          color: AppColor.orange_light,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Text(
                                            bowlList[index].playerId ==
                                                    captainId
                                                ? "C"
                                                : "VC",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: "Lato_Bold",
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: AppColor.brown3),
                              child: Text(
                                "${bowlList[index].playerName}",
                                style: const TextStyle(
                                    fontFamily: "Lato_Semibold",
                                    color: AppColor.white,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
