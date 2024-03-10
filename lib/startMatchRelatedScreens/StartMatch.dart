import 'dart:convert';
import 'package:crick_team/apiRelatedFiles/rest_apis.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:crick_team/utils/data_type_extension.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../loginSignupRelatedFiles/LoginScreen.dart';
import '../main.dart';
import '../mainScreens/MainScreen.dart';
import '../modalClasses/GetPlayerSearchModel.dart';
import '../modalClasses/GetTeamModel.dart';
import '../modalClasses/TeamSelected.dart';
import '../utils/CommonFunctions.dart';
import '../utils/common.dart';
import '../utils/constant.dart';
import '../utils/search_delay_function.dart';

class StartMatch extends StatefulWidget {
  final TeamSelected teamASelected;
  final TeamSelected teamBSelected;

  const StartMatch(
      {super.key, required this.teamASelected, required this.teamBSelected});

  @override
  State<StartMatch> createState() => _StartMatchState();
}

class MatchOfficials {
  final String title;
  bool isSelected;

  MatchOfficials({required this.title, required this.isSelected});
}

class Team {
  final String? playerName;
  bool? playerSelected;

  Team({this.playerName, this.playerSelected});
}

class _StartMatchState extends State<StartMatch> {
  TextEditingController noOfOvers = TextEditingController();
  TextEditingController overPerBowler = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController groundController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final searchDelay = SearchDelayFunction();
  var searchStr = "";
  List<GetPlayerSearchData> teamPlayerSearchedList = [];
  List<GetTeamData> teamList = [];
  List<Players> playersList = [];
  List<MatchOfficials> matchOfficials = <MatchOfficials>[
    MatchOfficials(
      title: 'Scorer',
      isSelected: false,
    ),
    /*MatchOfficials(
      title: 'Umpire',
      isSelected: false,
    ),*/
  ];
  var timeValue = "";
  var dateValue = "";
  var teamOneJson = "";
  var teamTwoJson = "";
  var playerListJson = "";
  var scorerId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Convert the list to JSON
    teamOneJson = jsonEncode(widget.teamASelected.players);
    teamTwoJson = jsonEncode(widget.teamBSelected.players);
    playersList.clear();
    playersList.addAll(widget.teamASelected.players!);
    playersList.addAll(widget.teamBSelected.players!);
    playerListJson = jsonEncode(playersList);
    debugPrint("ffsfdsf" + teamOneJson);
    debugPrint("ffsfdsf" + teamTwoJson);
    debugPrint("ffsfdsf" + playerListJson);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
            "START A MATCH",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Lato_Semibold",
              color: AppColor.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        // AppColor.yellow.withOpacity(0.5),
                        AppColor.brown2,
                        AppColor.brown2,
                        // AppColor.yellowMed.withOpacity(0.5),
                      ]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/crick_layout_background.png",
                            fit: BoxFit.contain,
                            height: 140,
                            width: 120,
                            color: Colors.white,
                            opacity: const AlwaysStoppedAnimation(.2),
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Text(
                              "${widget.teamASelected.getTeamData!.name} vs ${widget.teamBSelected.getTeamData!.name}",
                              style: const TextStyle(
                                  fontFamily: "Lato_Semibold",
                                  color: AppColor.white,
                                  fontSize: 16),
                            )),
                            Container(
                              height: 1,
                              color: AppColor.lightBrown,
                              margin: const EdgeInsets.only(top: 4),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Center(
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 47,
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.29,
                                          decoration: BoxDecoration(
                                            color: AppColor.yellowMed
                                                .withOpacity(0.4),
                                          ),
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                              getFirstLetters(widget
                                                  .teamASelected.getTeamData!.name
                                                  .toString()),
                                              style: const TextStyle(
                                                  fontFamily: "Lato_Semibold",
                                                  color: AppColor.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width:
                                                MediaQuery.sizeOf(context).width *
                                                    0.2,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 30,
                                            child: ClipOval(
                                                child: widget
                                                            .teamASelected
                                                            .getTeamData!
                                                            .teamPhoto ==
                                                        null
                                                    ? Image.asset(
                                                        "assets/team_placeholder.png",
                                                        fit: BoxFit.cover,
                                                        height: 45,
                                                        width: 45,
                                                      )
                                                    : Image.network(
                                                        mediaUrl +
                                                            widget
                                                                .teamASelected
                                                                .getTeamData!
                                                                .teamPhoto
                                                                .toString(),
                                                        fit: BoxFit.contain,
                                                        height: 45,
                                                        width: 45,
                                                      )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    "assets/vs.png",
                                    color: AppColor.white,
                                  ),
                                  Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 45,
                                        width: MediaQuery.sizeOf(context).width *
                                            0.3,
                                        decoration: BoxDecoration(
                                          color:
                                              AppColor.yellowMed.withOpacity(0.4),
                                        ),
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          margin:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            getFirstLetters(widget
                                                .teamBSelected.getTeamData!.name
                                                .toString()),
                                            style: const TextStyle(
                                                fontFamily: "Lato_Semibold",
                                                color: AppColor.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 30,
                                            child: ClipOval(
                                                child: widget
                                                            .teamBSelected
                                                            .getTeamData!
                                                            .teamPhoto ==
                                                        null
                                                    ? Image.asset(
                                                        "assets/team_placeholder.png",
                                                        fit: BoxFit.cover,
                                                        height: 45,
                                                        width: 45,
                                                      )
                                                    : Image.network(
                                                        mediaUrl +
                                                            widget
                                                                .teamBSelected
                                                                .getTeamData!
                                                                .teamPhoto
                                                                .toString(),
                                                        fit: BoxFit.cover,
                                                        height: 45,
                                                        width: 45,
                                                      )),
                                          ),
                                          SizedBox(
                                            width:
                                                MediaQuery.sizeOf(context).width *
                                                    0.2,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            /*  Text(
                              "15:00",
                              style: const TextStyle(
                                  fontFamily: "Lato_Semibold",
                                  color: AppColor.white,
                                  fontSize: 16),
                            ),*/
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "No. of Overs *",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: AppColor.brown2,
                                fontFamily: "Lato_Semibold"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: AppColor.white,
                                border: Border.all(color: AppColor.border)),
                            child: Center(
                              child: TextField(
                                controller: noOfOvers,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration.collapsed(
                                    hintText: 'Enter no. of overs',
                                    hintStyle: TextStyle(color: AppColor.grey)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    /* Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Overs per Bowler",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: AppColor.brown2,
                                fontFamily: "Lato_Semibold"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: AppColor.white,
                                border: Border.all(color: AppColor.border)),
                            child: Center(
                              child: TextField(
                                controller: overPerBowler,
                                decoration: const InputDecoration.collapsed(
                                    hintText: 'Enter overs per bowler',
                                    hintStyle: TextStyle(color: AppColor.grey)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )*/
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "City/Town *",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: AppColor.brown2,
                      fontFamily: "Lato_Semibold"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: AppColor.white,
                      border: Border.all(color: AppColor.border)),
                  child: Center(
                    child: TextField(
                      controller: cityController,
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Enter city/town name',
                          hintStyle: TextStyle(color: AppColor.grey)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Ground *",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: AppColor.brown2,
                      fontFamily: "Lato_Semibold"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: AppColor.white,
                      border: Border.all(color: AppColor.border)),
                  child: Center(
                    child: TextField(
                      controller: groundController,
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Enter ground name',
                          hintStyle: TextStyle(color: AppColor.grey)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Date",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: AppColor.brown2,
                      fontFamily: "Lato_Semibold"),
                ),
                Container(
                  // color: Colors.red,
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  height: 55,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: AppColor.lightGrey,
                      border: Border.all(color: AppColor.grey)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            Future.delayed(Duration.zero, () {
                              FocusManager.instance.primaryFocus?.unfocus();
                            });
                            var date = await CommonFunctions.selectDate();
                            dateController.text = date;
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.width * 0.07,
                            child: TextField(
                              enabled: false,
                              controller: dateController,
                              readOnly: true,
                              decoration: const InputDecoration.collapsed(
                                hintText: 'Choose Date',
                                hintStyle: TextStyle(
                                    color: AppColor.textColor,
                                    fontFamily: "Ubuntu_Regular"),
                              ),
                              style: const TextStyle(
                                  fontFamily: "Ubuntu_Regular",
                                  color: AppColor.brown2),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      const Icon(Icons.calendar_month)
                    ],
                  ),
                ),
                const Text(
                  "Time",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: AppColor.brown2,
                      fontFamily: "Lato_Semibold"),
                ),
                Container(
                  // color: Colors.red,
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  height: 55,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: AppColor.lightGrey,
                      border: Border.all(color: AppColor.grey)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            debugPrint("TIMEssss");
                            DateTime currentTime = DateTime.now();
                            int currentHour = currentTime.hour;
                            int currentMinute = currentTime.minute;
                            Time time = Time(hour: currentHour, minute: currentMinute);
                            Navigator.of(context).push(showPicker(
                              context: context,
                              iosStylePicker: true,
                              value: time,
                              sunrise:  TimeOfDay(hour: currentHour, minute: currentMinute),
                              // optional
                              sunset: const TimeOfDay(hour: 18, minute: 0),
                              // optional
                              duskSpanInMinutes: 120,
                              // optional
                              onChange: (value) {
                                timeValue =
                                    "${value.hour.toString()}:${value.minute.toString()}";
                                debugPrint("TIME $timeValue");
                                timeController.text = timeValue;
                              },
                            ));
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.width * 0.07,
                            child: TextField(
                              enabled: false,
                              controller: timeController,
                              readOnly: true,
                              decoration: const InputDecoration.collapsed(
                                hintText: 'Choose Time',
                                hintStyle: TextStyle(
                                    color: AppColor.textColor,
                                    fontFamily: "Ubuntu_Regular"),
                              ),
                              style: const TextStyle(
                                  fontFamily: "Ubuntu_Regular",
                                  color: AppColor.brown2),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      const Icon(Icons.access_time)
                    ],
                  ),
                ),
                const Text(
                  "Match Official",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: AppColor.brown2,
                      fontFamily: "Lato_Semibold"),
                ),
                Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: matchOfficials.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          /* matchOfficials[index].title.toLowerCase() == "scorer"
                              ?*/
                          showScorerDialog();
                          /*: showChooseUmpireDialog();*/
                          /*   setState(() {
                            for (int i = 0; i < matchOfficials.length; i++) {
                              matchOfficials[i].isSelected = false;
                            }
                            matchOfficials[index].isSelected = true;
                          });*/
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 5, right: 20),
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  gradient: /* (matchOfficials[index].isSelected == true)
                                      ? const LinearGradient(
                                          colors: [
                                            AppColor.yellowV2,
                                            AppColor.red
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        )
                                      :*/
                                      const LinearGradient(
                                    colors: [
                                      AppColor.white,
                                      AppColor.white,
                                      AppColor.white
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1,
                                      color:
                                          /* (matchOfficials[index].isSelected == true)
                                              ? AppColor.white
                                              :*/
                                          AppColor.brown2),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    matchOfficials[index].title.toLowerCase() ==
                                            "scorer"
                                        ? "assets/scorer.png"
                                        : "assets/umpire.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                )),
                            Container(
                              margin: const EdgeInsets.only(left: 5, right: 20),
                              child: Text(
                                matchOfficials[index].title,
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: AppColor.brown2,
                                    fontFamily: "Lato_Semibold"),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (checkValidation()) {
                      createPlayerApi();
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showScorerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Dialog(
            surfaceTintColor: Colors.white,
            backgroundColor: AppColor.white,
            insetPadding: const EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 16,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              CupertinoIcons.xmark_circle_fill,
                              color: AppColor.brown2,
                              size: 40,
                            )),
                      ),
                      const Text(
                        'Add Scorer',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: "Lato_Semibold",
                            color: AppColor.brown2),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        "assets/scorer.png",
                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Scorer mobile no.*",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: AppColor.brown2,
                              fontFamily: "Lato_Semibold"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 55,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: AppColor.white,
                            border: Border.all(color: AppColor.border)),
                        child: Center(
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            onChanged: (value) {
                              searchStr = value;
                              searchDelay.run(() async {
                                if (searchStr.isEmpty) {
                                  setState(() {
                                    phoneController.text = "";
                                    searchStr = "";
                                    teamPlayerSearchedList.clear();
                                  });
                                } else {
                                  teamPlayerSearchedList =
                                      await getPlayerSearchApi(searchStr);
                                  setState(() {});
                                }
                              });
                            },
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Enter mobile number',
                                hintStyle: TextStyle(color: AppColor.grey)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                            itemCount: teamPlayerSearchedList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    for (int i = 0;
                                        i < teamPlayerSearchedList.length;
                                        i++) {
                                      teamPlayerSearchedList[i].playerSelected =
                                          false;
                                    }
                                    teamPlayerSearchedList[index]
                                        .playerSelected = true;
                                    scorerId = teamPlayerSearchedList[index]
                                        .id
                                        .toString();
                                    print("dfdfsdf" + scorerId);
                                  });
                                },
                                child: Card(
                                    color: Colors.white,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.9,
                                        decoration: BoxDecoration(
                                          gradient:
                                              teamPlayerSearchedList[index]
                                                      .playerSelected
                                                  ? const LinearGradient(
                                                      colors: [
                                                        AppColor.red,
                                                        AppColor.brown2
                                                      ],
                                                    )
                                                  : LinearGradient(
                                                      colors: [
                                                        AppColor.grey
                                                            .withOpacity(0.2),
                                                        AppColor.grey
                                                            .withOpacity(0.2),
                                                      ],
                                                    ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      radius: 30,
                                                      child: ClipOval(
                                                          child: Image.asset(
                                                        "assets/scorer.png",
                                                        fit: BoxFit.contain,
                                                        height: 45,
                                                        width: 45,
                                                      )),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          teamPlayerSearchedList[
                                                                          index]
                                                                      .name ==
                                                                  null
                                                              ? "Player"
                                                              : teamPlayerSearchedList[
                                                                      index]
                                                                  .name
                                                                  .toString(),
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontFamily:
                                                                "Lato_Semibold",
                                                            color: teamPlayerSearchedList[
                                                                        index]
                                                                    .playerSelected
                                                                ? Colors.white
                                                                : AppColor
                                                                    .medGrey,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.call,
                                                              color: teamPlayerSearchedList[
                                                                          index]
                                                                      .playerSelected
                                                                  ? Colors.white
                                                                  : AppColor
                                                                      .medGrey,
                                                              size: 20,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              teamPlayerSearchedList[
                                                                      index]
                                                                  .mobileNumber
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "Lato_Semibold",
                                                                color: teamPlayerSearchedList[
                                                                            index]
                                                                        .playerSelected
                                                                    ? Colors
                                                                        .white
                                                                    : AppColor
                                                                        .medGrey,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              teamPlayerSearchedList[index]
                                                      .playerSelected
                                                  ? const Icon(
                                                      Icons.check_circle,
                                                      color: Colors.white,
                                                      size: 30,
                                                    )
                                                  : const SizedBox(),
                                              const SizedBox(
                                                width: 10,
                                              )
                                            ],
                                          ),
                                        ))),
                              );
                            }),
                      ),
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [AppColor.red, AppColor.brown2]),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<StadiumBorder>(
                                  const StadiumBorder(),
                                ),
                                elevation: MaterialStateProperty.all(8),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                // elevation: MaterialStateProperty.all(3),
                                shadowColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              onPressed: () {
                                if (phoneController.text.trim().length < 10) {
                                  CommonFunctions().showToastMessage(
                                      context, "Please enter mobile no.");
                                }
                                if (teamPlayerSearchedList.isEmpty &&
                                    phoneController.text.trim().isNotEmpty) {
                                  loginApi();
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('Add',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColor.white,
                                      fontFamily: "Lato_Semibold"),
                                  textAlign: TextAlign.center)),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }

  loginApi() async {
    var request = {
      'mobile_number': phoneController.text.trim(),
      'type': '3',
    };
    await login(request,0).then((res) async {
      debugPrint("res.body!.name: ${res.body!.name.toString()}");
      if (res.success == 1) {
        hideLoader();
        toast("Scorer added successfully");
        scorerId = res.body!.id.toString();
        Navigator.pop(context);
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

  showUmpireDialog(int umpireCount) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Dialog(
            surfaceTintColor: Colors.white,
            backgroundColor: AppColor.white,
            insetPadding: const EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 16,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              CupertinoIcons.xmark_circle_fill,
                              color: AppColor.brown2,
                              size: 40,
                            )),
                      ),
                      Text(
                        umpireCount == 1 ? 'Add 1st Umpire' : "Add 2nd Umpire",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 25,
                            fontFamily: "Lato_Semibold",
                            color: AppColor.brown2),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        "assets/umpire.png",
                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Umpire mobile no.*",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: AppColor.brown2,
                              fontFamily: "Lato_Semibold"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 55,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: AppColor.white,
                            border: Border.all(color: AppColor.border)),
                        child: Center(
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Enter mobile number',
                                hintStyle: TextStyle(color: AppColor.grey)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                            itemCount: teamPlayerSearchedList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return index != teamPlayerSearchedList.length
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          teamPlayerSearchedList[index]
                                                  .playerSelected =
                                              teamPlayerSearchedList[index]
                                                      .playerSelected
                                                  ? false
                                                  : true;
                                        });
                                      },
                                      child: Card(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
                                          elevation: 0.2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(
                                                gradient:
                                                    teamPlayerSearchedList[
                                                                index]
                                                            .playerSelected
                                                        ? const LinearGradient(
                                                            colors: [
                                                              AppColor.red,
                                                              AppColor.brown2
                                                            ],
                                                          )
                                                        : LinearGradient(
                                                            colors: [
                                                              AppColor.grey
                                                                  .withOpacity(
                                                                      0.2),
                                                              AppColor.grey
                                                                  .withOpacity(
                                                                      0.2),
                                                            ],
                                                          ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            radius: 30,
                                                            child: ClipOval(
                                                                child:
                                                                    Image.asset(
                                                              "assets/scorer.png",
                                                              fit: BoxFit
                                                                  .contain,
                                                              height: 45,
                                                              width: 45,
                                                            )),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            teamPlayerSearchedList[
                                                                    index]
                                                                .name
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontFamily:
                                                                  "Lato_Semibold",
                                                              color: teamPlayerSearchedList[
                                                                          index]
                                                                      .playerSelected
                                                                  ? Colors.white
                                                                  : AppColor
                                                                      .medGrey,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    teamPlayerSearchedList[
                                                                index]
                                                            .playerSelected
                                                        ? const Icon(
                                                            Icons.check_circle,
                                                            color: Colors.white,
                                                            size: 30,
                                                          )
                                                        : const SizedBox(),
                                                    const SizedBox(
                                                      width: 10,
                                                    )
                                                  ],
                                                ),
                                              ))),
                                    )
                                  : const SizedBox(
                                      height: 80,
                                    );
                            }),
                      ),
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [AppColor.red, AppColor.brown2]),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<StadiumBorder>(
                                  const StadiumBorder(),
                                ),
                                elevation: MaterialStateProperty.all(8),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                // elevation: MaterialStateProperty.all(3),
                                shadowColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              onPressed: () {},
                              child: const Text('Add',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColor.white,
                                      fontFamily: "Lato_Semibold"),
                                  textAlign: TextAlign.center)),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }

  showChooseUmpireDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Dialog(
            surfaceTintColor: Colors.white,
            backgroundColor: AppColor.white,
            insetPadding: const EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 16,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              CupertinoIcons.xmark_circle_fill,
                              color: AppColor.brown2,
                              size: 40,
                            )),
                      ),
                      const Text(
                        'Select Umpires',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: "Lato_Semibold",
                            color: AppColor.brown2),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              showUmpireDialog(1);
                            },
                            child: Container(
                              width: 120,
                              height: 140,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  AppColor.grey,
                                  AppColor.grey,
                                ]),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/umpire.png",
                                    height: 60,
                                    width: 60,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Center(
                                    child: Text(
                                      "1st Umpire",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Lato_Sembold",
                                        color: AppColor.text_grey,
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
                              Navigator.pop(context);
                              showUmpireDialog(2);
                            },
                            child: Container(
                              width: 120,
                              height: 140,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  AppColor.grey,
                                  AppColor.grey,
                                ]),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/umpire.png",
                                    height: 60,
                                    width: 60,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Center(
                                    child: Text(
                                      "1st Umpire",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Lato_Sembold",
                                        color: AppColor.text_grey,
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
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }

  createPlayerApi() async {
    var request = {
      'team1_id': widget.teamASelected.getTeamData!.id.toString(),
      'team2_id': widget.teamBSelected.getTeamData!.id.toString(),
      'total_over': noOfOvers.text.trim(),
      'city': cityController.text.trim(),
      'venue_ground': groundController.text.trim(),
      'match_date': dateController.text.trim(),
      'match_time': timeValue,
      'scorer_id': scorerId,
      'status': "1",
      'team_one_json': teamOneJson,
      'team_two_json': teamTwoJson,
      'player_list': playerListJson,
    };
    await createMatch(request).then((res) async {
      if (res.success == 1) {
        debugPrint("MATCH_ID_${res.body!.id}");
        createContestApi(res.body!.id.toString());
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
  createContestApi(var matchId) async {
    var request = {
      'match_id': matchId.toString(),
    };
    await createContest(request).then((res) async {
      if (res.success == 1) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Dialog(
              surfaceTintColor: Colors.white,
              backgroundColor: AppColor.white,
              insetPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 16,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/logo.png",
                          width: 150,
                          height: 150,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Match Created Successfully',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: "Lato_Semibold",
                              color: AppColor.brown2),
                        ),
                        const SizedBox(height: 20),
                        Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [AppColor.red, AppColor.brown2]),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all<StadiumBorder>(
                                    const StadiumBorder(),
                                  ),
                                  elevation: MaterialStateProperty.all(8),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  // elevation: MaterialStateProperty.all(3),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      getContext,
                                      MaterialPageRoute(
                                          builder: (context) => MainScreen(
                                                index: 0,
                                              )));
                                },
                                child: const Text('Continue',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColor.white,
                                        fontFamily: "Lato_Semibold"),
                                    textAlign: TextAlign.center)),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
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

  Future<List<GetPlayerSearchData>> getPlayerSearchApi(String mobileNo) async {
    await getPlayerSearch(mobileNo).then((res) async {
      hideLoader();
      if (res.success == 1) {
        setState(() {
          teamPlayerSearchedList.clear();
          teamPlayerSearchedList.addAll(res.body!);
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
    return teamPlayerSearchedList;
  }

  bool checkValidation() {
    if (noOfOvers.text.trim().toString() == '') {
      CommonFunctions()
          .showToastMessage(getContext, "No. of overs Field Is Required");
      return false;
    } if (noOfOvers.text.trim().toInt()>20) {
      CommonFunctions()
          .showToastMessage(getContext, "Please add overs below 20.");
      return false;
    } else if (cityController.text.trim().toString() == '') {
      CommonFunctions().showToastMessage(getContext, "City Field Is Required.");
      return false;
    } else if (groundController.text.trim().toString() == '') {
      CommonFunctions()
          .showToastMessage(getContext, "Ground Field Is Required.");
      return false;
    } else if (dateController.text.trim().toString() == '') {
      CommonFunctions()
          .showToastMessage(getContext, "Date Field Is Required.");
      return false;
    } else if (timeValue == '') {
      CommonFunctions().showToastMessage(getContext, "Time Field Is Required.");
      return false;
    } else if (scorerId == '') {
      CommonFunctions()
          .showToastMessage(getContext, "Scorer Field Is Required.");
      return false;
    } else {
      return true;
    }
  }

  String getFirstLetters(String input) {
    List<String> words = input.split(" ");
    String result = "";

    for (String word in words) {
      if (word.isNotEmpty) {
        result += word[0];
      }
    }
    return result.toUpperCase(); // Convert to uppercase if needed
  }
}
