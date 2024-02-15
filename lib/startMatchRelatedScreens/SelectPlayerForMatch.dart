import 'package:crick_team/modalClasses/GetPlayerSearchModel.dart';
import 'package:crick_team/modalClasses/GetTeamDetailModel.dart';
import 'package:crick_team/utils/search_delay_function.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apiRelatedFiles/rest_apis.dart';
import '../loginSignupRelatedFiles/LoginScreen.dart';
import '../main.dart';
import '../utils/CommonFunctions.dart';
import '../utils/common.dart';

class SelectPlayerForMatch extends StatefulWidget {
  final String teamId;
  const SelectPlayerForMatch({super.key, required this.teamId});

  @override
  State<SelectPlayerForMatch> createState() => _SelectPlayerForMatchState();
}

class _SelectPlayerForMatchState extends State<SelectPlayerForMatch> {
  TextEditingController searchController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final searchDelay = SearchDelayFunction();
  var searchStr = "";
  List<GetPlayerSearchData> teamPlayerSearchedList = [];
  List<GetTeamDetailData> teamPlayerList = [];

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
                      Navigator.pop(context,teamPlayerList[index].id);
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

        ],
      ),
    );
  }

  Future getTeamDetailApi() async {
    await getTeamDetail(widget.teamId.toString()).then((res) async {
      hideLoader();
      if (res.success == 1) {
        setState(() {
          teamPlayerList.clear();
          teamPlayerList.addAll(res.body!);
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