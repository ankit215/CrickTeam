import 'package:crick_team/utils/search_delay_function.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../modalClasses/TeamSelected.dart';
import '../utils/CommonFunctions.dart';

class SelectCaptainAndVice extends StatefulWidget {
  final List<Players> players;

  const SelectCaptainAndVice({super.key, required this.players});

  @override
  State<SelectCaptainAndVice> createState() => _AddTeamsState();
}

class _AddTeamsState extends State<SelectCaptainAndVice> {
  TextEditingController searchController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final searchDelay = SearchDelayFunction();
  var searchStr = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          GestureDetector(
            onTap: () {},
            child: Card(
                color: AppColor.grey,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                elevation: 0.2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
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
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Lato_Bold",
                          color: AppColor.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ))),
          ),
          const SizedBox(
            height: 10,
          ),
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
                                                            .playerId ==
                                                        null
                                                    ? "Player"
                                                    : widget
                                                        .players[index].playerId
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
                                                    Icons.call,
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
                                                    widget.players[index]
                                                        .playerType
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
                                                  .isViceCaptain) {
                                                CommonFunctions().showToastMessage(
                                                    context,
                                                    "Player is already selected as Vice Captain.");
                                              } else {
                                                for (int i = 0;
                                                    i < widget.players.length;
                                                    i++) {
                                                  widget.players[i].isCaptain =
                                                      false;
                                                }
                                                widget.players[index]
                                                    .isCaptain = true;
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: widget.players[index]
                                                        .isCaptain
                                                    ? AppColor.brown2
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                    width: 2,
                                                    color: widget.players[index]
                                                            .isCaptain
                                                        ? Colors.white
                                                        : AppColor.brown3)),
                                            child: Center(
                                              child: Text(
                                                widget.players[index].isCaptain
                                                    ? "2x"
                                                    : "C",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Lato_Semibold",
                                                  color: widget.players[index]
                                                          .isCaptain
                                                      ? Colors.white
                                                      : AppColor.brown3,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (widget.players[index]
                                                  .isCaptain) {
                                                CommonFunctions().showToastMessage(
                                                    context,
                                                    "Player is already selected as Captain.");
                                              } else {
                                                for (int i = 0;
                                                    i < widget.players.length;
                                                    i++) {
                                                  widget.players[i]
                                                      .isViceCaptain = false;
                                                }
                                                widget.players[index]
                                                    .isViceCaptain = true;
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: widget.players[index]
                                                        .isViceCaptain
                                                    ? AppColor.brown2
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                    width: 2,
                                                    color: widget.players[index]
                                                            .isViceCaptain
                                                        ? Colors.white
                                                        : AppColor.brown3)),
                                            child: Center(
                                              child: Text(
                                                widget.players[index]
                                                        .isViceCaptain
                                                    ? "1.5x"
                                                    : "VC",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Lato_Semibold",
                                                  color: widget.players[index]
                                                          .isViceCaptain
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
        ],
      ),
    );
  }
}
