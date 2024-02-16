import 'package:crick_team/loginSignupRelatedFiles/LoginScreen.dart';
import 'package:crick_team/scoreRelatedScreens/ScorerScreen.dart';
import 'package:crick_team/startMatchRelatedScreens/SelectPlayerForMatch.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:crick_team/utils/data_type_extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apiRelatedFiles/rest_apis.dart';
import '../main.dart';
import '../modalClasses/GetMatchModel.dart';
import '../utils/CommonFunctions.dart';
import '../utils/common.dart';

class StartInningsScreen extends StatefulWidget {
  final GetMatchData matchData;
  final String tossWinnerId;
  final String tossWinnerElected;

  const StartInningsScreen(
      {super.key,
      required this.matchData,
      required this.tossWinnerId,
      required this.tossWinnerElected});

  @override
  State<StartInningsScreen> createState() => _StartInningsScreenState();
}

class _StartInningsScreenState extends State<StartInningsScreen> {
  bool isStriker = false;
  bool isNonStriker = false;
  bool isBowlerSelected = false;
  var strikerId = "";
  var nonStrikerId = "";
  var bowlerId = "";
  var battingTeamName = "";
  var battingTeamId = "";
  var bowlingTeamName = "";
  var bowlingTeamId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isStriker = false;
    isNonStriker = false;
    isBowlerSelected = false;
    strikerId = "";
    nonStrikerId = "";
    bowlerId = "";
    battingTeamName = "";
    battingTeamId = "";
    bowlingTeamName = "";
    bowlingTeamId = "";
    if (widget.tossWinnerElected == "1" &&
        widget.tossWinnerId == widget.matchData.team1Id.toString()) {
      debugPrint("TEAM A is winner and elected to bat.");
      battingTeamName = widget.matchData.team1Name.toString();
      battingTeamId = widget.matchData.team1Id.toString();
      bowlingTeamName = widget.matchData.team2Name.toString();
      bowlingTeamId = widget.matchData.team2Id.toString();
    } else if (widget.tossWinnerElected == "1" &&
        widget.tossWinnerId == widget.matchData.team2Id.toString()) {
      debugPrint("TEAM B is winner and elected to bat.");
      battingTeamName = widget.matchData.team2Name.toString();
      battingTeamId = widget.matchData.team2Id.toString();
      bowlingTeamName = widget.matchData.team1Name.toString();
      bowlingTeamId = widget.matchData.team1Id.toString();
    } else if (widget.tossWinnerElected == "2" &&
        widget.tossWinnerId == widget.matchData.team1Id.toString()) {
      debugPrint("TEAM A is winner and elected to ball.");
      battingTeamName = widget.matchData.team2Name.toString();
      battingTeamId = widget.matchData.team2Id.toString();
      bowlingTeamName = widget.matchData.team1Name.toString();
      bowlingTeamId = widget.matchData.team1Id.toString();
    } else if (widget.tossWinnerElected == "2" &&
        widget.tossWinnerId == widget.matchData.team2Id.toString()) {
      debugPrint("TEAM B is winner and elected to ball.");
      battingTeamName = widget.matchData.team1Name.toString();
      battingTeamId = widget.matchData.team1Id.toString();
      bowlingTeamName = widget.matchData.team2Name.toString();
      bowlingTeamId = widget.matchData.team2Id.toString();
    }
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
          "Start Innings",
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
                    'Batting Players',
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
                              // isStriker = true;
                              // isNonStriker = false;
                              Navigator.push(
                                  getContext,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SelectPlayerForMatch(
                                            teamId: battingTeamId,
                                            teamName: battingTeamName,
                                            strikerId: strikerId,
                                            nonStrikerId: nonStrikerId,
                                          ))).then((value) {
                                if (value != "add_teams") {
                                  setState(() {
                                    debugPrint("dadaddadaddsadasdad $value");
                                    strikerId = value.toString();
                                    isStriker = true;
                                    selectPlayersApi("1", battingTeamId, strikerId, "1");
                                  });
                                }
                              });
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: isStriker
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
                                  "assets/striker.png",
                                  height: 60,
                                  width: 60,
                                  color:
                                      isStriker ? Colors.white : AppColor.black,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Center(
                                  child: Text(
                                    "Select Striker",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Lato_Sembold",
                                      color: isStriker
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
                              // isStriker = false;
                              // isNonStriker = true;
                              Navigator.push(
                                  getContext,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SelectPlayerForMatch(
                                            teamId: battingTeamId,
                                            teamName: battingTeamName,
                                            strikerId: strikerId,
                                            nonStrikerId: nonStrikerId,
                                          ))).then((value) {
                                if (value != "add_teams") {
                                  setState(() {
                                    debugPrint("NON_STRIKER_ID $value");
                                    nonStrikerId = value.toString();
                                    isNonStriker = true;
                                    selectPlayersApi("1", battingTeamId, nonStrikerId, "2");
                                  });

                                }
                              });
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: isNonStriker
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
                                  "assets/non_striker.png",
                                  height: 60,
                                  width: 60,
                                  color: isNonStriker
                                      ? Colors.white
                                      : AppColor.black,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Center(
                                  child: Text(
                                    "Select Non Striker",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Lato_Sembold",
                                      color: isNonStriker
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
                    'Bowling',
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
                              // isBowlerSelected = true;
                              Navigator.push(
                                  getContext,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SelectPlayerForMatch(
                                            teamId: bowlingTeamId,
                                            teamName: bowlingTeamName,
                                            bowlerId: bowlerId,
                                          ))).then((value) {
                                if (value != "add_teams") {
                                  setState(() {
                                    debugPrint("BOWLER_ID $value");
                                    bowlerId = value.toString();
                                    isBowlerSelected = true;
                                    selectPlayersApi("2", bowlingTeamId, bowlerId, "");
                                  });

                                }
                              });
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: isBowlerSelected
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
                                  "assets/bowler.png",
                                  height: 60,
                                  width: 60,
                                  color: isBowlerSelected
                                      ? Colors.white
                                      : AppColor.text_grey,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Center(
                                  child: Text(
                                    "Bowler",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Lato_Sembold",
                                      color: isBowlerSelected
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
                Map<String, int> map = {
                  "player1_id":strikerId.toInt(),
                  "player2_id":nonStrikerId.toInt(),
                  "bowler_id":bowlerId.toInt(),
                  "match_id":widget.matchData.id!,
                  "team_id":battingTeamId.toInt(),
                  "team2_id":bowlingTeamId.toInt(),
                };
                Navigator.push(
                    getContext,
                    MaterialPageRoute(
                        builder: (context) =>  ScorerScreen(teamMatch: '${widget.matchData.team1Name} vs ${widget.matchData.team2Name}',map: map,)));
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
                    "Start Scoring",
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

  selectPlayersApi(
      String type, String teamId, String playerId, String position) async {
    //type=="1"batsman
    var request = type == "1"
        ? {
            'type': type,
            'match_id': widget.matchData.id.toString(),
            'team_id': teamId,
            'player_id': playerId,
            'position': position,
            'is_stricker': position=="1"?"1":"0",
          }
        : {
            'type': type,
            'match_id': widget.matchData.id.toString(),
            'team_id': teamId,
            'player_id': playerId,
          };
    await selectPlayers(request).then((res) async {
      if (res.success == 1) {
        toast(res.message);
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
