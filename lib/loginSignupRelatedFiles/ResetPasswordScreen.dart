import 'package:flutter/material.dart';

import '../utils/AppColor.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

TextEditingController emailController = TextEditingController();

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
              const SizedBox(height: 50),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Image.asset(
                  "assets/back_arrow.png",
                  height: 20,
                  width: 20,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                "assets/logo.png",
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 30, fontFamily: "Lato_Semibold"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "New Password",
                style: TextStyle(fontSize: 16.0, color: AppColor.black, fontFamily: "Lato_Semibold"),
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
                    decoration: const InputDecoration.collapsed(hintText: 'Enter New Password', hintStyle: TextStyle(color: AppColor.text_grey)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ,
              ),
              const Text(
                "Repeat Password",
                style: TextStyle(fontSize: 16.0, color: AppColor.black, fontFamily: "Lato_Semibold"),
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
                    decoration: const InputDecoration.collapsed(hintText: "Enter Repeat Password", hintStyle: TextStyle(color: AppColor.text_grey)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30,bottom: 100),
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
                    onPressed: () {},
                    child: const Text(
                      'Save',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Lato_Semibold", fontSize: 16),
                    )),
              ),
            ]),
          ),
        ),
      )),
    );
  }
}
