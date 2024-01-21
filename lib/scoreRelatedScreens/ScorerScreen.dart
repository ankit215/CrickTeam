import 'package:crick_team/scoreRelatedScreens/OutScreen.dart';
import 'package:crick_team/startMatchRelatedScreens/TossScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import '../profileRelatedScrees/EditProfileScreen.dart';
import '../startMatchRelatedScreens/AddTeams.dart';
import '../utils/AppColor.dart';

class ScorerScreen extends StatefulWidget {
  final String team;

  const ScorerScreen({super.key, required this.team});

  @override
  State<ScorerScreen> createState() => _ScorerScreenState();
}

class BallType {
  String? title;
  bool? isSelected;

  BallType(this.title, this.isSelected);
}

class _ScorerScreenState extends State<ScorerScreen>
    with TickerProviderStateMixin {
  TextEditingController teamController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController scoreController = TextEditingController();
  int totalRun = 1;
  List<BallType> noBallType = [
    BallType("From Bat", false),
    BallType("Bye", false),
    BallType("Leg Bye", false)
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
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
          title: Text(
            "Select Team ${widget.team}",
            style: const TextStyle(
              fontSize: 20,
              fontFamily: "Lato_Semibold",
              color: AppColor.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/cricket_bg.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.blackDark.withOpacity(0.6),
                  ),
                  child: Column(
                    children: [
                      const Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "0/0",
                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: AppColor.white,
                                  fontFamily: "Lato_Bold"),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "(01/25)",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: AppColor.white,
                                  fontFamily: "Lato_Bold"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.blackDark.withOpacity(0.4),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.49,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.orange,
                                    child: ClipOval(
                                        child: Image.asset(
                                      "assets/bats.png",
                                      fit: BoxFit.cover,
                                      height: 20,
                                      width: 20,
                                    )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Rajat",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Lato_Bold",
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "0(0)",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Lato_Bold",
                                            fontSize: 16),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 1.1,
                              height: 50,
                              color: Colors.white,
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.49,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.orange,
                                    child: ClipOval(
                                        child: Image.asset(
                                      "assets/bats.png",
                                      fit: BoxFit.cover,
                                      height: 20,
                                      width: 20,
                                    )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mohit",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Lato_Bold",
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "0(0)",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Lato_Bold",
                                            fontSize: 16),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 80,
                color: AppColor.text_grey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColor.brown2,
                          child: ClipOval(
                              child: Image.asset(
                            "assets/ball.png",
                            fit: BoxFit.cover,
                            color: Colors.white,
                          )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rajat",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Lato_Bold",
                                  fontSize: 16),
                            ),
                            Text(
                              "0(0)",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Lato_Bold",
                                  fontSize: 16),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.75,
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 2.0,
                      childAspectRatio: 0.9,
                      scrollDirection: Axis.vertical,
                      children: List.generate(6, (index) {
                        return Container(
                          height: 50,
                          width: 50,
                          color: AppColor.grey,
                          child: index <= 3
                              ? Center(
                                  child: Text(
                                    index.toString(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Lato_Semibold",
                                      color: AppColor.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : index == 4
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            index.toString(),
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Lato_Semibold",
                                              color: AppColor.black,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const Text(
                                            "(Four)",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Lato_Semibold",
                                              color: AppColor.black,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    )
                                  : const Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "6",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Lato_Semibold",
                                              color: AppColor.black,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "(Six)",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Lato_Semibold",
                                              color: AppColor.black,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.25,
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 1,
                      crossAxisSpacing: 1.0,
                      mainAxisSpacing: 1.0,
                      childAspectRatio: 1.38,
                      scrollDirection: Axis.vertical,
                      children: List.generate(3, (index) {
                        return GestureDetector(
                          onTap: () {
                            index == 0
                                ? debugPrint("Undo")
                                : index == 1
                                    ? debugPrint("5,7")
                                    : Navigator.push(
                                        getContext,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const OutScreen()));
                          },
                          child: Container(
                              height: 20,
                              width: 30,
                              color: AppColor.grey,
                              child: Center(
                                child: Text(
                                  index == 0
                                      ? "Undo"
                                      : index == 1
                                          ? "5,7"
                                          : "Out",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Lato_Semibold",
                                    color: index == 0
                                        ? AppColor.green_neon
                                        : index == 1
                                            ? AppColor.text_grey
                                            : AppColor.red,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                crossAxisSpacing: 3.0,
                mainAxisSpacing: 3.0,
                scrollDirection: Axis.vertical,
                children: List.generate(4, (index) {
                  return GestureDetector(
                    onTap: () {
                      _showBottomSheet(
                          context,
                          index == 0
                              ? "WD"
                              : index == 1
                                  ? "NB"
                                  : index == 2
                                      ? "BYE"
                                      : "LB");
                    },
                    child: Container(
                      height: 20,
                      width: 30,
                      color: AppColor.grey,
                      child: Center(
                        child: Text(
                          index == 0
                              ? "WD"
                              : index == 1
                                  ? "NB"
                                  : index == 2
                                      ? "BYE"
                                      : "LB",
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: "Lato_Semibold",
                            color: AppColor.text_grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ));
  }

  void _showBottomSheet(BuildContext context, String type) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        scoreController.text = scoreController.text.toString().isEmpty
            ? "0"
            : scoreController.text.toString();
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  type == "WD"
                      ? "Wide Ball"
                      : type == "NB"
                          ? "No Ball"
                          : type == "BYE"
                              ? "Bye Runs"
                              : "Leg Bye Runs",
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: "Lato_Semibold",
                    color: AppColor.text_grey,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      type,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: "Lato_Semibold",
                        color: AppColor.text_grey,
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.brown2,
                          border: Border.all(color: AppColor.border)),
                      child: Center(
                          child: Text(
                        "1",
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Lato_Semibold",
                          color: AppColor.white,
                        ),
                      )),
                    ),
                    Icon(Icons.add),
                    Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 10, right: 10),
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.white,
                          border: Border.all(color: AppColor.border)),
                      child: Center(
                          child: TextField(
                        controller: scoreController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        onChanged: (value) {
                          if (scoreController.text.isNotEmpty) {
                            setState(() {
                              totalRun = int.parse(value) + 1;
                            });
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration.collapsed(
                            hintStyle: TextStyle(color: AppColor.grey),
                            hintText: ''),
                      )),
                    ),
                    Text(
                      "= $totalRun",
                      style: const TextStyle(
                        fontSize: 22,
                        fontFamily: "Lato_Bold",
                        color: AppColor.black,
                      ),
                    )
                  ],
                ),
                type == "NB"
                    ? Container(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: noBallType.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  for (int i = 0; i < noBallType.length; i++) {
                                    noBallType[i].isSelected = false;
                                  }
                                  noBallType[index].isSelected = true;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  (noBallType[index].isSelected != null &&
                                          noBallType[index].isSelected == false)
                                      ? Icon(
                                          Icons.radio_button_unchecked,
                                          color: AppColor.brown2,
                                        )
                                      : Icon(
                                          Icons.radio_button_checked,
                                          color: AppColor.brown2,
                                        ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    noBallType[index].title.toString(),
                                    style: TextStyle(
                                        fontFamily: "Ubuntu_Regular",
                                        fontSize: 14,
                                        color: AppColor.brown2),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.red.withOpacity(0.1),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: const Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: "Lato_Bold",
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColor.green_neon.withOpacity(0.1),
                        ),
                        child: Center(
                          child: Text(
                            "Ok",
                            style: TextStyle(
                                color: AppColor.green2,
                                fontFamily: "Lato_Bold",
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
      },
    );
  }
}
