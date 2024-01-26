import 'package:crick_team/modalClasses/GetTeamDetailModel.dart';
import 'package:crick_team/modalClasses/TeamSelected.dart';
import 'package:crick_team/startMatchRelatedScreens/SelectPlayingTeams.dart';
import 'package:crick_team/startMatchRelatedScreens/SelectTeam.dart';
import 'package:crick_team/utils/CommonFunctions.dart';
import 'package:crick_team/utils/search_delay_function.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'AddTeams.dart';

class AddPlayerCategory extends StatefulWidget {
  final String team;
  final List<GetTeamDetailData> selectedTeam;
  final TeamSelected teamASelected ;
  final TeamSelected teamBSelected;
  const AddPlayerCategory({super.key, required this.selectedTeam, required this.teamASelected, required this.teamBSelected, required this.team});

  @override
  State<AddPlayerCategory> createState() => _AddPlayerCategoryState();
}

class _AddPlayerCategoryState extends State<AddPlayerCategory> {
  TextEditingController searchController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final searchDelay = SearchDelayFunction();
  var searchStr = "";
  // TeamSelected teamSelected = TeamSelected();
  List<Players> playersList=[];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i = 0 ; i<widget.selectedTeam.length;i++){
      widget.selectedTeam[i].playerCategory=null;
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
            Navigator.pop(context, "player_category_screen");
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
          "Select Player's Category",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Lato_Semibold",
            color: AppColor.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        color: AppColor.lightGreyTrans,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.selectedTeam.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white
                                /*gradient:LinearGradient(
                                        colors: [
                                          AppColor.grey.withOpacity(0.6),
                                          AppColor.grey.withOpacity(0.2),
                                        ],
                                      )*/
                                ,
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
                                            backgroundColor: AppColor.lightGrey,
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
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.selectedTeam[index]
                                                            .userName ==
                                                        null
                                                    ? "Anonymous"
                                                    : widget.selectedTeam[index]
                                                        .userName
                                                        .toString(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "Lato_Semibold",
                                                  color: AppColor.medGrey,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                widget.selectedTeam[index]
                                                        .playerCategory
                                                        .toString()
                                                        .isEmpty
                                                    ? "-"
                                                    : widget.selectedTeam[index]
                                                        .playerCategory=="BOW"?"Bowler":widget.selectedTeam[index]
                                                    .playerCategory=="BAT"?"Batsmen":widget.selectedTeam[index]
                                                    .playerCategory=="WK"?"Wicket Keeper":widget.selectedTeam[index]
                                                    .playerCategory=="ALD"?"All Rounder":"-",
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "Lato_Semibold",
                                                  color: AppColor.medGrey,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              /*for(int i = 0; i<playersList.length;i++){
                                                if(playersList[i].playerId==widget.selectedTeam[index].id){
                                                  playersList.removeAt(i);
                                                  playersList.add(Players(playerId:widget.selectedTeam[index].id,playerType:"BOW"));
                                                }
                                              }*/

                                              widget.selectedTeam[index]
                                                  .playerCategory = "BOW";
                                            });
                                          },
                                          child: Image.asset(
                                            "assets/bowler.png",
                                            height: 30,
                                            width: 30,
                                            color: widget.selectedTeam[index]
                                                        .playerCategory
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "bow"
                                                ? Colors.red
                                                : AppColor.text_grey,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                           /*   for(int i = 0; i<playersList.length;i++){
                                                if(playersList[i].playerId==widget.selectedTeam[index].id){
                                                  playersList.removeAt(i);
                                                  playersList.add(Players(playerId:widget.selectedTeam[index].id,playerType:"BAT"));
                                                }
                                              }*/
                                              widget.selectedTeam[index]
                                                  .playerCategory = "BAT";
                                            });
                                          },
                                          child: Image.asset(
                                            "assets/striker.png",
                                            height: 30,
                                            width: 30,
                                            color: widget.selectedTeam[index]
                                                        .playerCategory
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "bat"
                                                ? Colors.red
                                                : AppColor.text_grey,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              // for(int i = 0; i<playersList.length;i++){
                                              //   if(playersList[i].playerId==widget.selectedTeam[index].id){
                                              //     playersList.removeAt(i);
                                              //     playersList.add(Players(playerId:widget.selectedTeam[index].id,playerType:"WK"));
                                              //   }
                                              // }
                                              widget.selectedTeam[index]
                                                      .playerCategory =
                                                  "WK";
                                            });
                                          },
                                          child: Image.asset(
                                            "assets/keeper.png",
                                            height: 30,
                                            width: 30,
                                            color: widget.selectedTeam[index]
                                                        .playerCategory
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "wk"
                                                ? Colors.red
                                                : AppColor.text_grey,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                             /* for(int i = 0; i<playersList.length;i++){
                                                if(playersList[i].playerId==widget.selectedTeam[index].id){
                                                  playersList.removeAt(i);
                                                  playersList.add(Players(playerId:widget.selectedTeam[index].id,playerType:"ALD"));
                                                }
                                              }*/
                                              widget.selectedTeam[index]
                                                      .playerCategory =
                                                  "ALD";
                                            });
                                          },
                                          child: Image.asset(
                                            "assets/bat_ball.png",
                                            height: 30,
                                            width: 30,
                                            color: widget.selectedTeam[index]
                                                        .playerCategory
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "ald"
                                                ? Colors.red
                                                : AppColor.text_grey,
                                          ),
                                        ),
                                      ],
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
                gradient: const LinearGradient(colors: [
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
                    playersList.clear();
                    var proceed = true;
                    for(int i = 0 ; i<widget.selectedTeam.length;i++){
                      if(widget.selectedTeam[i].playerCategory==null){
                        proceed = false;
                        // CommonFunctions().showToastMessage(context, "Please select player's category.");
                      }else if(proceed){
                        playersList.add(Players(playerId: widget.selectedTeam[i].id,playerType: widget.selectedTeam[i].playerCategory));
                      }
                    }
                    debugPrint("TEAM_SELECTED_1_"+playersList.length.toString());
                    if(playersList.length<11){
                      CommonFunctions().showToastMessage(context, "Please select player's category.");
                    }else{

                      if(widget.team=="A"){
                        widget.teamASelected.players=playersList;
                        debugPrint("TEAM_SELECTED__A${widget.teamASelected.players!.length}");
                      }else{
                        widget.teamBSelected.players=playersList;
                        debugPrint("TEAM_SELECTED__B${widget.teamBSelected.players!.length}");
                      }


                      Navigator.pushReplacement(
                        getContext,
                        MaterialPageRoute(builder: (context) => SelectPlayingTeams(teamASelected: widget.teamASelected,teamBSelected: widget.teamBSelected,),
                        // MaterialPageRoute(builder: (context) =>  NavigationScreen(index: 0,)),
                      ));

                    }


                  },
                  child: const Text(
                    'Continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.white,
                        fontFamily: "Lato_Semibold",
                        fontSize: 16),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
