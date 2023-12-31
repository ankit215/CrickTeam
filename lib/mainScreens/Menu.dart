import 'package:crick_team/main.dart';
import 'package:crick_team/profileRelatedScrees/MyInformationScreen.dart';
import 'package:crick_team/profileRelatedScrees/ProfileScreen.dart';
import 'package:crick_team/startMatchRelatedScreens/SelectPlayingTeams.dart';
import 'package:flutter/material.dart';

import '../utils/AppColor.dart';
import 'MainScreen.dart';

class Menu extends StatefulWidget {
  final Function(int index) bottomIndex;

  const Menu({
    Key? key,
    required this.bottomIndex,
  }) : super(key: key);

  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu> {
  @override
  Widget build(BuildContext ctxt) {
    return Scaffold(

      body: Drawer(
        backgroundColor: Colors.white,
        width: double.infinity,
        child: ListView(
          children: <Widget>[
            Image.asset(
              "assets/logo.png",
              height: 200,
              width: 200,
              fit: BoxFit.contain,

            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: AppColor.transparent, elevation: 0),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
                widget.bottomIndex(userType == "2" ? 2 : 0);
              },
              child: const CustomListTile(
                image: "assets/home_icon.png",
                title: 'HOME',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.transparent, elevation: 0),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
                Navigator.push(
                    getContext,
                    MaterialPageRoute(
                        builder: (context) =>
                        const ProfileScreen()));
              },
              child: const CustomListTile(
                image: "assets/my_info.png",
                title: 'PROFILE',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.transparent, elevation: 0),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: const CustomListTile(
                image: "assets/bell.png",
                title: 'NOTIFICATIONS',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.transparent, elevation: 0),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    getContext,
                    MaterialPageRoute(
                        builder: (context) =>
                        const SelectPlayingTeams()));
              },
              child: const CustomListTile(
                image: "assets/cricket.png",
                title: 'START THE MATCH',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.transparent, elevation: 0),
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
                              padding: EdgeInsets.only(right: 40.0, left: 40.0),
                              child: Center(
                                child: Text(
                                  'ARE YOU SURE YOU WANT TO LOG OUT?',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Lato_Regular",
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
                            padding:
                                const EdgeInsets.only(right: 100, left: 100),
                            child: ElevatedButton(
                              onPressed: () async {
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.orange_0,
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
                                      fontFamily: "Lato_Semibold"),
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
                          const SizedBox(height: 10),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(getContext);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.white, elevation: 0),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.brown2,
                                  fontFamily: "Lato_Regular",
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
                image: "assets/logout.png",
                title: 'LOGOUT',
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomListTile extends StatefulWidget {
  final String image;
  final String title;

  const CustomListTile({Key? key, required this.image, required this.title})
      : super(key: key);

  @override
  State<CustomListTile> createState() => _CustomListTile();
}

class _CustomListTile extends State<CustomListTile> {
  @override
  Widget build(BuildContext ctxt) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
      child: Container(
        height: 70,
        alignment: Alignment.center,

        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Image.asset(
                  widget.image,
                  height: 30,
                  width: 30,
                  color: AppColor.brown2,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontFamily: "Lato_Semibold",
                      fontSize: 16,
                      color: AppColor.medBrown,),
                )
              ],
            ),
            Divider(
              height: 40,
              color: (widget.title.toLowerCase() != "logout")
                  ? AppColor.brown2.withOpacity(0.2)
                  : AppColor.white,
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}
