import 'dart:developer';

import 'package:crick_team/loginSignupRelatedFiles/OtpScreen.dart';
import 'package:crick_team/profileRelatedScrees/EditProfileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apiRelatedFiles/rest_apis.dart';
import '../main.dart';
import '../utils/AppColor.dart';
import '../utils/CommonFunctions.dart';
import '../utils/common.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String verify = "";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool isBettor = false;
bool isOrganiser = false;
bool isScorer = false;
TextEditingController mobileNoController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: Image.asset(
                  "assets/logo.png",
                  height: 250,
                  width: 250,
                  fit: BoxFit.contain,
                ),
              ),
              /* const Center(
                child: Text(
                  "Welcome back!",
                  style: TextStyle(
                      fontSize: 35,
                      fontFamily: "Lato_Semibold",
                      color: AppColor.brown2),
                ),
              ),*/
              const Center(
                child: Text(
                  "Log in as",
                  style: TextStyle(
                      fontSize: 25.0,
                      color: AppColor.brown2,
                      fontFamily: "Lato_Semibold"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isBettor = true;
                        isOrganiser = false;
                        isScorer = false;
                      });
                    },
                    child: Image.asset(
                      isBettor
                          ? "assets/bettor_selected.png"
                          : "assets/bettor_unselected.png",
                      height: 90,
                      width: 90,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isBettor = false;
                        isOrganiser = true;
                        isScorer = false;
                      });
                    },
                    child: Image.asset(
                      isOrganiser
                          ? "assets/organiser_selected.png"
                          : "assets/organiser_unselected.png",
                      height: 90,
                      width: 90,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isBettor = false;
                        isOrganiser = false;
                        isScorer = true;
                      });
                    },
                    child: Image.asset(
                      isScorer
                          ? "assets/scorer_selected.png"
                          : "assets/scorer_unselected.png",
                      height: 90,
                      width: 90,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Mobile No.",
                style: TextStyle(
                    fontSize: 16.0,
                    color: AppColor.brown2,
                    fontFamily: "Lato_Semibold"),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 1,
                height: 55,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: AppColor.white,
                    border: Border.all(color: AppColor.border)),
                child: Row(
                  children: [
                    Text(
                      "+91",
                      style: TextStyle(
                          color: AppColor.grey,
                          fontFamily: "Lato_Semibold",
                          fontSize: 16),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: 2,
                      height: 40,
                      color: AppColor.grey,
                    ),
                    Expanded(
                      child: TextField(
                        controller: mobileNoController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: const InputDecoration.collapsed(
                            hintText: 'Enter mobile no',
                            hintStyle: TextStyle(color: AppColor.grey)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 20),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    AppColor.btnGrad2,
                    AppColor.orange_light,
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
                    onPressed: () async {
                      if (checkValidations()) {
                        // showLoader();
                        FocusManager.instance.primaryFocus?.unfocus();
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: "+91${mobileNoController.text.trim()}",
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            LoginScreen.verify = verificationId;
                            var type = isBettor
                                ? "2"
                                : isScorer
                                    ? "3"
                                    : isOrganiser
                                        ? "1"
                                        : "";
                            // hideLoader();
                            Navigator.push(
                                getContext,
                                MaterialPageRoute(
                                    builder: (context) => OtpScreen(
                                          mobileNo: mobileNoController.text
                                              .trim()
                                              .toString(),
                                          type: type,
                                        )));
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                        // var type =isBettor?"2":isScorer?"3":isOrganiser?"1":"";
                        // Navigator.push(
                        //     getContext,
                        //     MaterialPageRoute(
                        //         builder: (context) =>  OtpScreen(mobileNo:mobileNoController.text.trim().toString(), type: type,)));
                        // loginApi();
                      }
                    },
                    child: const Text(
                      'Log In',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.white,
                          fontFamily: "Lato_Semibold",
                          fontSize: 16),
                    )),
              ),
              const SizedBox(
                height: 40,
              )
            ]),
          ),
        ),
      )),
    );
  }

  loginApi() async {
    var request = {
      'mobile_number': mobileNoController.text.trim(),
      'type': isBettor
          ? "2"
          : isScorer
              ? "3"
              : isOrganiser
                  ? "1"
                  : "",
    };
    await login(request).then((res) async {
      debugPrint("res.body!.name: ${res.body!.name.toString()}");
      log("LoginScreen accountType: ${res.body!.type}");
      if (res.success == 1) {
        toast(res.message);
        if (res.body!.name == null) {
          Navigator.push(
              getContext,
              MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(
                        from: "login_screen",
                      )));
        } else {
          Navigator.push(
              getContext,
              MaterialPageRoute(
                  builder: (context) => OtpScreen(
                        mobileNo: mobileNoController.text.trim(),
                        type: isBettor
                            ? "2"
                            : isScorer
                                ? "3"
                                : isOrganiser
                                    ? "1"
                                    : "",
                      )));
        }
      } else if (res.success != 1 && res.code == 401) {
        toast(res.message);
        Navigator.pushAndRemoveUntil(
            getContext,
            MaterialPageRoute(
              builder: (getContext) => const LoginScreen(),
            ),
            (route) => false);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
      } else {
        CommonFunctions().showToastMessage(context, res.message!);
      }
    });
  }

  bool checkValidations() {
    if (isBettor == false && isScorer == false && isOrganiser == false) {
      CommonFunctions()
          .showToastMessage(getContext, "Please select user type.");
      return false;
    } else if (mobileNoController.text.trim().toString().isEmpty) {
      CommonFunctions()
          .showToastMessage(getContext, "Mobile no. field is required");
      return false;
    } else {
      return true;
    }
  }
}
