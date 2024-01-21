
import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/AppColor.dart';
import 'ResetPasswordScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}



class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
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
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 30),
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
              Image.asset(
                "assets/logo.png",
                height: 300,
                width: 500,
                fit: BoxFit.cover,
              ),
              const Center(
                child: Text(
                  "Forgot your password?",
                  style: TextStyle(fontSize: 30, fontFamily: "Lato_Semibold", color: AppColor.brown2),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "We’ll send you a link to recover it.",
                  style: TextStyle(fontSize: 14, fontFamily: "Lato_Regular"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Email",
                style: TextStyle(fontSize: 16.0, color: AppColor.brown2, fontFamily: "Lato_Semibold"),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: AppColor.white, border: Border.all(color: AppColor.border)),
                child: Center(
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration.collapsed(hintText: 'Email@address.com', hintStyle: TextStyle(color: AppColor.grey)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 40, top: 30),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    AppColor.orange_light,
                    AppColor.orange_light2,
                  ]),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<StadiumBorder>(
                        const StadiumBorder(),
                      ),
                      elevation: MaterialStateProperty.all(8),
                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                      // elevation: MaterialStateProperty.all(3),
                      shadowColor: MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      showRvmDialog("assets/orange_tick.gif", "Link Sent!", "Check your email.");
                      // Navigator.push(getContext, MaterialPageRoute(builder: (context) => ResetPasswordScreen()));
                    },
                    child: const Text(
                      'Send Link',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Lato_Semibold", color: AppColor.white,fontSize: 16),
                    )),
              ),
              const Center(
                child: Text("Didn't receive an email?", style: TextStyle(fontSize: 16.0, color: AppColor.brown2, fontFamily: "Lato_Regular")),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const StadiumBorder(),
                          backgroundColor: AppColor.white,
                          side: const BorderSide(
                            width: 1.0,
                            color: Colors.red,
                          )),
                      child: const Text(
                        "Resend",
                        style: TextStyle(color: AppColor.orange_0, fontFamily: "Lato_Semibold", fontSize: 16),
                      )),
                ),
              ),
              const SizedBox(height: 50)
            ]),
          ),
        ),
      )),
    );
  }

  static void showRvmDialog(String image, String title, String desc) {
    showDialog(
      context: getContext,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 16,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              const SizedBox(height: 15),
              // Load a Lottie file from your assets
              // Lottie.asset('assets/red_tick.js'),
              // Load a Lottie file from a remote url
              Image.asset(image, height: 80, width: 80),
              const SizedBox(height: 10),
              Center(
                  child: Text(
                title,
                style: const TextStyle(
                  fontFamily: "Lato_Semibold",
                  fontSize: 16,
                  color: AppColor.black,
                ),
              )),
              const SizedBox(height: 5),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    desc,
                    style: const TextStyle(fontFamily: "Lato_Bold", fontSize: 16, color: AppColor.black),
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(height: 20),
              Container(
                color: AppColor.border,
                height: 1,
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(getContext, MaterialPageRoute(builder: (context) => const ResetPasswordScreen()));
                },
                child: const Center(
                  child: Text(
                    "Close",
                    style: TextStyle(fontFamily: "Lato_Regular", fontSize: 16, color: AppColor.orange_light),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 15)
            ],
          ),
        );
      },
    );
  }
}
