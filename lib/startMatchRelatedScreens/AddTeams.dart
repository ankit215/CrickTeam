import 'package:crick_team/startMatchRelatedScreens/AddPlayerCategory.dart';
import 'package:crick_team/startMatchRelatedScreens/SelectTeam.dart';
import 'package:crick_team/utils/search_delay_function.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/CommonFunctions.dart';

class Team {
  String? playerName;
  bool? playerSelected;
  String?playerCategory;

  Team(this.playerName, this.playerSelected, this.playerCategory);
}

class AddTeams extends StatefulWidget {
  const AddTeams({super.key});

  @override
  State<AddTeams> createState() => _AddTeamsState();
}

class _AddTeamsState extends State<AddTeams> {
  TextEditingController searchController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final searchDelay = SearchDelayFunction();
  var searchStr = "";
  List<Team> playerList = [
    Team("Ankit", false,""),
    Team("Rajat", false,""),
    Team("Mohit", false,""),
    Team("Mohit", false,""),
    Team("Mohit", false,""),
    Team("Mohit", false,""),
    Team("Mohit", false,""),
    Team("Mohit", false,""),
    Team("Mohit", false,""),
    Team("Mohit", false,""),
    Team("Mohit", false,""),
    Team("Mohit", false,""),
    Team("Akshay", false,"")
  ];
  List<Team> playerSelected = [];
  List<Team> playerList2 = [
    Team("Ankit", false,""),
    Team("Rajat", false,""),
    Team("Mohit", false,""),
    Team("Akshay", false,"")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
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
          "Select Playing Teams",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Lato_Semibold",
            color: AppColor.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
/*      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          backgroundColor: AppColor.brown2,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (context,StateSetter setState)

                {
                  return Dialog (
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
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(CupertinoIcons.xmark_circle_fill,color: AppColor.brown2,size: 40,)),
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
                                  "Player phone no.*",
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
                                    decoration: const InputDecoration.collapsed(
                                        hintText: 'Enter phone number',
                                        hintStyle: TextStyle(color: AppColor.grey)),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                    itemCount: 1,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int index) {
                                      return index!=playerList2.length?GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            playerList2[index].playerSelected =
                                            playerList2[index].playerSelected! ? false : true;
                                          });
                                        },
                                        child: Card(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            elevation: 0.2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: Container(
                                                width: MediaQuery.sizeOf(context).width * 0.9,
                                                decoration: BoxDecoration(
                                                  gradient: playerList2[index].playerSelected!
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
                                                            Text(
                                                              playerList2[index]
                                                                  .playerName
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontFamily: "Lato_Semibold",
                                                                color: playerList2[index]
                                                                    .playerSelected!
                                                                    ? Colors.white
                                                                    : AppColor.medGrey,
                                                              ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      playerList2[index].playerSelected!
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
                                      ):SizedBox(height: 80,);
                                    }),
                              ),
                              Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(30.0),
                                ),
                                child: Container(
                                  height: 50,

                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        colors: [
                                          AppColor.red,
                                          AppColor.brown2
                                        ]),
                                    borderRadius:
                                    BorderRadius.circular(30),
                                  ),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty
                                            .all<StadiumBorder>(
                                          const StadiumBorder(),
                                        ),
                                        elevation:
                                        MaterialStateProperty.all(
                                            8),
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            Colors.transparent),
                                        // elevation: MaterialStateProperty.all(3),
                                        shadowColor:
                                        MaterialStateProperty.all(
                                            Colors.transparent),
                                      ),
                                      onPressed: () {


                                      },
                                      child: const Text('Add',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: AppColor.white,
                                              fontFamily:
                                              "Lato_Semibold"),
                                          textAlign:
                                          TextAlign.center)),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }


                );

              },
            );

          },
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 5, color: AppColor.orange),
              borderRadius: BorderRadius.circular(100)),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
      )*/
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                      onChanged: (value) {
                        searchStr = value;
                        searchDelay.run(() {
                          // getPromotionsApi("", searchStr);
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
                            searchController.text = "";
                            searchStr = "";
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
              showDialog(
                context: context,
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
                                    "Player phone no.*",
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
                                      decoration:
                                          const InputDecoration.collapsed(
                                              hintText: 'Enter phone number',
                                              hintStyle: TextStyle(
                                                  color: AppColor.grey)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                      itemCount: 1,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return index != playerList2.length
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    playerList2[index]
                                                            .playerSelected =
                                                        playerList2[index]
                                                                .playerSelected!
                                                            ? false
                                                            : true;
                                                  });
                                                },
                                                child: Card(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15,
                                                        vertical: 5),
                                                    elevation: 0.2,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.9,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient: playerList2[
                                                                      index]
                                                                  .playerSelected!
                                                              ? const LinearGradient(
                                                                  colors: [
                                                                    AppColor
                                                                        .red,
                                                                    AppColor
                                                                        .brown2
                                                                  ],
                                                                )
                                                              : LinearGradient(
                                                                  colors: [
                                                                    AppColor
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.2),
                                                                    AppColor
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.2),
                                                                  ],
                                                                ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    CircleAvatar(
                                                                      radius:
                                                                          30,
                                                                      child: ClipOval(
                                                                          child: Image.asset(
                                                                        "assets/player.png",
                                                                        fit: BoxFit
                                                                            .contain,
                                                                        height:
                                                                            45,
                                                                        width:
                                                                            45,
                                                                      )),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      playerList2[
                                                                              index]
                                                                          .playerName
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontFamily:
                                                                            "Lato_Semibold",
                                                                        color: playerList2[index].playerSelected!
                                                                            ? Colors.white
                                                                            : AppColor.medGrey,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              playerList2[index]
                                                                      .playerSelected!
                                                                  ? const Icon(
                                                                      Icons
                                                                          .check_circle,
                                                                      color: Colors
                                                                          .white,
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
                                            : SizedBox(
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
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
                itemCount: playerList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if(playerSelected.length<11){
                      setState(() {
                        playerList[index].playerSelected =
                            playerList[index].playerSelected! ? false : true;

                        if (playerList[index].playerSelected!) {
                          playerSelected.add(playerList[index]);
                        }else{
                          playerSelected.remove(playerList[index]);
                        }
                      });}else{
                        CommonFunctions()
                            .showToastMessage(getContext, "Already 11 players selected.");
                      }
                    },
                    child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        elevation: 0.2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            decoration: BoxDecoration(
                              gradient: playerList[index].playerSelected!
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
                                        Text(
                                          playerList[index]
                                              .playerName
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Lato_Semibold",
                                            color: playerList[index]
                                                    .playerSelected!
                                                ? Colors.white
                                                : AppColor.medGrey,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  playerList[index].playerSelected!
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
          Container(
            margin: const EdgeInsets.only(bottom: 20, top: 30),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 60,
            decoration: BoxDecoration(
              gradient: playerSelected.length<11?const LinearGradient(colors: [
                AppColor.grey,
                AppColor.grey,
              ]):const LinearGradient(colors: [
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
                  elevation: MaterialStateProperty.all(8),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  // elevation: MaterialStateProperty.all(3),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {
                  if(playerSelected.length<11){
                    CommonFunctions().showToastMessage(context, "Select 11 players");
                  }else{
                    for(int i =0;i<playerSelected.length;i++){
                      playerSelected[i].playerCategory = "";
                    }
                    Navigator.push(getContext, MaterialPageRoute(builder: (context) =>  AddPlayerCategory(selectedTeam: playerSelected,))).then((value) => (){
                      if(value=="player_category_screen"){
                        debugPrint("adfdsfsdf");
                        for(int i =0;i<playerSelected.length;i++){
                          playerSelected[i].playerCategory = "";
                        }
                      }
                    });
                  }


                },
                child:  Text(
                  playerSelected.length<11?"Selected Player ${playerSelected.length}/11":'Proceed to select player category',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:playerSelected.length<11?AppColor.text_grey: AppColor.white,
                      fontFamily: "Lato_Semibold",
                      fontSize: 16),
                )),
          )
        ],
      ),
    );
  }
}
