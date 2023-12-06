import 'package:crick_team/loginSignupRelatedFiles/OtpScreen.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/AppColor.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool _passwordVisible = true;
bool _passwordRVisible = true;
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
                      fontFamily: "Lato_Bold",
                      color: AppColor.brown2),
                ),
              ),*/
                  const Center(
                    child: Text(
                      "Log in as",
                      style: TextStyle(
                          fontSize: 25.0,
                          color: AppColor.brown2,
                          fontFamily: "Lato_Bold"),
                    ),
                  ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isBettor = true;
                        isOrganiser = false;
                        isScorer = false;
                      });
                    },
                    child: Image.asset(
                      isBettor?"assets/bettor_selected.png":"assets/bettor_unselected.png",
                      height: 90,
                      width: 90,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isBettor = false;
                        isOrganiser = true;
                        isScorer = false;
                      });
                    },
                    child: Image.asset(
                      isOrganiser?"assets/organiser_selected.png":"assets/organiser_unselected.png",
                      height: 90,
                      width: 90,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isBettor = false;
                        isOrganiser = false;
                        isScorer = true;
                      });
                    },
                    child: Image.asset(
                      isScorer?"assets/scorer_selected.png":"assets/scorer_unselected.png",
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
                    fontFamily: "Lato_Bold"),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: AppColor.white,
                    border: Border.all(color: AppColor.border)),
                child: TextField(
                  controller: mobileNoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration.collapsed(
                      hintText: 'Enter mobile no',
                      hintStyle: TextStyle(color: AppColor.grey)),
                ),
              ),
            /*  const SizedBox(
                height: 20,
              ),
              const Text(
                "Password",
                style: TextStyle(
                    fontSize: 16.0,
                    color: AppColor.brown2,
                    fontFamily: "Lato_Bold"),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: AppColor.white,
                    border: Border.all(color: AppColor.border)),
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _passwordVisible,
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Password',
                              hintStyle: TextStyle(color: AppColor.grey)),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColor.text_grey,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Spacer(),
                  GestureDetector(
                      onTap: () async {
                        Navigator.push(
                            getContext,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen()));
                      },
                      child: const Text(
                        "Forgot your password?",
                        style: TextStyle(
                            fontFamily: "Ubuntu_Italic",
                            fontSize: 14,
                            color: AppColor.brown2),
                      )),
                ],
              ),*/
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
                    onPressed: () {
                      Navigator.push(
                          getContext,
                          MaterialPageRoute(
                              builder: (context) => const OtpScreen()));
                    },
                    child: const Text(
                      'Log In',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.white,
                          fontFamily: "Lato_Bold",
                          fontSize: 16),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      getContext,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                },
                child: Center(
                  child: RichText(
                    text: const TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: AppColor.brown2,
                              fontFamily: "Lato_Regular")),
                      TextSpan(
                          text: "Sign up",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: AppColor.orange_light,
                              fontFamily: "Lato_Regular"))
                    ]),
                    textAlign: TextAlign.center,
                  ),
                ),
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
}
