import 'package:crick_team/startMatchRelatedScreens/SelectTeam.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/CommonFunctions.dart';

class StartMatch extends StatefulWidget {
  const StartMatch({super.key});

  @override
  State<StartMatch> createState() => _StartMatchState();
}

class _StartMatchState extends State<StartMatch> {
  TextEditingController noOfOvers = TextEditingController();
  TextEditingController overPerBowler = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController groundController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

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
                    gradient: LinearGradient(colors: [
                      // AppColor.yellow.withOpacity(0.5),
                      AppColor.brown2.withOpacity(0.2),
                      AppColor.brown2.withOpacity(0.2),
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
                          const Center(
                              child: Text(
                            "Team A vs Team B T20",
                            style: TextStyle(
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
                                            MediaQuery.sizeOf(context).width *
                                                0.19,
                                        decoration: BoxDecoration(
                                          color: AppColor.yellowMed
                                              .withOpacity(0.4),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.1,
                                        ),
                                        CircleAvatar(
                                          radius: 30,
                                          child: ClipOval(
                                              child: Image.asset(
                                            "assets/team_placeholder.png",
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
                                      "10",
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
                                      width: MediaQuery.sizeOf(context).width *
                                          0.2,
                                      decoration: BoxDecoration(
                                        color:
                                            AppColor.yellowMed.withOpacity(0.4),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          child: ClipOval(
                                              child: Image.asset(
                                            "assets/team_placeholder.png",
                                            fit: BoxFit.contain,
                                            height: 45,
                                            width: 45,
                                          )),
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.1,
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
                            "15:00",
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
                  Expanded(
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
                  )
                ],
              ),
              SizedBox(
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
              SizedBox(
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
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: AppColor.lightGrey,
                    border: Border.all(color: AppColor.grey)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
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
                    Icon(Icons.calendar_month)
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
                padding: EdgeInsets.all(10),
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
                          Navigator.of(context).push(
                              showPicker(
                                context: context,
                                value: time,
                                sunrise: const TimeOfDay(hour: 6, minute: 0), // optional
                                sunset: const TimeOfDay(hour: 18, minute: 0), // optional
                                duskSpanInMinutes: 120, // optional
                                onChange: (value){
                                  debugPrint("TIME"+value.toString());
                                },
                              )                          );

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
                    Icon(Icons.access_time)
                  ],
                ),
              )
              ,            GestureDetector(
                onTap: (){
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 30),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      AppColor.red,
                      AppColor.brown2,
                    ]),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
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
    );
  }
}
