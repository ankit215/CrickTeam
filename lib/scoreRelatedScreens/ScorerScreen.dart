import 'dart:convert';

import 'package:crick_team/apiRelatedFiles/rest_apis.dart';
import 'package:crick_team/loginSignupRelatedFiles/LoginScreen.dart';
import 'package:crick_team/scoreRelatedScreens/OutScreen.dart';
import 'package:crick_team/scoreRelatedScreens/ScoreBoardscreen.dart';
import 'package:crick_team/utils/common.dart';
import 'package:crick_team/utils/data_type_extension.dart';
import 'package:crick_team/utils/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import '../modalClasses/GetMatchModel.dart';
import '../modalClasses/GetTeamDetailModel.dart';
import '../modalClasses/socketModels/PlayerDetail.dart';
import '../modalClasses/socketModels/UpdatedScoreModel.dart';
import '../startMatchRelatedScreens/SelectPlayerForMatch.dart';
import '../utils/AppColor.dart';
import '../utils/CommonFunctions.dart';
import '../utils/constant.dart';

class ScorerScreen extends StatefulWidget {
  final UpcomingListArr matchData;
  final String teamMatch;
  final Map<String, int> map;

  const ScorerScreen(
      {super.key,
      required this.teamMatch,
      required this.map,
      required this.matchData});

  @override
  State<ScorerScreen> createState() => _ScorerScreenState();
}

class BallType {
  String? title;
  bool? isSelected;

  BallType(this.title, this.isSelected);
}

class _ScorerScreenState extends State<ScorerScreen>
    with TickerProviderStateMixin {
  TextEditingController teamController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController scoreController = TextEditingController();

  int totalRun = 1;

  /*List<BallType> noBallType = [
    BallType("From Bat", false),
    BallType("Bye", false),
    BallType("Leg Bye", false)
  ];*/
  List<BallType> noBallType2 = [
    BallType("Declared Run", false),
    BallType("Short Run", false)
  ];
  late io.Socket socket;
  bool isSocketConnected = false;
  PlayerDetail? playerDetail;
  ScoreUpdate? scoreUpdate;
  int strikerId = 0;
  int nonStrikerId = 0;
  int bowlerId = 0;
  int matchId = 0;
  int battingTeamId = 0;
  int bowlingTeamId = 0;
  List<String> bowlerRuns = [];
  int bowlerBallsCount = 0;

  // String strikerScore = "0";
  // String strikerBallsPlayed = "0";
  // String nonStrikerScore = "0";
  // String nonStrikerBallsPlayed = "0";

  @override
  void initState() {
    super.initState();
    debugPrint("MAPP__${widget.map}");
    if (getStringListAsync(bowlerRunsPerOver) != null) {
      bowlerRuns = getStringListAsync(bowlerRunsPerOver)!;
      if(bowlerRuns[0].isEmpty){
        bowlerRuns.clear();
      }
      debugPrint("bowlerRuns++++${bowlerRuns}");
    }
    strikerId = widget.map["player1_id"]!;
    nonStrikerId = widget.map["player2_id"]!;
    bowlerId = widget.map["bowler_id"]!;
    matchId = widget.map["match_id"]!;
    battingTeamId = widget.map["team_id"]!;
    bowlingTeamId = widget.map["team2_id"]!;
    init();
  }

  void init() {
    socket = io.io('http://3.108.254.219:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    Future.delayed(Duration.zero, () {
      connectToSocket();
    });
    connectListener();
    scoreUpdateListener();
  }

  void createConnectionSocket(var map) {
    socket.emit('create_connection', map);
  }

  void connectListener() {
    socket.on('connect_listener', (data) {
      debugPrint('Received message: $data');
      try {
        setState(() {
          playerDetail = PlayerDetail.fromJson(data);
          bowlerId = playerDetail!.bowlerId;
          strikerId = playerDetail!.player1Id;
        });
      } catch (e) {
        debugPrint('Error parsing data: $e');
      }
    });
  }

  void scoreUpdateListener() {
    debugPrint("Score_update_listener__1");
    socket.on('score_update_listener', (data) {
      if (data != null) {
        debugPrint('score_update_listener11111: $data');
        String jsonString = json.encode(data);
        // Parse the JSON string into a Dart map
        Map<String, dynamic> jsonData = json.decode(jsonString);
        debugPrint('JSON___: $jsonData');
        try {
          setState(() {
            scoreUpdate = ScoreUpdate.fromJson(jsonData['update_score']);
            debugPrint(
                'score_update_listener2222: ${scoreUpdate!.striker.isStriker}');
            if (scoreUpdate!.batsman.id == scoreUpdate!.striker.isStriker) {
              strikerId = scoreUpdate!.batsman.id;
              nonStrikerId = scoreUpdate!.batsman2.id;
            } else {
              strikerId = scoreUpdate!.batsman2.id;
              nonStrikerId = scoreUpdate!.batsman.id;
            }
            if (hasDecimal(scoreUpdate!.bowler.balls)) {
              int digitAfterDecimal =
                  ((scoreUpdate!.bowler.balls * 10) % 10).toInt();
              bowlerBallsCount = digitAfterDecimal;
              debugPrint('BALLS: $digitAfterDecimal');
            } else {
              bowlerBallsCount = bowlerBallsCount + 1;
              debugPrint('BALLS ELSE: ${scoreUpdate!.bowler.balls}');

              debugPrint('CHANGE OVER');
              bool isMaidenOver = bowlerRuns.every((element) => element == "0");
              debugPrint("IS_MAIDEN___$isMaidenOver");
              if (isMaidenOver) {
                maidenOverApi(bowlingTeamId.toString(), bowlerId.toString());
              } else {
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.push(
                      getContext,
                      MaterialPageRoute(
                          builder: (context) => SelectPlayerForMatch(
                                teamId: bowlingTeamId.toString(),
                                teamName: "Select new bowler",
                                bowlerId: bowlerId.toString(),
                              ))).then((value) {
                    if (value != null && value != "add_teams") {
                      setState(() {
                        debugPrint("BOWLER_ID $value");
                        bowlerId = value.toInt();
                        nextBowlerApi(
                            bowlingTeamId.toString(), bowlerId.toString());
                      });
                    }
                  });
                });
              }
            }
          });
        } catch (e) {
          debugPrint('Error parsing data: $e');
        }
      }
    });
  }

  bool hasDecimal(dynamic number) {
    return number != number.toInt();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  void connectToSocket() {
    socket.connect();
    socket.onConnect((_) {
      setState(() {
        debugPrint('Connected to the socket server');
        isSocketConnected = true;
        createConnectionSocket(widget.map);
      });
    });
    socket.onDisconnect((_) {
      debugPrint('Disconnected from the socket server');
    });
  }

  void scoreUpdateSocket(int strikerId, int nonStrikerId, int bowlerId,
      int matchId, int battingTeamId, int bowlingTeamId, int type, int run) {
    var map = {
      "player1_id": strikerId,
      "player2_id": nonStrikerId,
      "bowler_id": bowlerId,
      "match_id": matchId,
      "team_id": battingTeamId,
      "team2_id": bowlingTeamId,
      "type": type,
      "run": run
    };
    debugPrint("SCORE_UPDATE_FIELDS$map");
    socket.emit('score_update', map);
    if (/*type == 5 || type == 7 || */ type >= 8) {
      _showStrikerBottomSheet(context, nonStrikerId.toString(),
          strikerId.toString(), battingTeamId.toString());
    }
    if (bowlerBallsCount <= 6) {
      setState(() {
        if (type == 8) {
          bowlerRuns.add("wd");
        } else if (type == 9) {
          bowlerRuns.add("nb");
        } else if (type == 10) {
          bowlerRuns.add("bye");
        } else if (type == 11) {
          bowlerRuns.add("lb");
        } else {
          bowlerRuns.add(run.toString());
        }

        setValue(bowlerRunsPerOver, bowlerRuns);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          elevation: 5.0,
          backgroundColor: AppColor.brown2,
          leading: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.white,
                    insetPadding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 16,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          const SizedBox(height: 20),
                          Container(
                            color: AppColor.lightGrey,
                            height: 60,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 40.0, left: 40.0),
                              child: Center(
                                child: Text(
                                  'ARE YOU SURE YOU WANT TO END THIS INNING?',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Lato_Regular",
                                      letterSpacing: 1,
                                      color: AppColor.brown2),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 100, left: 100),
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.orange_0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(80.0))),
                              child: Container(
                                height: 20,
                                alignment: Alignment.center,
                                child: const Text(
                                  "Yes",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: "Lato_Semibold"),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                right: 30.0, left: 30.0, top: 20),
                            child: Divider(
                              height: 1,
                              color: AppColor.medGrey,
                              thickness: 1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(getContext);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.white,
                                  elevation: 0),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.brown2,
                                  fontFamily: "Lato_Regular",
                                ),
                              )),
                          const SizedBox(height: 10)
                        ],
                      ),
                    ),
                  );
                },
              );
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
            widget.teamMatch,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: "Lato_Semibold",
              color: AppColor.white,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      getContext,
                      MaterialPageRoute(
                          builder: (context) => ScoreBoardScreen(
                                getMatchData: widget.matchData,
                              )));
                },
                child: const Icon(
                  Icons.info_outlined,
                  size: 30,
                  color: Colors.white,
                )),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/cricket_bg.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.blackDark.withOpacity(0.6),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              scoreUpdate != null
                                  ? scoreUpdate!.scores.totalRun.toString()
                                  : "0/0",
                              style: const TextStyle(
                                  fontSize: 30.0,
                                  color: AppColor.white,
                                  fontFamily: "Lato_Bold"),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              scoreUpdate != null
                                  ? "${scoreUpdate!.scores.totalOver}/${scoreUpdate!.scores.matchTotalOvers}"
                                  : "-",
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  color: AppColor.white,
                                  fontFamily: "Lato_Bold"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.blackDark.withOpacity(0.4),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showStrikerBottomSheet(
                                    context,
                                    playerDetail!.player1Id.toString(),
                                    playerDetail!.player2Id.toString(),
                                    battingTeamId.toString());
                              },
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.49,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: playerDetail != null &&
                                              scoreUpdate != null &&
                                              playerDetail!.player1Id ==
                                                  strikerId
                                          ? Colors.orange
                                          : AppColor.grey,
                                      child: ClipOval(
                                          child: Image.asset(
                                        "assets/bats.png",
                                        fit: BoxFit.cover,
                                        height: 20,
                                        width: 20,
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          playerDetail != null
                                              ? "USER_ID ${playerDetail!.player1Id}"
                                              : "-",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Lato_Bold",
                                              fontSize: 16),
                                        ),
                                        scoreUpdate != null &&
                                                playerDetail != null
                                            ? Text(
                                                // 35==39
                                                // 39==39
                                                scoreUpdate!.batsman.id ==
                                                            playerDetail!
                                                                .player1Id &&
                                                        scoreUpdate!.striker
                                                                .isStriker ==
                                                            playerDetail!
                                                                .player1Id
                                                    ? "${scoreUpdate!.batsman.run} (${scoreUpdate!.batsman.balls})"
                                                    : scoreUpdate!.batsman2
                                                                    .id ==
                                                                playerDetail!
                                                                    .player1Id &&
                                                            scoreUpdate!.striker
                                                                    .isStriker ==
                                                                playerDetail!
                                                                    .player1Id
                                                        ? "${scoreUpdate!.batsman2.run} (${scoreUpdate!.batsman2.balls})"
                                                        : scoreUpdate!.batsman
                                                                        .id ==
                                                                    playerDetail!
                                                                        .player1Id &&
                                                                scoreUpdate!
                                                                        .striker
                                                                        .isStriker !=
                                                                    playerDetail!
                                                                        .player1Id
                                                            ? "${scoreUpdate!.batsman.run} (${scoreUpdate!.batsman.balls})"
                                                            : scoreUpdate!.batsman2
                                                                            .id ==
                                                                        playerDetail!
                                                                            .player1Id &&
                                                                    scoreUpdate!
                                                                            .striker
                                                                            .isStriker !=
                                                                        playerDetail!
                                                                            .player1Id
                                                                ? "${scoreUpdate!.batsman2.run} (${scoreUpdate!.batsman2.balls})"
                                                                : "0(0)",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Lato_Bold",
                                                    fontSize: 16),
                                              )
                                            : const Text("0(0)"),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 1.1,
                              height: 50,
                              color: Colors.white,
                            ),
                            GestureDetector(
                              onTap: () {
                                _showStrikerBottomSheet(
                                    context,
                                    playerDetail!.player2Id.toString(),
                                    playerDetail!.player1Id.toString(),
                                    battingTeamId.toString());
                              },
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.49,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: playerDetail != null &&
                                              scoreUpdate != null &&
                                              playerDetail!.player2Id ==
                                                  strikerId
                                          ? Colors.orange
                                          : AppColor.grey,
                                      child: ClipOval(
                                          child: Image.asset(
                                        "assets/bats.png",
                                        fit: BoxFit.cover,
                                        height: 20,
                                        width: 20,
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          playerDetail != null
                                              ? "USER_ID ${playerDetail!.player2Id}"
                                              : "-",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Lato_Bold",
                                              fontSize: 16),
                                        ),
                                        scoreUpdate != null &&
                                                playerDetail != null
                                            ? Text(
                                                scoreUpdate!.batsman.id ==
                                                            playerDetail!
                                                                .player2Id &&
                                                        scoreUpdate!.striker
                                                                .isStriker ==
                                                            playerDetail!
                                                                .player2Id
                                                    ? "${scoreUpdate!.batsman.run} (${scoreUpdate!.batsman.balls})"
                                                    : scoreUpdate!.batsman2
                                                                    .id ==
                                                                playerDetail!
                                                                    .player2Id &&
                                                            scoreUpdate!.striker
                                                                    .isStriker ==
                                                                playerDetail!
                                                                    .player2Id
                                                        ? "${scoreUpdate!.batsman2.run} (${scoreUpdate!.batsman2.balls})"
                                                        : scoreUpdate!.batsman
                                                                        .id ==
                                                                    playerDetail!
                                                                        .player2Id &&
                                                                scoreUpdate!
                                                                        .striker
                                                                        .isStriker !=
                                                                    playerDetail!
                                                                        .player2Id
                                                            ? "${scoreUpdate!.batsman.run} (${scoreUpdate!.batsman.balls})"
                                                            : scoreUpdate!.batsman2
                                                                            .id ==
                                                                        playerDetail!
                                                                            .player2Id &&
                                                                    scoreUpdate!
                                                                            .striker
                                                                            .isStriker !=
                                                                        playerDetail!
                                                                            .player2Id
                                                                ? "${scoreUpdate!.batsman2.run} (${scoreUpdate!.batsman2.balls})"
                                                                : "0(0)",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Lato_Bold",
                                                    fontSize: 16),
                                              )
                                            : const Text("0(0)"),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      getContext,
                      MaterialPageRoute(
                          builder: (context) => SelectPlayerForMatch(
                                teamId: bowlingTeamId.toString(),
                                teamName: "Select new bowler",
                                bowlerId: bowlerId.toString(),
                              ))).then((value) {
                    if (value != null && value != "add_teams") {
                      setState(() {
                        debugPrint("BOWLER_ID $value");
                        bowlerId = value.toInt();
                        nextBowlerApi(
                            bowlingTeamId.toString(), bowlerId.toString());
                      });
                    }
                  });
                },
                child: Container(
                  color: AppColor.text_grey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: AppColor.brown2,
                                child: ClipOval(
                                    child: Image.asset(
                                  "assets/ball.png",
                                  fit: BoxFit.cover,
                                  color: Colors.white,
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
                                    playerDetail != null && scoreUpdate == null
                                        ? "USER_ID ${bowlerId}"
                                        : playerDetail != null &&
                                                scoreUpdate != null
                                            ? "USER_ID ${bowlerId}"
                                            : "-",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Lato_Bold",
                                        fontSize: 16),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        scoreUpdate != null
                                            ? "Balls: ${bowlerBallsCount}"
                                            : "0",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Lato_Bold",
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        scoreUpdate != null
                                            ? "Wickets: ${scoreUpdate!.bowler.wicket}"
                                            : "Wickets: []",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Lato_Bold",
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 15.0),
                                        child: Text(
                                          playerDetail != null && scoreUpdate != null
                                              ? "${scoreUpdate!.bowler.balls}-${scoreUpdate!.bowler.maidensOver}-${scoreUpdate!.bowler.runs}-${scoreUpdate!.bowler.wicket}"
                                              : "-",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Lato_Bold",
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  scoreUpdate != null
                                      ? Container(
                                    width:MediaQuery.sizeOf(context).width*0.8,
                                    height: 50,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: bowlerRuns.length, // number of elements in the list
                                      itemBuilder: (BuildContext context, int index) {
                                        String currentItem = bowlerRuns[index];

                                        // Return a circular container with the current item as text
                                        return Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Container(

                                            width: 30.0,
                                            height: 30.0,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColor.brown3, // Change color as needed
                                            ),
                                            child: Center(
                                              child: Text(
                                                currentItem,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ):
                                  const Text(
                                    "Runs: []",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Lato_Bold",
                                        fontSize: 12),
                                  ),

                                ],
                              ),

                            ],
                          ),


                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.75,
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 2.0,
                      childAspectRatio: 0.9,
                      scrollDirection: Axis.vertical,
                      children: List.generate(6, (index) {
                        return GestureDetector(
                          onTap: () {
                            if (index == 0 && bowlerBallsCount != 6) {
                              scoreUpdateSocket(
                                  strikerId,
                                  nonStrikerId,
                                  bowlerId,
                                  matchId,
                                  battingTeamId,
                                  bowlingTeamId,
                                  0,
                                  0);
                            } else if (index == 1 && bowlerBallsCount != 6) {
                              scoreUpdateSocket(
                                  strikerId,
                                  nonStrikerId,
                                  bowlerId,
                                  matchId,
                                  battingTeamId,
                                  bowlingTeamId,
                                  1,
                                  1);
                            } else if (index == 2 && bowlerBallsCount != 6) {
                              scoreUpdateSocket(
                                  strikerId,
                                  nonStrikerId,
                                  bowlerId,
                                  matchId,
                                  battingTeamId,
                                  bowlingTeamId,
                                  2,
                                  2);
                            } else if (index == 3 && bowlerBallsCount != 6) {
                              scoreUpdateSocket(
                                  strikerId,
                                  nonStrikerId,
                                  bowlerId,
                                  matchId,
                                  battingTeamId,
                                  bowlingTeamId,
                                  3,
                                  3);
                            } else if (index == 4 && bowlerBallsCount != 6) {
                              scoreUpdateSocket(
                                  strikerId,
                                  nonStrikerId,
                                  bowlerId,
                                  matchId,
                                  battingTeamId,
                                  bowlingTeamId,
                                  4,
                                  4);
                            } else if (index == 5 && bowlerBallsCount != 6) {
                              scoreUpdateSocket(
                                  strikerId,
                                  nonStrikerId,
                                  bowlerId,
                                  matchId,
                                  battingTeamId,
                                  bowlingTeamId,
                                  6,
                                  6);
                            } else {
                              CommonFunctions().showToastMessage(context,
                                  "Over is finished please select next bowler.");
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            color: AppColor.grey,
                            child: index <= 3
                                ? Center(
                                    child: Text(
                                      index.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Lato_Semibold",
                                        color: AppColor.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : index == 4
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              index.toString(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontFamily: "Lato_Semibold",
                                                color: AppColor.black,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const Text(
                                              "(Four)",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Lato_Semibold",
                                                color: AppColor.black,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      )
                                    : const Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "6",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "Lato_Semibold",
                                                color: AppColor.black,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              "(Six)",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Lato_Semibold",
                                                color: AppColor.black,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 1),
                    width: MediaQuery.sizeOf(context).width * 0.24,
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 1,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 2.0,
                      childAspectRatio: 0.88,
                      scrollDirection: Axis.vertical,
                      children: List.generate(2, (index) {
                        return GestureDetector(
                          onTap: () {
                            index == 0 && bowlerBallsCount != 6
                                /* ? debugPrint("Undo")
                                : index == 1*/
                                ? show5or7BottomSheet(
                                    context,
                                    nonStrikerId.toString(),
                                    strikerId.toString(),
                                    battingTeamId.toString())
                                : index == 0 && bowlerBallsCount == 6
                                    ? CommonFunctions().showToastMessage(
                                        context,
                                        "Over is finished please select next bowler.")
                                    : playerWhoOutBottomSheet(
                                        context,
                                        scoreUpdate!.batsman,
                                        scoreUpdate!.batsman2,
                                        scoreUpdate!.bowler);
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              color: AppColor.grey,
                              child: Center(
                                child: Text(
                                  index == 0
                                      /*? "Undo"
                                      : index == 1*/
                                      ? "5,7"
                                      : "Out",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Lato_Semibold",
                                    color: index == 0
                                        ? AppColor.green_neon
                                        : AppColor.red,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                crossAxisSpacing: 3.0,
                mainAxisSpacing: 3.0,
                scrollDirection: Axis.vertical,
                children: List.generate(4, (index) {
                  return GestureDetector(
                    onTap: () {
                      if (bowlerBallsCount == 6) {
                        CommonFunctions().showToastMessage(context,
                            "Over is finished please select next bowler.");
                      } else {
                        _showBottomSheet(
                            context,
                            index == 0
                                ? "WD"
                                : index == 1
                                    ? "NB"
                                    : index == 2
                                        ? "BYE"
                                        : "LB");
                      }
                    },
                    child: Container(
                      height: 20,
                      width: 30,
                      color: AppColor.grey,
                      child: Center(
                        child: Text(
                          index == 0
                              ? "WD"
                              : index == 1
                                  ? "NB"
                                  : index == 2
                                      ? "BYE"
                                      : "LB",
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: "Lato_Semibold",
                            color: AppColor.text_grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ));
  }

  void _showBottomSheet(BuildContext context, String type) {
    totalRun = 1;
    scoreController.text = "";
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        scoreController.text = scoreController.text.toString().isEmpty
            ? "0"
            : scoreController.text.toString();
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Text(
                  type == "WD"
                      ? "Wide Ball"
                      : type == "NB"
                          ? "No Ball"
                          : type == "BYE"
                              ? "Bye Runs"
                              : "Leg Bye Runs",
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: "Lato_Semibold",
                    color: AppColor.text_grey,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      type,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: "Lato_Semibold",
                        color: AppColor.text_grey,
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.brown2,
                          border: Border.all(color: AppColor.border)),
                      child: const Center(
                          child: Text(
                        "1",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Lato_Semibold",
                          color: AppColor.white,
                        ),
                      )),
                    ),
                    const Icon(Icons.add),
                    Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 10, right: 10),
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.white,
                          border: Border.all(color: AppColor.border)),
                      child: Center(
                          child: TextField(
                        controller: scoreController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        onChanged: (value) {
                          if (scoreController.text.isNotEmpty) {
                            setState(() {
                              totalRun = int.parse(value) + 1;
                            });
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration.collapsed(
                            hintStyle: TextStyle(color: AppColor.grey),
                            hintText: ''),
                      )),
                    ),
                    Text(
                      "= $totalRun",
                      style: const TextStyle(
                        fontSize: 22,
                        fontFamily: "Lato_Bold",
                        color: AppColor.black,
                      ),
                    )
                  ],
                ),
                /* type == "NB"
                    ? SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: noBallType.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  for (int i = 0; i < noBallType.length; i++) {
                                    noBallType[i].isSelected = false;
                                  }
                                  noBallType[index].isSelected = true;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  (noBallType[index].isSelected != null &&
                                          noBallType[index].isSelected == false)
                                      ? const Icon(
                                          Icons.radio_button_unchecked,
                                          color: AppColor.brown2,
                                        )
                                      : const Icon(
                                          Icons.radio_button_checked,
                                          color: AppColor.brown2,
                                        ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    noBallType[index].title.toString(),
                                    style: const TextStyle(
                                        fontFamily: "Ubuntu_Regular",
                                        fontSize: 14,
                                        color: AppColor.brown2),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : const SizedBox(),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.red.withOpacity(0.1),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const Center(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Lato_Bold",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          scoreUpdateSocket(
                              strikerId,
                              nonStrikerId,
                              bowlerId,
                              matchId,
                              battingTeamId,
                              bowlingTeamId,
                              type == "WD"
                                  ? 8
                                  : type == "NB"
                                      ? 9
                                      : type == "BYE"
                                          ? 10
                                          : 11,
                              totalRun);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColor.green_neon.withOpacity(0.1),
                          ),
                          child: const Center(
                            child: Text(
                              "Ok",
                              style: TextStyle(
                                  color: AppColor.green2,
                                  fontFamily: "Lato_Bold",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
      },
    );
  }

  void _showStrikerBottomSheet(BuildContext context, String playerId,
      String player2Id, String battingTeamId) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        scoreController.text = scoreController.text.toString().isEmpty
            ? "0"
            : scoreController.text.toString();
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Change Striker?",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Lato_Semibold",
                    color: AppColor.text_grey,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: const Text(
                    "Do you want to change the next striker! Tap yes to change.",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Lato_Semibold",
                      color: AppColor.text_grey,
                    ),
                  ),
                ),
                /*SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: noBallType2.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            for (int i = 0; i < noBallType2.length; i++) {
                              noBallType2[i].isSelected = false;
                            }
                            noBallType2[index].isSelected = true;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            (noBallType2[index].isSelected != null &&
                                    noBallType2[index].isSelected == false)
                                ? const Icon(
                                    Icons.check_box_outline_blank,
                                    color: AppColor.brown2,
                                  )
                                : const Icon(
                                    Icons.check_box_rounded,
                                    color: AppColor.brown2,
                                  ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              noBallType2[index].title.toString(),
                              style: const TextStyle(
                                  fontFamily: "Ubuntu_Regular",
                                  fontSize: 14,
                                  color: AppColor.brown2),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.red.withOpacity(0.1),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const Center(
                            child: Text(
                              "Not Now",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Lato_Bold",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          changeStrikerApi(battingTeamId, playerId, player2Id);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColor.green_neon.withOpacity(0.1),
                          ),
                          child: const Center(
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                  color: AppColor.green2,
                                  fontFamily: "Lato_Bold",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
      },
    );
  }

  void show5or7BottomSheet(BuildContext context, String playerId,
      String player2Id, String battingTeamId) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "How much run?",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Lato_Semibold",
                    color: AppColor.text_grey,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: const Text(
                    "Tap on the run to proceed.",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Lato_Semibold",
                      color: AppColor.text_grey,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          scoreUpdateSocket(
                              strikerId,
                              nonStrikerId,
                              bowlerId,
                              matchId,
                              battingTeamId.toInt(),
                              bowlingTeamId,
                              5,
                              5);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.grey.withOpacity(0.1),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const Center(
                            child: Text(
                              "5",
                              style: TextStyle(
                                  color: AppColor.brown2,
                                  fontFamily: "Lato_Bold",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          scoreUpdateSocket(
                              strikerId,
                              nonStrikerId,
                              bowlerId,
                              matchId,
                              battingTeamId.toInt(),
                              bowlingTeamId,
                              7,
                              7);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColor.grey.withOpacity(0.1),
                          ),
                          child: const Center(
                            child: Text(
                              "7",
                              style: TextStyle(
                                  color: AppColor.brown2,
                                  fontFamily: "Lato_Bold",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.red.withOpacity(0.1),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const Center(
                            child: Text(
                              "Not Now",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Lato_Bold",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          changeStrikerApi(battingTeamId, playerId, player2Id);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColor.green_neon.withOpacity(0.1),
                          ),
                          child: const Center(
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                  color: AppColor.green2,
                                  fontFamily: "Lato_Bold",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
      },
    );
  }

  void playerWhoOutBottomSheet(
      BuildContext context, Batsman batsman, Batsman2 batsman2, Bowler bowler) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          var selectedPlayerId = "";
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Select the player who is out?",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Lato_Semibold",
                    color: AppColor.text_grey,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: const Text(
                    "Tap on the player to proceed.",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Lato_Semibold",
                      color: AppColor.text_grey,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPlayerId = batsman.id.toString();
                            debugPrint("Selected Player Id: $selectedPlayerId");
                            Navigator.push(
                                getContext,
                                MaterialPageRoute(
                                    builder: (context) => OutScreen(
                                          bowlingTeamId: bowlingTeamId,
                                          battingTeamId: battingTeamId,
                                          matchData: widget.matchData,
                                          bowlerId: bowlerId,
                                          batterId: batsman.id,
                                          batterNotOutId: batsman2.id,
                                        ))).then((value) {
                              if (value != null && value != "add_teams") {
                                setState(() {
                                  GetTeamDetailData nextBatsmanData = value;
                                  debugPrint(
                                      "BATS_IDs ${nextBatsmanData.userId}");
                                  Batsman? batsman;
                                  Batsman2? batsman2;
                                  batsman = Batsman(
                                      id: nextBatsmanData.userId!,
                                      run: 0,
                                      balls: 0,name: nextBatsmanData.userName);
                                  batsman2 = scoreUpdate!.batsman2;
                                  /*  if (strikerId.toString() ==
                                      selectedPlayerId) {

                                  } else if (nonStrikerId.toString() ==
                                      selectedPlayerId) {
                                    batsman = scoreUpdate!.batsman;
                                    batsman2 = Batsman2(
                                        id: nextBatsmanData.userId!,
                                        run: 0,
                                        balls: 0);
                                  }*/

                                  selectStrikerBottomSheet(context, batsman!,
                                      batsman2!, scoreUpdate!.bowler);
                                });
                                bowlerRuns.add("W");
                              }
                            });
                            // Navigator.pop(context);
                          });
                          // Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedPlayerId == batsman.id.toString()
                                ? AppColor.brown2.withOpacity(0.1)
                                : AppColor.grey.withOpacity(0.1),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/player.png",
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "USER_ID ${batsman.id}",
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: AppColor.brown2,
                                    fontFamily: "Lato_Semibold"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPlayerId = batsman2.id.toString();
                            debugPrint("Selected Player Id: $selectedPlayerId");
                            Navigator.push(
                                getContext,
                                MaterialPageRoute(
                                    builder: (context) => OutScreen(
                                          bowlingTeamId: bowlingTeamId,
                                          battingTeamId: battingTeamId,
                                          matchData: widget.matchData,
                                          bowlerId: bowlerId,
                                          batterId: batsman2.id,
                                          batterNotOutId: batsman.id,
                                        ))).then((value) {
                              if (value != null && value != "add_teams") {
                                setState(() {
                                  GetTeamDetailData nextBatsmanData = value;
                                  debugPrint(
                                      "BATS_IDs ${nextBatsmanData.userId}");
                                  Batsman? batsman;
                                  Batsman2? batsman2;
                                  batsman = scoreUpdate!.batsman;
                                  batsman2 = Batsman2(
                                      id: nextBatsmanData.userId!,
                                      run: 0,
                                      balls: 0,name: nextBatsmanData.userName);

                                  selectStrikerBottomSheet(context, batsman!,
                                      batsman2!, scoreUpdate!.bowler);
                                });
                                bowlerRuns.add("W");
                              }
                            });
                            // Navigator.pop(context);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: selectedPlayerId == batsman2.id.toString()
                                ? AppColor.brown2.withOpacity(0.1)
                                : AppColor.grey.withOpacity(0.1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/player.png",
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "USER_ID ${batsman2.id}",
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: AppColor.brown2,
                                    fontFamily: "Lato_Semibold"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                /*    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.red.withOpacity(0.1),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const Center(
                            child: Text(
                              "Not Now",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Lato_Bold",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // changeStrikerApi(battingTeamId, playerId, player2Id);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColor.green_neon.withOpacity(0.1),
                          ),
                          child: const Center(
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                  color: AppColor.green2,
                                  fontFamily: "Lato_Bold",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )*/
              ],
            ),
          );
        });
      },
    );
  }

  void selectStrikerBottomSheet(
      BuildContext context, Batsman batsman, Batsman2 batsman2, Bowler bowler) {
    Navigator.pop(context);
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          var selectedPlayerId = "";
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Select the player who is on strike.",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Lato_Semibold",
                    color: AppColor.text_grey,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: const Text(
                    "Tap on the player to proceed.",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Lato_Semibold",
                      color: AppColor.text_grey,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            strikerId = batsman.id;
                            nonStrikerId = batsman2.id;
                            Map<String, int> map = {
                              "player1_id": strikerId,
                              "player2_id": nonStrikerId.toInt(),
                              "bowler_id": bowlerId.toInt(),
                              "match_id": widget.matchData.id!,
                              "team_id": battingTeamId.toInt(),
                              "team2_id": bowlingTeamId.toInt(),
                            };
                            createConnectionSocket(map);
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedPlayerId == batsman.id.toString()
                                ? AppColor.brown2.withOpacity(0.1)
                                : AppColor.grey.withOpacity(0.1),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/player.png",
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "USER_ID ${batsman.id}",
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: AppColor.brown2,
                                    fontFamily: "Lato_Semibold"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            strikerId = batsman2.id;
                            nonStrikerId = batsman.id;
                            Map<String, int> map = {
                              "player1_id": strikerId,
                              "player2_id": nonStrikerId.toInt(),
                              "bowler_id": bowlerId.toInt(),
                              "match_id": widget.matchData.id!,
                              "team_id": battingTeamId.toInt(),
                              "team2_id": bowlingTeamId.toInt(),
                            };
                            createConnectionSocket(map);
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: selectedPlayerId == batsman2.id.toString()
                                ? AppColor.brown2.withOpacity(0.1)
                                : AppColor.grey.withOpacity(0.1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/player.png",
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "USER_ID ${batsman2.id}",
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: AppColor.brown2,
                                    fontFamily: "Lato_Semibold"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                /*    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.red.withOpacity(0.1),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const Center(
                            child: Text(
                              "Not Now",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Lato_Bold",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // changeStrikerApi(battingTeamId, playerId, player2Id);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColor.green_neon.withOpacity(0.1),
                          ),
                          child: const Center(
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                  color: AppColor.green2,
                                  fontFamily: "Lato_Bold",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )*/
              ],
            ),
          );
        });
      },
    );
  }

  nextBowlerApi(String bowlingTeamId, String bowlerId) async {
    var request = {
      'match_id': matchId.toString(),
      'team_id': bowlingTeamId,
      'player_id': bowlerId,
    };
    await nextBowler(request).then((res) async {
      if (res.success == 1) {
        setState(() {
          debugPrint("NEXT_BOWLER____${res.body.toString()}");
          bowlerBallsCount = 0;
          bowlerRuns.clear();
          setValue(bowlerRunsPerOver, bowlerRuns);
          _showStrikerBottomSheet(context, nonStrikerId.toString(),
              strikerId.toString(), battingTeamId.toString());
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

  maidenOverApi(String bowlingTeamId, String bowlerId) async {
    var request = {
      'match_id': matchId.toString(),
      'team_id': bowlingTeamId,
      'bowler_id': bowlerId,
    };
    await maidenOver(request).then((res) async {
      if (res.success == 1) {
        setState(() {
          debugPrint("Maiden Over${res.body.toString()}");
          setState(() {
            toast(res.message);
            debugPrint("NEXT_BOWLER____${res.body.toString()}");
            bowlerBallsCount = 0;
            bowlerRuns.clear();
            setValue(bowlerRunsPerOver, bowlerRuns);
          });
          Navigator.push(
              getContext,
              MaterialPageRoute(
                  builder: (context) => SelectPlayerForMatch(
                        teamId: bowlingTeamId.toString(),
                        teamName: "Select new bowler",
                        bowlerId: bowlerId.toString(),
                      ))).then((value) {
            if (value != null && value != "add_teams") {
              setState(() {
                debugPrint("BOWLER_ID $value");
                bowlerId = value.toString();
                nextBowlerApi(bowlingTeamId.toString(), bowlerId.toString());
              });
            }
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

  changeStrikerApi(
      String battingTeamId, String playerId, String player2Id) async {
    var request = {
      'match_id': matchId.toString(),
      'team_id': battingTeamId,
      'player_id': playerId,
    };
    await changeStriker(request).then((res) async {
      if (res.success == 1) {
        setState(() {
          strikerId = playerId.toInt();
          nonStrikerId = player2Id.toInt();
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
}
