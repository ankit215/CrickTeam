import 'package:crick_team/modalClasses/GetMatchModel.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../startMatchRelatedScreens/SelectPlayerForMatch.dart';

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
  final GetMatchData matchData;
  const OutScreen({super.key, required this.bowlingTeamId, required this.battingTeamId, required this.matchData, required this.bowlerId, required this.batterId});

  @override
  State<OutScreen> createState() => _OutScreenState();
}

class _OutScreenState extends State<OutScreen> {
  List<OutModel> outList = [OutModel("Bowled", "assets/bowled.png","1"),
    OutModel("Caught", "assets/caught.png","2"),
    OutModel("Caught Behind", "assets/caught_behind.png","2"),
    OutModel("Caught & Bowled", "assets/caught_bowled.png","2"),
    OutModel("Stumped", "assets/stumped.png","5"),
    OutModel("Run Out", "assets/run_out.png","6"),
    OutModel("LBW", "assets/lbw.png","7"),
    // OutModel("Hit Wicket", "assets/hit_wicket.png"),
    OutModel("Retired Hurt", "assets/retired_hurt.png","8"),
    // OutModel("Retired Out", "assets/retired_out.png"),
    // OutModel("Run Out", "assets/run_out.png"),
    // OutModel("Absent", "assets/absent.png"),
    // OutModel("Obstr the field", "assets/obstr_the_field.png"),
    // OutModel("Timed Out", "assets/timed_out.png"),
    // OutModel("Retired", "assets/retired.png"),

  ];

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
            onTap: (){
              Navigator.push(
                  getContext,
                  MaterialPageRoute(
                      builder: (context) => SelectPlayerForMatch(
                        teamId: widget.battingTeamId.toString(),
                        teamName: widget.matchData.team2Name.toString(),
                        bowlerId: widget.bowlerId.toString(),
                      ))).then((value) {
                if (value != "add_teams") {
                  setState(() {
                    debugPrint("BOWLER_ID $value");
                    Navigator.pop(context,value);
                  });
                }
              });
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
}
