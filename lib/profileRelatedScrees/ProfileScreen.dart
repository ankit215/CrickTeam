import 'package:flutter/material.dart';
import '../main.dart';
import '../mainScreens/Menu.dart';
import '../utils/AppColor.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String user = "";
  String name = "";
  String userImage = "";

  @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Scaffold(
        // key: scaffoldKey,
        backgroundColor: AppColor.lightGrey,
        body: Container(
          margin: const EdgeInsets.only(top: 90),
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: const BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: AppColor.grey,
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 100, left: 10, right: 10, bottom: 10),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppColor.white, elevation: 0),
                    onPressed: () {
                    
                    },
                    child: const CustomListTile(
                      image: "assets/trophy.png",
                      title: 'MY INFORMATION',
                    ),
                  ),
                  (user == "5")
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColor.white, elevation: 0),
                          onPressed: () {
                          
                          },
                          child: const CustomListTile(
                            image: "assets/trophy.png",
                            title: 'LOCATIONS',
                          ),
                        )
                      : const SizedBox(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppColor.white, elevation: 0),
                    onPressed: () {
                      
                    },
                    child: const CustomListTile(
                      image: "assets/trophy.png",
                      title: 'ACCOUNT SETTINGS',
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppColor.white, elevation: 0),
                    onPressed: () {
                    
                    },
                    child: const CustomListTile(
                      image: "assets/trophy.png",
                      title: 'PAYMENT',
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppColor.white, elevation: 0),
                    onPressed: () {

                    },
                    child: const CustomListTile(
                      image: "assets/trophy.png",
                      title: 'HELP',
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppColor.white, elevation: 0),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            insetPadding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 16,
                            child: ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                const SizedBox(height: 20),
                                Container(
                                  color: AppColor.lightGrey,
                                  height: 60,
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                        right: 40.0, left: 40.0),
                                    child: Center(
                                      child: Text(
                                        'ARE YOU SURE YOU WANT TO LOG OUT?',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Ubuntu_Regular",
                                            letterSpacing: 1,
                                            color: AppColor.brown2),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 100, left: 100),
                                  child: ElevatedButton(
                                    onPressed: () {

                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: AppColor.orange_0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(80.0))),
                                    child: Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Log Out",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: "Ubuntu_Bold"),
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      right: 30.0, left: 30.0, top: 20),
                                  child: Divider(
                                    height: 1,
                                    color: AppColor.medGrey,
                                    thickness: 1,
                                  ),
                                ),
                                const SizedBox(height: 10),ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(getContext);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: AppColor.white, elevation: 0),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColor.brown2,
                                        fontFamily: "Ubuntu_Regular",
                                      ),
                                    )),
                                const SizedBox(height: 10)
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const CustomListTile(
                      image: "assets/trophy.png",
                      title: 'LOGOUT',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: 150,
        child: Column(
          children: [
            Stack(children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8), // Border radius
                  child: ClipOval(
                      child:Image.asset(
                              "assets/manager.png",
                              fit: BoxFit.contain,
                              height: 150,
                              width: 150,
                            )
                          ),
                ),
              ),
              Positioned(
                  top: 80,
                  left: 110,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                    ),
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Center(
                          child: Image.asset(
                        "assets/edit.png",
                        width: 30,
                        height: 30,
                      )),
                    ),
                  ))
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Text(
                name,
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: "Ubuntu_Bold",
                    color: AppColor.orange),
              ),
            ),
          ],
        ),
      )
    ]);
  }

}
