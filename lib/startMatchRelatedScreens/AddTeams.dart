import 'package:crick_team/modalClasses/GetPlayerSearchModel.dart';
import 'package:crick_team/modalClasses/GetTeamDetailModel.dart';
import 'package:crick_team/startMatchRelatedScreens/AddPlayerCategory.dart';
import 'package:crick_team/startMatchRelatedScreens/SelectTeam.dart';
import 'package:crick_team/utils/search_delay_function.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apiRelatedFiles/api_utils.dart';
import '../apiRelatedFiles/rest_apis.dart';
import '../loginSignupRelatedFiles/LoginScreen.dart';
import '../main.dart';
import '../modalClasses/GetTeamModel.dart';
import '../modalClasses/TeamSelected.dart';
import '../utils/CommonFunctions.dart';
import '../utils/common.dart';

class AddTeams extends StatefulWidget {
  final String team;
  final GetTeamData getTeamData;
  final TeamSelected teamASelected ;
  final TeamSelected teamBSelected;
  const AddTeams({super.key, required this.getTeamData, required this.teamASelected, required this.teamBSelected, required this.team});

  @override
  State<AddTeams> createState() => _AddTeamsState();
}

class _AddTeamsState extends State<AddTeams> {
  TextEditingController searchController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final searchDelay = SearchDelayFunction();
  var searchStr = "";
  List<GetPlayerSearchData> teamPlayerSearchedList = [];
  List<GetTeamDetailData> teamPlayerList = [];
  List<GetTeamDetailData> playerSelected = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getTeamDetailApi();
    });
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
            Navigator.pop(context,"add_teams");
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
          "Select Playing Players",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Lato_Semibold",
            color: AppColor.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            margin: const EdgeInsets.all(10),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColor.white,
                border: Border.all(color: AppColor.brown2)),
            child: Center(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      onChanged: (value) {
                        searchStr = value;
                        searchDelay.run(() {
                         if(searchStr.isEmpty){
                           setState(() {
                             searchController.text = "";
                             searchStr = "";
                             teamPlayerSearchedList.clear();
                           });
                         }else{
                           getPlayerSearchApi(searchStr);
                         }

                        });
                      },
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Quick Search',
                          hintStyle: TextStyle(color: AppColor.medBrown)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  (searchStr == "")
                      ? Image.asset(
                          "assets/search.png",
                          color: Colors.red,
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              searchController.text = "";
                              searchStr = "";
                              teamPlayerSearchedList.clear();
                            });

                          },
                          child: Image.asset(
                            "assets/cross.png",
                            height: 15,
                            width: 15,
                            color: AppColor.orange_0,
                          )),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              phoneController.text = "";
              showDialog(
                context: context,
                useRootNavigator: false,//Dialog must not use root navigator
                builder: (context) {
                  return StatefulBuilder(
                      builder: (context, StateSetter setState) {
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
                                  'Add Player',
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
                                  "assets/player.png",
                                  width: 80,
                                  height: 80,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Player mobile no.*",
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
                                      border:
                                          Border.all(color: AppColor.border)),
                                  child: Center(
                                    child: TextField(
                                      controller: phoneController,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      decoration:
                                          const InputDecoration.collapsed(
                                              hintText: 'Enter mobile number',
                                              hintStyle: TextStyle(
                                                  color: AppColor.grey)),
                                    ),
                                  ),
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
                                      gradient: const LinearGradient(colors: [
                                        AppColor.red,
                                        AppColor.brown2
                                      ]),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              StadiumBorder>(
                                            const StadiumBorder(),
                                          ),
                                          elevation:
                                              MaterialStateProperty.all(8),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          // elevation: MaterialStateProperty.all(3),
                                          shadowColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                        ),
                                        onPressed: () {
                                          if(phoneController.text.trim().isEmpty){
                                            CommonFunctions().showToastMessage(context,"Please enter player mobile no.");
                                          }else{
                                            Navigator.pop(context);
                                            createPlayerApi(phoneController.text.trim());
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
            },
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
                        "+ ADD PLAYER",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Lato_Bold",
                          color: AppColor.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ))),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: teamPlayerSearchedList.isEmpty&&searchStr.isEmpty?
            ListView.builder(
                itemCount: teamPlayerList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (playerSelected.length < 11) {
                        setState(() {
                          teamPlayerList[index].playerSelected =
                          teamPlayerList[index].playerSelected!
                              ? false
                              : true;

                          if (teamPlayerList[index].playerSelected!) {
                            playerSelected.add(teamPlayerList[index]);
                          } else {
                            playerSelected.remove(teamPlayerList[index]);
                          }
                        });
                      } else {
                        CommonFunctions().showToastMessage(
                            getContext, "Already 11 players selected.");
                      }
                    },
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
                              gradient: teamPlayerList[index].playerSelected!
                                  ? const LinearGradient(
                                colors: [AppColor.red, AppColor.brown2],
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
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              teamPlayerList[index].userName ==
                                                  null
                                                  ? "Player"
                                                  : teamPlayerList[index]
                                                  .userName
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "Lato_Semibold",
                                                color: teamPlayerList[index]
                                                    .playerSelected
                                                    ? Colors.white
                                                    : AppColor.medGrey,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.call,
                                                  color: teamPlayerList[index]
                                                      .playerSelected!
                                                      ? Colors.white
                                                      : AppColor.medGrey,
                                                  size: 20,
                                                ),
                                                SizedBox(width: 5,),
                                                Text(
                                                  teamPlayerList[index]
                                                      .mobileNumber
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: "Lato_Semibold",
                                                    color: teamPlayerList[index]
                                                        .playerSelected!
                                                        ? Colors.white
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
                                  teamPlayerList[index].playerSelected!
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
                }):ListView.builder(
                itemCount: teamPlayerSearchedList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      var playerAlreadyAdded = false;
                      for(int i = 0;i<teamPlayerList.length;i++){
                        if(teamPlayerList[i].mobileNumber==teamPlayerSearchedList[index].mobileNumber.toString()){
                          playerAlreadyAdded = true;
                        }
                      }
                      if(playerAlreadyAdded){
                        CommonFunctions().showToastMessage(context, "Player already Added");
                      }else{
                        createPlayerApi(teamPlayerSearchedList[index].mobileNumber.toString());
                      }

                    },
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
                              gradient: LinearGradient(
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
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              teamPlayerSearchedList[index].name ==
                                                      null
                                                  ? "Player"
                                                  : teamPlayerSearchedList[index]
                                                      .name
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "Lato_Semibold",
                                                color: AppColor.medGrey,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.call,
                                                  color: AppColor.medGrey,
                                                  size: 20,
                                                ),
                                                SizedBox(width: 5,),
                                                Text(
                                                  teamPlayerSearchedList[index]
                                                      .mobileNumber
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: "Lato_Semibold",
                                                    color: AppColor.medGrey,
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
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ))),
                  );
                }),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20, top: 30),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 60,
            decoration: BoxDecoration(
              gradient: playerSelected.length < 11
                  ? const LinearGradient(colors: [
                      AppColor.grey,
                      AppColor.grey,
                    ])
                  : const LinearGradient(colors: [
                      AppColor.red,
                      AppColor.brown2,
                    ]),
              borderRadius: BorderRadius.circular(30),
            ),
            child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<StadiumBorder>(
                    const StadiumBorder(),
                  ),
                  elevation: MaterialStateProperty.all(1),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  // elevation: MaterialStateProperty.all(3),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {
                  if (playerSelected.length < 11) {
                    CommonFunctions()
                        .showToastMessage(context, "Select 11 players");
                  } else {
                    for (int i = 0; i < playerSelected.length; i++) {
                      playerSelected[i].playerCategory = "";
                    }
                    Navigator.push(
                        getContext,
                        MaterialPageRoute(
                            builder: (context) => AddPlayerCategory(
                                  selectedTeam: playerSelected,teamASelected: widget.teamASelected,teamBSelected: widget.teamBSelected,team: widget.team,
                                ))).then((value) => () {
                          if (value == "player_category_screen") {
                            debugPrint("adfdsfsdf");
                            for (int i = 0; i < playerSelected.length; i++) {
                              playerSelected[i].playerCategory = "";
                            }
                          }
                        });
                  }
                },
                child: Text(
                  playerSelected.length < 11
                      ? "Selected Player ${playerSelected.length}/11"
                      : 'Proceed to select player category',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: playerSelected.length < 11
                          ? AppColor.text_grey
                          : AppColor.white,
                      fontFamily: "Lato_Semibold",
                      fontSize: 16),
                )),
          )
        ],
      ),
    );
  }

  Future getTeamDetailApi() async {
    await getTeamDetail(widget.getTeamData.id.toString()).then((res) async {
      hideLoader();
      if (res.success == 1) {
        setState(() {
          teamPlayerList.clear();
          teamPlayerList.addAll(res.body!);
          if(playerSelected.isNotEmpty){
            for(int i =0;i<teamPlayerList.length;i++){
            for(int j =0;j<playerSelected.length;j++){
              if(teamPlayerList[i].id==playerSelected[j].id){
                teamPlayerList[i].playerSelected = true;
              }
            }

            }
          }
          debugPrint("wfewfewf" + teamPlayerList.length.toString());
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
  createPlayerApi(String mobileNo) async {
    var request = {
      'mobile_number': mobileNo,
      'team_id': widget.getTeamData.id,
    };
    await createPlayer(request).then((res) async {
      if (res.success == 1) {
        toast(res.message);

        setState(() {
          searchController.text = "";
          searchStr = "";
          teamPlayerSearchedList.clear();

        });
        Future.delayed(Duration.zero, () {
          getTeamDetailApi();
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
  Future getPlayerSearchApi(String mobileNo) async {
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
  }

}
