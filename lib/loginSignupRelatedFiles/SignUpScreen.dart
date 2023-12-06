import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/AppColor.dart';
import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

bool _passwordVisible = true;
bool _passwordRVisible = true;
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController repeatPasswordController = TextEditingController();

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
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
              Center(
                child: Image.asset(
                  "assets/logo.png",
                  height: 300,
                  width: 500,
                  fit: BoxFit.cover,
                ),
              ),
              const Center(
                child: Text(
                  "Create an account",
                  style: TextStyle(fontSize: 35, fontFamily: "Lato_Bold",color: AppColor.brown2),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Email",
                style: TextStyle(fontSize: 16.0, color: AppColor.brown2, fontFamily: "Lato_Bold"),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                padding: const EdgeInsets.all(15),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(18), color: AppColor.white, border: Border.all(color: AppColor.border)),
                child: Center(
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration.collapsed(hintText: 'Email@address.com', hintStyle: TextStyle(color: AppColor.grey)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Password",
                style: TextStyle(fontSize: 16.0, color: AppColor.brown2, fontFamily: "Lato_Bold"),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                padding: const EdgeInsets.all(15),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(18), color: AppColor.white, border: Border.all(color: AppColor.border)),
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _passwordVisible,
                          decoration: const InputDecoration.collapsed(hintText: 'Password', hintStyle: TextStyle(color: AppColor.grey)),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible ? Icons.visibility_off : Icons.visibility,
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
                height: 10,
              ),
              Container(
                height: 55,
                padding: const EdgeInsets.all(15),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(18), color: AppColor.white, border: Border.all(color: AppColor.border)),
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: repeatPasswordController,
                          obscureText: _passwordRVisible,
                          decoration: const InputDecoration.collapsed(hintText: 'Repeat Password', hintStyle: TextStyle(color: AppColor.grey)),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordRVisible ? Icons.visibility_off : Icons.visibility,
                          color: AppColor.text_grey,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordRVisible = !_passwordRVisible;
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
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 50),
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
                      // Navigator.pushReplacement(getContext, MaterialPageRoute(builder: (context) => const SelectUserTypeScreen()));

                    },
                    child: const Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Lato_Bold", fontSize: 16,color: AppColor.white),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(getContext, MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                child: Center(
                  child: RichText(
                    text: const TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(fontSize: 16.0, color: AppColor.brown2, fontFamily: "Lato_Regular")),
                      TextSpan(text: "Log in", style: TextStyle(fontSize: 16.0, color: AppColor.orange_light, fontFamily: "Lato_Regular"))
                    ]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 30)
            ]),
          ),
        ),
      )),
    );
  }
}
