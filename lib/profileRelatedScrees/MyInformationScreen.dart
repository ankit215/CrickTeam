import 'package:flutter/material.dart';


import '../utils/AppColor.dart';

class MyInformationScreen extends StatefulWidget {
  const MyInformationScreen({Key? key}) : super(key: key);

  @override
  State<MyInformationScreen> createState() => _MyInformationScreenState();
}



class _MyInformationScreenState extends State<MyInformationScreen> {
  String userType = "";
  String date = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightGrey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          backgroundColor: AppColor.lightGrey,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "assets/back_arrow.png",
              height: 20,
              width: 20,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "My Information",
                    style: TextStyle(
                        fontFamily: "Lato_Semibold",
                        fontSize: 20,
                        color: AppColor.brown2),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Name",
                        style: TextStyle(
                            fontFamily: "Lato_Semibold",
                            fontSize: 16,
                            color: AppColor.brown2),
                      ),
                      Text(
                        'User 1',
                        style: const TextStyle(
                            fontFamily: "Lato_Regular",
                            fontSize: 16,
                            color: AppColor.textColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 1,
                    color: AppColor.brown2.withOpacity(0.2),
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Birthday",
                        style: TextStyle(
                            fontFamily: "Lato_Semibold",
                            fontSize: 16,
                            color: AppColor.brown2),
                      ),
                      Text(
                        "15/10/1998",
                        style: const TextStyle(
                            fontFamily: "Lato_Regular",
                            fontSize: 16,
                            color: AppColor.textColor),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 1,
                    color: AppColor.brown2.withOpacity(0.2),
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Joined",
                        style: TextStyle(
                            fontFamily: "Lato_Semibold",
                            fontSize: 16,
                            color: AppColor.brown2),
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                            fontFamily: "Lato_Regular",
                            fontSize: 16,
                            color: AppColor.textColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

  }
}
