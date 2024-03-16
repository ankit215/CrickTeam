import 'package:crick_team/modalClasses/GetMatchModel.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apiRelatedFiles/rest_apis.dart';
import '../loginSignupRelatedFiles/LoginScreen.dart';
import '../main.dart';
import '../startMatchRelatedScreens/SelectPlayerForMatch.dart';
import '../utils/CommonFunctions.dart';
import '../utils/common.dart';

class OutModel {
  String? outTitle;
  String? outImage;
  String? type;

  OutModel(this.outTitle, this.outImage, this.type);
}

class OutScreen extends StatefulWidget {
  final int bowlingTeamId;
  final int battingTeamId;
  final int bowlerId;
  final int batterId;
  final int batterNotOutId;
  final UpcomingListArr matchData;

  const OutScreen({super.key,
    required this.bowlingTeamId,
    required this.battingTeamId,
    required this.matchData,
    required this.bowlerId,
    required this.batterId, required this.batterNotOutId});

  @override
  State<OutScreen> createState() => _OutScreenState();
}

class _OutScreenState extends State<OutScreen> {
  List<OutModel> outList = [
    OutModel("Bowled", "assets/bowled.png", "1"),
    OutModel("Caught", "assets/caught.png", "2"),
    OutModel("Caught Behind", "assets/caught_behind.png", "2"),
    OutModel("Caught & Bowled", "assets/caught_bowled.png", "2"),
    OutModel("Stumped", "assets/stumped.png", "5"),
    OutModel("Run Out", "assets/run_out.png", "6"),
    OutModel("LBW", "assets/lbw.png", "7"),
    // OutModel("Hit Wicket", "assets/hit_wicket.png"),
    OutModel("Retired Hurt", "assets/retired_hurt.png", "8"),
    // OutModel("Retired Out", "assets/retired_out.png"),
    // OutModel("Run Out", "assets/run_out.png"),
    // OutModel("Absent", "assets/absent.png"),
    // OutModel("Obstr the field", "assets/obstr_the_field.png"),
    // OutModel("Timed Out", "assets/timed_out.png"),
    // OutModel("Retired", "assets/retired.png"),
  ];
  var dismissalType = "";

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
          "Out how?",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Lato_Semibold",
            color: AppColor.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        childAspectRatio: 0.7,
        scrollDirection: Axis.vertical,
        children: List.generate(outList.length, (index) {
          return GestureDetector(
            onTap: () {
              dismissalType = outList[index].type!;
              if(dismissalType=="1"||dismissalType=="7"){
                outPlayerApi("0");
              }else{
                Navigator.push(
                    getContext,
                    MaterialPageRoute(
                        builder: (context) =>
                            SelectPlayerForMatch(
                              teamId: widget.bowlingTeamId.toString(),
                              teamName: "Select fielder",
                              bowlerId: "",
                            ))).then((value) {
                  if (value != "add_teams") {
                    debugPrint("selected_fielder $value");
                    outPlayerApi(value.toString());
                  }
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Image.asset(
                    outList[index].outImage.toString(),
                    fit: BoxFit.cover,
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    outList[index].outTitle.toString(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: "Lato_Semibold",
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  outPlayerApi(String fielderID) async {
    var request = {
      'match_id': widget.matchData.id.toString(),
      'team_id': widget.battingTeamId.toString(),
      'player_id': widget.batterId.toString(),
      'dismissal_type': dismissalType,
      'fielder_id':fielderID,
      'bowler_id': widget.bowlerId.toString(),
      'team2_id': widget.bowlingTeamId.toString(),
    };
    await outPlayer(request).then((res) async {
      if (res.success == 1) {
        setState(() {
          debugPrint("OUT_Player___${res.body.toString()}");
          Navigator.push(
              getContext,
              MaterialPageRoute(
                  builder: (context) =>
                      SelectPlayerForMatch(
                        teamId: widget.battingTeamId.toString(),
                        teamName: "Select next batsmen",
                        bowlerId: "",
                        from: "scorer",
                        batterNotOutId: widget.batterNotOutId.toString(),
                        matchId: widget.matchData.id.toString(),
                      ))).then((value) {
            if (value != "add_teams") {
              debugPrint("selected_new_BATTER $value");
             Navigator.pop(context,value);
            }
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
}
