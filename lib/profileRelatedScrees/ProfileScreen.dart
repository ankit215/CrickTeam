import 'package:crick_team/profileRelatedScrees/EditProfileScreen.dart';
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
    return Stack(
      children: [
        Image.asset(
          "assets/app_background2.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          // key: scaffoldKey,
          backgroundColor: AppColor.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            "assets/back_arrow.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Stack(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: AppColor.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: CircleAvatar(
                                          radius: 55,
                                          backgroundColor: Colors.white,
                                          child: ClipOval(
                                              child: Image.asset(
                                            "assets/dummy.jpeg",
                                            fit: BoxFit.contain,
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
                                            borderRadius:
                                                BorderRadius.circular(100),
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
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: MediaQuery.sizeOf(context).width * 0.55,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Anil Dogra',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontFamily: "Lato_Semibold",
                                              letterSpacing: 1,
                                              color: AppColor.brown2),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              "assets/location.png",
                                              height: 20,
                                              width: 20,
                                              color: AppColor.brown2,
                                            ),
                                            const Text(
                                              'Shimla',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Lato_Semibold",
                                                  letterSpacing: 1,
                                                  color: AppColor.brown2),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                /*      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            // AppColor.yellow.withOpacity(0.5),
                            AppColor.white,
                            AppColor.white,

                            // AppColor.yellowMed.withOpacity(0.5),
                          ]),
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
                          ]),*/
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),
                          const CustomListTile(
                            image: "assets/my_info.png",
                            title: 'MY INFORMATION',
                          ),
                          const CustomListTile(
                            image: "assets/trophy.png",
                            title: 'ACCOUNT SETTINGS',
                          ),
                          const CustomListTile(
                            image: "assets/privacy_policy.png",
                            title: 'PRIVACY POLICY',
                          ),
                          const CustomListTile(
                            image: "assets/terms_and_conditions.png",
                            title: 'TERMS &  CONDITIONS',
                          ),
                          GestureDetector(
                            onTap: () {
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
                                          padding: const EdgeInsets.only(
                                              right: 100, left: 100),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColor.orange_0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80.0))),
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
                                                backgroundColor: AppColor.white,
                                                elevation: 0),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
