import 'package:flutter/material.dart';

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

class _ScorerScreenState extends State<ScorerScreen>
    with TickerProviderStateMixin {
  TextEditingController teamController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(
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
                          child: Center(child: Text(index.toString())),
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
                        return Container(
                          height: 20,
                          width: 30,
                          color: AppColor.grey,
                          child: Center(child: Text(index.toString())),
                        );
                      }),
                    ),
                  ),

                ],

              ),
              SizedBox(height: 2,),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                crossAxisSpacing: 3.0,
                mainAxisSpacing: 3.0,
                scrollDirection: Axis.vertical,
                children: List.generate(4, (index) {
                  return Container(
                    height: 20,
                    width: 30,
                    color: AppColor.grey,
                    child: Center(child: Text(index.toString())),
                  );
                }),
              ),
            ],
          ),
        ));
  }
}
