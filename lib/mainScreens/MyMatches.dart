import 'package:flutter/material.dart';

import '../utils/AppColor.dart';
import 'HomeScreen.dart';

class MyMatches extends StatefulWidget {
  const MyMatches({super.key});

  @override
  State<MyMatches> createState() => _MyMatchesState();
}

class _MyMatchesState extends State<MyMatches> with TickerProviderStateMixin {
  late TabController tabController;
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
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0.0,
          leading: GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.only(left: 5, top: 5),
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
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
          title: const Center(
            child: Text(
              "My Matches",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Lato_Semibold",
                color: AppColor.brown2,
              ),
              textAlign: TextAlign.center,
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
          bottom: TabBar(
            controller: tabController,
            labelColor: AppColor.orange_light,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColor.orange_light,
            tabs:  <Widget>[
              Tab(
                child: Text(
                  "Current",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily:tabController.index==0 ?"Lato_Semibold":"Lato_Regular",
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Upcoming",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily:tabController.index==1 ?"Lato_Semibold":"Lato_Regular",
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Completed",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily:tabController.index==2 ?"Lato_Semibold":"Lato_Regular",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: TabBarView(
          controller: tabController,
          children: <Widget>[
            currentScreen(),
            upcomingScreen(),
            completedScreen(),
          ],
        ),
      ),
    );
  }

  currentScreen() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: matchList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.9,

              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  // AppColor.yellow.withOpacity(0.5),
                  AppColor.red.withOpacity(0.3),
                  AppColor.brown2.withOpacity(0.2),
                  // AppColor.yellowMed.withOpacity(0.5),
                ]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).width * 0.35,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/bats.png",
                        fit: BoxFit.cover,
                        height: 90,
                        width: 90,
                        opacity: const AlwaysStoppedAnimation(.09),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [

                          Center(
                            child: Text(
                              "${matchList[index].teamAName} vs ${matchList[index].teamBName} T20",
                              style: const TextStyle(
                                  fontFamily: "Lato_Semibold",
                                  color: AppColor.brown2,
                                  fontSize: 16),
                            ),
                          ),

                          Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset("assets/live.gif",height: 20,width: 60,)),
                        ],
                      ),
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
                            Stack(
                              children: [
                                Center(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 47,
                                    width:
                                    MediaQuery.sizeOf(context).width * 0.29,
                                    padding: EdgeInsets.only(right: 22),
                                    decoration: BoxDecoration(
                                      color: AppColor.yellowMed.withOpacity(0.4),
                                    ),
                                    child: const Text("140/6 (20)",style: TextStyle(fontFamily: "Lato_Semibold",color: AppColor.brown2),),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width:
                                      MediaQuery.sizeOf(context).width * 0.2,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
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
                              ],
                            ),

                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 45,
                                  padding: EdgeInsets.only(left: 20),
                                  width: MediaQuery.sizeOf(context).width * 0.29,
                                  decoration: BoxDecoration(
                                    color: AppColor.yellowMed.withOpacity(0.4),
                                  ),
                                  child: Text("Yet To Bat",style: TextStyle(fontFamily: "Lato_Semibold"),),
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      child: ClipOval(
                                          child: Image.asset(
                                            matchList[index].teamBFlag!,
                                            fit: BoxFit.contain,
                                            height: 45,
                                            width: 45,
                                          )),
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.sizeOf(context).width * 0.2,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 110,
                        decoration:  BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          color: AppColor.yellowMed.withOpacity(0.4),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.timer,
                              color: Colors.red,
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
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  upcomingScreen() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: matchList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.9,
              height: MediaQuery.sizeOf(context).width * 0.35,

              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  // AppColor.yellow.withOpacity(0.5),
                  AppColor.yellowV2.withOpacity(0.3),
                  AppColor.brown2.withOpacity(0.2),
                  // AppColor.yellowMed.withOpacity(0.5),
                ]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).width * 0.35,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/bats.png",
                        fit: BoxFit.cover,
                        height: 90,
                        width: 90,
                        opacity: const AlwaysStoppedAnimation(.09),
                      ),
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
                            Stack(
                              children: [
                                Center(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 47,
                                    width:
                                    MediaQuery.sizeOf(context).width * 0.19,
                                    decoration: BoxDecoration(
                                      color: AppColor.yellowMed.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width:
                                      MediaQuery.sizeOf(context).width * 0.1,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
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
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  Icons.timer,
                                  color: Colors.red,
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
                            ),
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 45,
                                  width: MediaQuery.sizeOf(context).width * 0.2,
                                  decoration: BoxDecoration(
                                    color: AppColor.yellowMed.withOpacity(0.4),
                                  ),
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      child: ClipOval(
                                          child: Image.asset(
                                            matchList[index].teamBFlag!,
                                            fit: BoxFit.contain,
                                            height: 45,
                                            width: 45,
                                          )),
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.sizeOf(context).width * 0.1,
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
                      Text(
                        matchList[index].matchDateTime!,
                        style: const TextStyle(
                            fontFamily: "Lato_Semibold",
                            color: AppColor.brown2,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  completedScreen() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: matchList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.9,
              height: MediaQuery.sizeOf(context).width * 0.35,

              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  // AppColor.yellow.withOpacity(0.5),
                  AppColor.green_neon.withOpacity(0.1),
                  AppColor.green_neon.withOpacity(0.1),
                  // AppColor.yellowMed.withOpacity(0.5),
                ]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).width * 0.35,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/bats.png",
                        fit: BoxFit.cover,
                        height: 90,
                        width: 90,
                        opacity: const AlwaysStoppedAnimation(.09),
                      ),
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
                            Stack(
                              children: [
                                Center(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 47,
                                    width:
                                    MediaQuery.sizeOf(context).width * 0.19,
                                    decoration: BoxDecoration(
                                      color: AppColor.yellowMed.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width:
                                      MediaQuery.sizeOf(context).width * 0.1,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
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
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  Icons.timer,
                                  color: Colors.red,
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
                            ),
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 45,
                                  width: MediaQuery.sizeOf(context).width * 0.2,
                                  decoration: BoxDecoration(
                                    color: AppColor.yellowMed.withOpacity(0.4),
                                  ),
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      child: ClipOval(
                                          child: Image.asset(
                                            matchList[index].teamBFlag!,
                                            fit: BoxFit.contain,
                                            height: 45,
                                            width: 45,
                                          )),
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.sizeOf(context).width * 0.1,
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
                      Text(
                        matchList[index].matchDateTime!,
                        style: const TextStyle(
                            fontFamily: "Lato_Semibold",
                            color: AppColor.brown2,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
