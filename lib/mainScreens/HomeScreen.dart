import 'package:crick_team/utils/AppColor.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'MainScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightGrey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Column(children: [
          AppBar(
            elevation: 0,
            backgroundColor: AppColor.lightGrey,
            leading: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Image.asset(
                "assets/menu_icon.png",
                height: 20,
                width: 20,
              ),
            ),
            actions: <Widget>[
              GestureDetector(
                child:  const Center(
                  child: Text(
                    "45",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Lato_Bold",
                      color: AppColor.brown2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )

            ],
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Home",
                    style: TextStyle(
                        fontSize: 25,
                        color: AppColor.brown2,
                        fontFamily: "Lato_Bold"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Welcome Back, Ankit"
                        "!",
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColor.brown2,
                        fontFamily: "Lato_Regular"),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
             Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/redeem_card.png",
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 100,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.8,
                      left: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "My Rating",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Lato_Bold",
                                    color: AppColor.brown2),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/negative.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      "0",
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontFamily: "Lato_Regular",
                                          color: AppColor.brown2),
                                    )
                                  ]),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.1),
                            child: Column(
                              children: [
                                const Text(
                                  "My Score",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Lato_Bold",
                                      color: AppColor.brown2),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(children: [
                                  Image.asset(
                                    "assets/positive.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    "0",
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontFamily: "Lato_Regular",
                                        color: AppColor.brown2),
                                  )
                                ]),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              Card(
                margin: const EdgeInsets.only(right: 15, left: 15),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Recent Transactions",
                            style: TextStyle(
                                fontFamily: "Lato_bold",
                                fontSize: 16,
                                color: AppColor.brown2),
                          ),

                          GestureDetector(
                            onTap: () {
                              // MainScreen().onItem(3);
                            },
                            child: Image.asset(
                              "assets/add_icon.png",
                              width: 40,
                              height: 40,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Divider(
                        height: 1,
                        color: AppColor.medGrey.withOpacity(0.5),
                        thickness: 1,
                      ),

                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              Card(
                margin: const EdgeInsets.only(right: 15, left: 15),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  height: 230,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                              const Text(
                            "My Locations",
                            style: TextStyle(
                                fontFamily: "Lato_bold",
                                fontSize: 16,
                                color: AppColor.brown2),
                          ),
                          GestureDetector(
                            onTap: () {
                               Navigator.pushReplacement(
                                  getContext,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainScreen(index: 0)));

                              },

                            child: Image.asset(
                              "assets/add_icon.png",
                              width: 40,
                              height: 40,
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
