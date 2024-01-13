import 'package:crick_team/utils/AppColor.dart';
import 'package:flutter/material.dart';

class OutModel {
  String? outTitle;
  String? outImage;

  OutModel(this.outTitle, this.outImage);
}

class OutScreen extends StatefulWidget {
  const OutScreen({super.key});

  @override
  State<OutScreen> createState() => _OutScreenState();
}

class _OutScreenState extends State<OutScreen> {
  List<OutModel> outList2 = [OutModel("Bowled", "assets/bowling.png"),
    OutModel("Bowled", "assets/bowling.png"),
    OutModel("Caught", "assets/bowling.png"),
    OutModel("Caught Behind", "assets/bowling.png"),
    OutModel("Caught & Bowled", "assets/bowling.png"),
    OutModel("Stumped", "assets/bowling.png"),
    OutModel("Run Out", "assets/bowling.png"),
    OutModel("LBW", "assets/bowling.png"),
    OutModel("Hit Wicket", "assets/bowling.png"),
    OutModel("Retired Hurt", "assets/bowling.png"),
    OutModel("Retired Out", "assets/bowling.png"),
    OutModel("Run Out", "assets/bowling.png"),
    OutModel("Absent", "assets/bowling.png"),
    OutModel("Obstr the field", "assets/bowling.png"),
    OutModel("Timed Out", "assets/bowling.png"),
    OutModel("Retired", "assets/bowling.png"),

  ];
  List<String> outList = [
    "Bowled",
    "Caught",
    "Caught Behind",
    "Caught & Bowled",
    "Stumped",
    "Run Out",
    "LBW",
    "Hit Wicket",
    "Retired Hurt",
    "Retired Out",
    "Run Out",
    "Absent",
    "Obstr the field",
    "Timed Out",
    "Retired"
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
          "Out how?",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Lato_Semibold",
            color: AppColor.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        childAspectRatio: 0.7,
        scrollDirection: Axis.vertical,
        children: List.generate(outList.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColor.grey,
                  child: ClipOval(
                      child: Image.asset(
                    "assets/cricket.png",
                    fit: BoxFit.contain,
                    height: 30,
                    width: 30,
                  )),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  outList[index],
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: "Lato_Semibold",
                    color: AppColor.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
