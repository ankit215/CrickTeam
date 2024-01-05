import 'package:flutter/material.dart';

import '../loginSignupRelatedFiles/OtpScreen.dart';
import '../main.dart';
import '../profileRelatedScrees/EditProfileScreen.dart';
import '../utils/AppColor.dart';
import 'AddTeams.dart';

class SelectTeam extends StatefulWidget {
  final String team;
  const SelectTeam({super.key, required this.team});

  @override
  State<SelectTeam> createState() => _SelectTeamState();
}

class _SelectTeamState extends State<SelectTeam> with TickerProviderStateMixin {
  late TabController tabController;
  TextEditingController teamController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
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
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          elevation: 5.0,
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
          title:  Text(
            "Select Team ${widget.team}",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Lato_Semibold",
              color: AppColor.white,
            ),
            textAlign: TextAlign.center,
          ),
          bottom: TabBar(
            controller: tabController,
            labelColor: AppColor.white,
            unselectedLabelColor: AppColor.grey,
            indicatorColor: AppColor.orange_light,
            tabs: <Widget>[
              Tab(
                child: SizedBox(
                  width: 100,
                  child: Text(
                    "MY TEAMS",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: tabController.index == 0
                          ? "Lato_Semibold"
                          : "Lato_Regular",
                    ),
                  ),
                ),
              ),
              Tab(
                child: SizedBox(
                  width: 100,
                  child: Center(
                    child: Text(
                      "ADD",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: tabController.index == 2
                            ? "Lato_Semibold"
                            : "Lato_Regular",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          currentScreen(),
          completedScreen(),
        ],
      ),
    );
  }

  currentScreen() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text("ssss"),
    );
  }

  completedScreen() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColor.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: AppColor.grey,
                        child: ClipOval(
                            child: Image.asset(
                          "assets/team_placeholder.png",
                          fit: BoxFit.contain,
                          height: 90,
                          width: 90,
                        )),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 80,
                      left: 85,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColor.brown2,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                getContext,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfileScreen()));
                          },
                          child: Center(
                              child: Image.asset(
                            "assets/editing.png",
                            width: 15,
                            height: 15,
                            fit: BoxFit.contain,
                            color: AppColor.white,
                          )),
                        ),
                      ))
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Team Name *",
                style: TextStyle(
                    fontSize: 16.0,
                    color: AppColor.brown2,
                    fontFamily: "Lato_Semibold"),
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
                    controller: teamController,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Enter team name',
                        hintStyle: TextStyle(color: AppColor.grey)),
                  ),
                ),
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
                height: 55,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: AppColor.white,
                    border: Border.all(color: AppColor.border)),
                child: Center(
                  child: TextField(
                    controller: cityNameController,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Enter city name',
                        hintStyle: TextStyle(color: AppColor.grey)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 60),
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
                      shadowColor:
                      MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      Navigator.push(
                          getContext,
                          MaterialPageRoute(
                              builder: (context) => const AddTeams()));
                    },
                    child: const Text(
                      'Add Team',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.white,
                          fontFamily: "Lato_Semibold",
                          fontSize: 16),
                    )),
              )
            ],
          ),
        ));
  }
}
