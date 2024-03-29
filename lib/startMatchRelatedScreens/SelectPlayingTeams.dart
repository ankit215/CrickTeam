import 'package:crick_team/modalClasses/TeamSelected.dart';
import 'package:crick_team/startMatchRelatedScreens/SelectTeam.dart';
import 'package:crick_team/startMatchRelatedScreens/StartMatch.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../mainScreens/MainScreen.dart';
import '../utils/CommonFunctions.dart';
import '../utils/constant.dart';

class SelectPlayingTeams extends StatefulWidget {
  final TeamSelected teamASelected;

  final TeamSelected teamBSelected;

  const SelectPlayingTeams(
      {super.key, required this.teamASelected, required this.teamBSelected});

  @override
  State<SelectPlayingTeams> createState() => _SelectPlayingState();
}

class _SelectPlayingState extends State<SelectPlayingTeams> {
  TeamSelected teamASelected = TeamSelected();
  TeamSelected teamBSelected = TeamSelected();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    teamASelected = widget.teamASelected;
    teamBSelected = widget.teamBSelected;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        Navigator.push(
            getContext,
            MaterialPageRoute(
                builder: (context) => MainScreen(
                      index: 0,
                    )));
      },
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: AppColor.brown2,
          leading: GestureDetector(
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(
                  getContext,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(
                            index: 0,
                          )));
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
            "Select Playing Teams",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Lato_Semibold",
              color: AppColor.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.9,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            getContext,
                            MaterialPageRoute(
                                builder: (context) => SelectTeam(
                                      team: "A",
                                      teamASelected: teamASelected,
                                      teamBSelected: teamBSelected,
                                    )));
                      },
                      child: Center(
                        child: teamASelected.getTeamData == null
                            ? const Icon(
                          Icons.add_circle_rounded,
                          color: AppColor.medBrown,
                          size: 100,
                        )
                            : teamASelected.getTeamData != null &&
                            teamASelected.getTeamData!.teamPhoto == null
                            ? CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                              child: Image.asset(
                                "assets/team_placeholder.png",
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover,
                              )),
                        )
                            : CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                    child: Image.network(
                                  mediaUrl +
                                      teamASelected.getTeamData!.teamPhoto
                                          .toString(),
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.cover,
                                )),
                              ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            getContext,
                            MaterialPageRoute(
                                builder: (context) => SelectTeam(
                                      team: "A",
                                      teamASelected: teamASelected,
                                      teamBSelected: teamBSelected,
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.brown2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            widget.teamASelected.getTeamData == null
                                ? "Select Team A"
                                : widget.teamASelected.getTeamData!.name
                                    .toString(),
                            style: const TextStyle(
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
                      height: 10,
                    ),
                    Image.asset(
                      "assets/vs.png",
                      color: AppColor.brown2,
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            getContext,
                            MaterialPageRoute(
                                builder: (context) => SelectTeam(
                                      team: "B",
                                      teamASelected: teamASelected,
                                      teamBSelected: teamBSelected,
                                    )));
                      },
                      child: Center(
                        child: teamBSelected.getTeamData == null
                            ? const Icon(
                                Icons.add_circle_rounded,
                                color: AppColor.medBrown,
                                size: 100,
                              )
                            : teamBSelected.getTeamData != null &&
                                    teamBSelected.getTeamData!.teamPhoto == null
                                ? CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                        child: Image.asset(
                                      "assets/team_placeholder.png",
                                      height: 90,
                                      width: 90,
                                      fit: BoxFit.cover,
                                    )),
                                  )
                                : CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                        child: Image.network(
                                      mediaUrl +
                                          teamBSelected.getTeamData!.teamPhoto
                                              .toString(),
                                      height: 90,
                                      width: 90,
                                      fit: BoxFit.cover,
                                    )),
                                  ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            getContext,
                            MaterialPageRoute(
                                builder: (context) => SelectTeam(
                                      team: "B",
                                      teamASelected: teamASelected,
                                      teamBSelected: teamBSelected,
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.brown2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            widget.teamBSelected.getTeamData == null
                                ? "Select Team B"
                                : widget.teamBSelected.getTeamData!.name
                                    .toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: "Lato_Sembold",
                              color: AppColor.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (teamASelected.getTeamData == null) {
                    CommonFunctions()
                        .showToastMessage(getContext, "Please select teams.");
                  } else if (teamBSelected.getTeamData == null) {
                    CommonFunctions()
                        .showToastMessage(getContext, "Please select teams.");
                  } else {
                    Navigator.push(
                        getContext,
                        MaterialPageRoute(
                            builder: (context) => StartMatch(
                                  teamBSelected: teamBSelected,
                                  teamASelected: teamASelected,
                                )));
                  }
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
                      "Continue",
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
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
