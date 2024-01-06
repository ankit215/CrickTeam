import 'package:crick_team/main.dart';
import 'package:crick_team/mainScreens/ScoreScreen.dart';
import 'package:crick_team/scoreRelatedScreens/ScorerScreen.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:flutter/material.dart';
class MatchModel {
  String? teamAName;
  String? teamAShortName;
  String? teamAFlag;
  String? teamBName;
  String? teamBShortName;
  String? teamBFlag;
  String? matchTimeRemaining;
  String? matchDateTime;

  MatchModel(
      this.teamAName,
      this.teamAShortName,
      this.teamBName,
      this.teamBShortName,
      this.matchTimeRemaining,
      this.matchDateTime,
      this.teamAFlag,
      this.teamBFlag);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MatchModel> matchList = [
    MatchModel("India", "Ind", "Australia", "Aus", "37m 56s",
        "07:00 PM (03 Dec)", "assets/india.png", "assets/aus.png"),
    MatchModel("South Africa", "SA", "Sri Lanka", "SL", "37m 56s",
        "10:00 AM (05 Dec)", "assets/sl.png", "assets/sa.png"),
    MatchModel("Sri Lanka", "SL", "West Indies", "WI", "37m 56s",
        "07:00 PM (03 Dec)", "assets/sl.png", "assets/india.png"),
    MatchModel("India", "Ind", "Australia", "Aus", "37m 56s",
        "07:00 PM (03 Dec)", "assets/india.png", "assets/aus.png"),
    MatchModel("India", "Ind", "Australia", "Aus", "37m 56s",
        "07:00 PM (03 Dec)", "assets/india.png", "assets/aus.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.transparent,
      appBar: AppBar(
        backgroundColor: AppColor.transparent,
        leading: GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Container(
            margin: const EdgeInsets.only(left: 5, top: 5),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  child: ClipOval(
                      child: Image.asset(
                    "assets/manager.png",
                    fit: BoxFit.contain,
                    height: 70,
                    width: 70,
                  )),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColor.white,
                      child: ClipOval(
                          child: Image.asset(
                        "assets/menu.png",
                        fit: BoxFit.contain,
                        height: 20,
                        width: 20,
                      )),
                    )),
              ],
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image.asset(
            'assets/appname_logo.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        actions: <Widget>[
          Image.asset(
            "assets/wallet.png",
            height: 25,
            width: 25,
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            child: const Center(
              child: Text(
                "45",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Lato_Semibold",
                  color: AppColor.brown2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 0.8,
                color: AppColor.grey,
                margin: const EdgeInsets.only(top: 4),
              ),
              Container(
                height: MediaQuery.sizeOf(context).height*0.27,
                width: MediaQuery.sizeOf(context).width*1,
                margin: const EdgeInsets.only(left: 5,bottom: 10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: matchList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(getContext, MaterialPageRoute(builder: (context) => const ScorerScreen(team: "A")));

                      },
                      child: Card(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              // AppColor.yellow.withOpacity(0.5),
                              AppColor.yellowV2.withOpacity(0.5),
                              AppColor.yellowV2.withOpacity(0.5),
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
                                  height: 150,
                                  width: 150,
                                  opacity: const AlwaysStoppedAnimation(.09),
                                ),
                              ),
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                      child: Text(
                                    "${matchList[index].teamAName} vs ${matchList[index].teamBName} T20",
                                    style: const TextStyle(
                                        fontFamily: "Lato_Semibold",
                                        color: AppColor.brown2,
                                        fontSize: 16),
                                  )),
                                  Container(
                                    height: 1,
                                    color: AppColor.yellowV2,
                                    margin: const EdgeInsets.only(top: 4),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 50,
                                    width:
                                    MediaQuery.sizeOf(context).width *
                                        0.7,
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 49,
                                            width:
                                                MediaQuery.sizeOf(context).width *
                                                    0.5,
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                AppColor.yellow,
                                                AppColor.yellowV2,
                                                AppColor.yellowMed,
                                              ]),
                                            ),
                                            child: Image.asset("assets/vs.png",color:AppColor.brown2,width: 40,height: 40,fit: BoxFit.contain,),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              0.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CircleAvatar(
                                                radius: 30,
                                                child: ClipOval(
                                                    child: Image.asset(
                                                  matchList[index].teamAFlag!,
                                                  fit: BoxFit.contain,
                                                  height: 45,
                                                  width: 45,
                                                )),
                                              ),
                                              CircleAvatar(
                                                radius: 30,
                                                child: ClipOval(
                                                    child: Image.asset(
                                                  matchList[index].teamBFlag!,
                                                  fit: BoxFit.contain,
                                                  height: 45,
                                                  width: 45,
                                                )),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.timer,
                                            color:Colors.red,
                                            size: 20,
                                          ),

                                          Text(
                                            matchList[index].matchTimeRemaining!,
                                            style: const TextStyle(
                                                fontFamily: "Lato_Semibold",
                                                color: Colors.red,
                                                fontSize: 16),
                                          ),
                                        ],
                                      )),
                                  const SizedBox(height: 5,),
                                  Text(
                                    matchList[index].matchDateTime!,
                                    style: const TextStyle(
                                        fontFamily: "Lato_Semibold",
                                        color: AppColor.brown2,
                                        fontSize: 16),
                                  ),
                                 /* Container(
                                    height: 1,
                                    color: AppColor.yellowV2,
                                    margin: const EdgeInsets.only(top: 10),
                                  ),*/
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Center(
                child: RichText(
                  text: const TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Upcoming ",
                        style: TextStyle(
                            fontSize: 25.0,
                            color: AppColor.brown2,
                            fontFamily: "Lato_Semibold")),
                    TextSpan(
                        text: "Matches",
                        style: TextStyle(
                            fontSize: 25.0,
                            color: AppColor.orange_light,
                            fontFamily: "Lato_Semibold"))
                  ]),
                  textAlign: TextAlign.center,
                ),
              ),
              ListView.builder(
                itemCount: matchList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          // AppColor.yellow.withOpacity(0.5),
                          AppColor.yellowV2.withOpacity(0.2),
                          AppColor.yellowV2.withOpacity(0.2),
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
                              height: 150,
                              width: 150,
                              opacity: const AlwaysStoppedAnimation(.09),
                            ),
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                  child: Text(
                                    "${matchList[index].teamAName} vs ${matchList[index].teamBName} T20",
                                    style: const TextStyle(
                                        fontFamily: "Lato_Semibold",
                                        color: AppColor.brown2,
                                        fontSize: 16),
                                  )),
                              Container(
                                height: 1,
                                color: AppColor.yellowV2,
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
                                  Stack(children: [
                                    Center(
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 47,
                                        width:
                                        MediaQuery.sizeOf(context).width *
                                            0.19,
                                        decoration:  BoxDecoration(
                                          color:  AppColor.yellowMed.withOpacity(0.4),
                                        ),
                                      ),
                                    ),
                                    Row(

                                      children: [
                                        SizedBox(width: MediaQuery.sizeOf(context).width *
                                            0.1,),
                                        CircleAvatar(
                                          radius: 30,
                                          child: ClipOval(
                                              child: Image.asset(
                                                matchList[index].teamAFlag!,
                                                fit: BoxFit.contain,
                                                height: 45,
                                                width: 45,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],),
                                  Column(children: [const Icon(
                                    Icons.timer,
                                    color:Colors.red,
                                    size: 20,
                                  ),

                                    Text(
                                      matchList[index].matchTimeRemaining!,
                                      style: const TextStyle(
                                          fontFamily: "Lato_Semibold",
                                          color: Colors.red,
                                          fontSize: 16),
                                    ),],),
                                  Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 45,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.2,
                                      decoration:  BoxDecoration(
                                        color:  AppColor.yellowMed.withOpacity(0.4),
                                      ),
                                    ),


                                    Row(
                                      children: [

                                        CircleAvatar(
                                          radius: 30,
                                          child: ClipOval(
                                              child: Image.asset(
                                                matchList[index].teamBFlag!,
                                                fit: BoxFit.contain,
                                                height: 45,
                                                width: 45,
                                              )),
                                        ),
                                        SizedBox(width: MediaQuery.sizeOf(context).width *
                                            0.1,),
                                      ],
                                    ),
                                  ],)
                                ],),
                              ),


                              const SizedBox(height: 5,),
                              Text(
                                matchList[index].matchDateTime!,
                                style: const TextStyle(
                                    fontFamily: "Lato_Semibold",
                                    color: AppColor.brown2,
                                    fontSize: 16),
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
