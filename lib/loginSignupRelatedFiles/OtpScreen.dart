import 'package:crick_team/apiRelatedFiles/rest_apis.dart';
import 'package:crick_team/mainScreens/MainScreen.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../profileRelatedScrees/EditProfileScreen.dart';
import '../utils/CommonFunctions.dart';
import '../utils/common.dart';
import 'LoginScreen.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNo;
  final String type;

  const OtpScreen({super.key, required this.mobileNo, required this.type});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var otpTextStyles = [const TextStyle(color: Colors.red)];
  var smsCode = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "assets/back_arrow.png",
                    height: 20,
                    width: 20,
                  ),
                ),
                Center(
                    child: Image.asset(
                  "assets/ball.gif",
                  height: 250,
                  width: 250,
                  fit: BoxFit.cover,
                )),
                const Center(
                    child: Text(
                  "OTP Verification",
                  style: TextStyle(
                      color: AppColor.brown2,
                      fontSize: 30,
                      fontFamily: "Lato_Semibold"),
                )),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                'We will send you a one time password on this ',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Lato_Regular",
                                color: AppColor.brown2)),
                        TextSpan(
                            text: 'Mobile No.',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Lato_Semibold",
                                color: AppColor.orange_light)),
                      ],
                    ),
                  ),
                ),
                Center(
                    child: Text(
                  "+91-${widget.mobileNo}",
                  style: const TextStyle(
                      color: AppColor.brown2,
                      fontSize: 16,
                      fontFamily: "Lato_Semibold"),
                )),
                const SizedBox(
                  height: 20,
                ),
                OtpTextField(
                  numberOfFields: 6,
                  borderColor: AppColor.orange_light,
                  focusedBorderColor: AppColor.orange_light,
                  //set to true to show as box or false to show asF dash
                  showFieldAsBox: true,
                  cursorColor: AppColor.orange_light,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    debugPrint("OTP_SUBMIT__$verificationCode");
                    smsCode = verificationCode;
                  }, // end onSubmit
                ),
                const SizedBox(
                  height: 60,
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
                        Navigator.push(
                            getContext,
                            MaterialPageRoute(
                                builder: (context) => MainScreen(
                                  index: 0,
                                )));
                       /* showLoader();
                        FirebaseAuth auth = FirebaseAuth.instance;
                        try{
                          PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: LoginScreen.verify,
                              smsCode: smsCode);

                          // Sign the user in (or link) with the credential
                          await auth.signInWithCredential(credential);
                          loginApi();
                        }catch(e){
                          hideLoader();
                          CommonFunctions().showToastMessage(getContext, "OTP is incorrect.");
                        }*/



                        /*showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              surfaceTintColor: Colors.white,
                              backgroundColor: AppColor.white,
                              insetPadding: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 16,
                              child: ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/logo.png",
                                          width: 150,
                                          height: 150,
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'OTP Matched Successfully',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontFamily: "Lato_Semibold",
                                              color: AppColor.yellowMed),
                                        ),
                                        const SizedBox(height: 20),
                                        Card(
                                          elevation: 8,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: Container(
                                            height: 50,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                  colors: [
                                                    AppColor.yellow,
                                                    AppColor.lightBrown,
                                                    AppColor.orange
                                                  ]),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                  shape: MaterialStateProperty
                                                      .all<StadiumBorder>(
                                                    const StadiumBorder(),
                                                  ),
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          8),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.transparent),
                                                  // elevation: MaterialStateProperty.all(3),
                                                  shadowColor:
                                                      MaterialStateProperty.all(
                                                          Colors.transparent),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                      getContext,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MainScreen(
                                                                index: 0,
                                                              )));
                                                },
                                                child: const Text('Continue',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: AppColor.white,
                                                        fontFamily:
                                                            "Lato_Semibold"),
                                                    textAlign:
                                                        TextAlign.center)),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );*/
                      },
                      child: const Text(
                        'Submit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColor.white,
                            fontFamily: "Lato_Semibold",
                            fontSize: 16),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginApi() async {
    var request = {
      'mobile_number': widget.mobileNo,
      'type': widget.type,
    };
    await login(request,1).then((res) async {
      debugPrint("res.body!.name: ${res.body!.name.toString()}");
      if (res.success == 1) {
        hideLoader();
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
                  builder: (context) => MainScreen(
                        index: 0,
                      )));
        }

        /*Navigator.pushReplacement(
              getContext,
              MaterialPageRoute(
                  builder: (context) => const OtpScreen()));*/
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
}
