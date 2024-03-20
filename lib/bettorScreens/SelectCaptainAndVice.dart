import 'dart:convert';

import 'package:crick_team/bettorScreens/PreviewTeamScreen.dart';
import 'package:crick_team/modalClasses/MatchDetailModel.dart';
import 'package:crick_team/utils/constant.dart';
import 'package:crick_team/utils/search_delay_function.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:crick_team/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apiRelatedFiles/rest_apis.dart';
import '../loginSignupRelatedFiles/LoginScreen.dart';
import '../main.dart';
import '../modalClasses/GetContestModel.dart';
import '../modalClasses/GetMatchModel.dart';
import '../modalClasses/MyContestModel.dart';
import '../modalClasses/TeamSelected.dart';
import '../utils/CommonFunctions.dart';
import '../utils/common.dart';

class SelectCaptainAndVice extends StatefulWidget {
  final List<PlayerList> players;
  final MatchDetailData matchData;
  final GetContestData contestData;
  final String? from;

  const SelectCaptainAndVice(
      {super.key,
      required this.players,
      required this.matchData,
      required this.contestData,
      this.from});

  @override
  State<SelectCaptainAndVice> createState() => _AddTeamsState();
}

class _AddTeamsState extends State<SelectCaptainAndVice> {
  TextEditingController searchController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final searchDelay = SearchDelayFunction();
  var searchStr = "";
  int captainId = 0;
  int viceCaptainId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.from == "team_list") {
      for (int i = 0; i < widget.players.length; i++) {
        if (widget.players[i].isCaptain == 1) {
          captainId = widget.players[i].playerId!;
        } else if (widget.players[i].isViceCaption == 1) {
          viceCaptainId = widget.players[i].playerId!;
        }
      }
    } else {
      for (int i = 0; i < widget.players.length; i++) {
        widget.players[i].isCaptain = 0;
        widget.players[i].isViceCaption = 0;
      }
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: widget.players.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                          color: AppColor.transparent,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              decoration: BoxDecoration(
                                gradient: widget.players[index].playerSelected
                                    ? LinearGradient(
                                        colors: [
                                          AppColor.red.withOpacity(0.2),
                                          AppColor.brown2.withOpacity(0.2)
                                        ],
                                      )
                                    : LinearGradient(
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.players[index]
                                                            .playerName ==
                                                        null
                                                    ? "Player"
                                                    : widget.players[index]
                                                        .playerName
                                                        .toString(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "Lato_Semibold",
                                                  color: widget.players[index]
                                                          .playerSelected
                                                      ? AppColor.brown2
                                                      : AppColor.medGrey,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    color: widget.players[index]
                                                            .playerSelected
                                                        ? AppColor.brown2
                                                        : AppColor.medGrey,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    widget
                                                        .players[index].teamName
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily:
                                                          "Lato_Semibold",
                                                      color: widget
                                                              .players[index]
                                                              .playerSelected
                                                          ? AppColor.brown2
                                                          : AppColor.medGrey,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    /*  widget.players[index].playerSelected
                                      ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                      : const SizedBox()*/
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (widget.players[index]
                                                      .isViceCaption ==
                                                  1) {
                                                for (int i = 0;
                                                    i < widget.players.length;
                                                    i++) {
                                                  widget.players[i].isCaptain =
                                                      0;
                                                  widget.players[i]
                                                      .isViceCaption = 0;
                                                }
                                                widget.players[index]
                                                    .isCaptain = 1;
                                                widget.players[index]
                                                    .isViceCaption = 0;
                                                captainId = widget
                                                    .players[index].playerId!;
                                                // CommonFunctions().showToastMessage(
                                                //     context,
                                                //     "Player is already selected as Vice Captain.");
                                              } else {
                                                for (int i = 0;
                                                    i < widget.players.length;
                                                    i++) {
                                                  widget.players[i].isCaptain =
                                                      0;
                                                }
                                                widget.players[index]
                                                    .isCaptain = 1;
                                                captainId = widget
                                                    .players[index].playerId!;
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: widget.players[index]
                                                            .isCaptain ==
                                                        1
                                                    ? AppColor.brown2
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                    width: 2,
                                                    color: widget.players[index]
                                                                .isCaptain ==
                                                            1
                                                        ? Colors.white
                                                        : AppColor.brown3)),
                                            child: Center(
                                              child: Text(
                                                widget.players[index]
                                                            .isCaptain ==
                                                        1
                                                    ? "2x"
                                                    : "C",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Lato_Semibold",
                                                  color: widget.players[index]
                                                              .isCaptain ==
                                                          1
                                                      ? Colors.white
                                                      : AppColor.brown3,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (widget.players[index]
                                                      .isCaptain ==
                                                  1) {
                                                for (int i = 0;
                                                    i < widget.players.length;
                                                    i++) {
                                                  widget.players[i].isCaptain =
                                                      0;
                                                  widget.players[i]
                                                      .isViceCaption = 0;
                                                }
                                                widget.players[index]
                                                    .isCaptain = 0;
                                                widget.players[index]
                                                    .isViceCaption = 1;
                                                viceCaptainId = widget
                                                    .players[index].playerId!;
                                                // CommonFunctions().showToastMessage(
                                                //     context,
                                                //     "Player is already selected as Captain.");
                                              } else {
                                                for (int i = 0;
                                                    i < widget.players.length;
                                                    i++) {
                                                  widget.players[i]
                                                      .isViceCaption = 0;
                                                }
                                                widget.players[index]
                                                    .isViceCaption = 1;
                                                viceCaptainId = widget
                                                    .players[index].playerId!;
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: widget.players[index]
                                                            .isViceCaption ==
                                                        1
                                                    ? AppColor.brown2
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                    width: 2,
                                                    color: widget.players[index]
                                                                .isViceCaption ==
                                                            1
                                                        ? Colors.white
                                                        : AppColor.brown3)),
                                            child: Center(
                                              child: Text(
                                                widget.players[index]
                                                            .isViceCaption ==
                                                        1
                                                    ? "1.5x"
                                                    : "VC",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Lato_Semibold",
                                                  color: widget.players[index]
                                                              .isViceCaption ==
                                                          1
                                                      ? Colors.white
                                                      : AppColor.brown3,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              ))),
                    );
                  })),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      getContext,
                      MaterialPageRoute(
                          builder: (context) => PreviewTeamScreen(
                                players: widget.players,
                                captainId: captainId,
                                viceCaptainId: viceCaptainId,
                              )));
                },
                child: Card(
                    color: AppColor.grey,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    elevation: 0.2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColor.red.withOpacity(0.7),
                              AppColor.brown2.withOpacity(0.7),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "TEAM PREVIEW",
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
              GestureDetector(
                onTap: () {
                  if (captainId == 0 || viceCaptainId == 0) {
                    CommonFunctions().showToastMessage(
                        context, "Please select captain and vice captain.");
                  } else if(widget.from=="my_contest") {
                    editContestApi();
                  }else{
                    _showBottomSheet(context);
                  }
                },
                child: Card(
                    color: AppColor.grey,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    elevation: 0.2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          gradient: captainId == 0 || viceCaptainId == 0
                              ? LinearGradient(
                                  colors: [
                                    AppColor.grey.withOpacity(0.7),
                                    AppColor.grey.withOpacity(0.7),
                                  ],
                                )
                              : LinearGradient(
                                  colors: [
                                    AppColor.red.withOpacity(0.7),
                                    AppColor.brown2.withOpacity(0.7),
                                  ],
                                ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/trophy.png",
                                height: 20,
                                width: 20,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                               Text(
                              widget.from=="my_contest"?"EDIT CONTEST":  "CREATE CONTEST",
                                style: const TextStyle(
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
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const Text(
              "CONFIRMATION",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Lato_Bold",
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Are you sure want to join this contest?",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Lato_Bold",
                color: AppColor.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "To Pay ",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Lato_Bold",
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "₹${widget.contestData.entryFee}",
                    style: const TextStyle(
                        fontFamily: "Lato_Semibold",
                        color: Colors.deepOrange,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                createContestApi();
              },
              child: Card(
                  color: AppColor.grey,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  elevation: 0.2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        gradient: captainId == 0 || viceCaptainId == 0
                            ? LinearGradient(
                                colors: [
                                  AppColor.grey.withOpacity(0.7),
                                  AppColor.grey.withOpacity(0.7),
                                ],
                              )
                            : const LinearGradient(
                                colors: [
                                  AppColor.green,
                                  AppColor.green,
                                ],
                              ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/trophy.png",
                              height: 20,
                              width: 20,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
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
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }

  createContestApi() async {
    var request = {
      'user_id': getStringAsync(userId),
      'contest_id': widget.contestData.id.toString(),
      'match_id': widget.matchData.id.toString(),
      'selected_team': jsonEncode(widget.players),
      'contest_fee': widget.contestData.entryFee.toString(),
    };
    await createContestTeam(request).then((res) async {
      if (res.success == 1) {
        Future.delayed(Duration.zero, () {
          Navigator.pop(context, "create_contest");
          Navigator.pop(context, "create_contest");
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
  editContestApi() async {
    var request = {
      'user_id': getStringAsync(userId),
      'contest_id': widget.contestData.id.toString(),
      'match_id': widget.matchData.id.toString(),
      'selected_team': jsonEncode(widget.players),
    };
    await editContest(request).then((res) async {
      if (res.success == 1) {
        toast(res.message.toString());
        Future.delayed(Duration.zero, () {
          Navigator.pop(context, "edit_contest");
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
