import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../utils/AppColor.dart';
import '../utils/CommonFunctions.dart';
import '../utils/common.dart';
import '../utils/constant.dart';
import '../utils/shared_pref.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = getStringAsync(userEmail);
    nameController.text = getStringAsync(firstName);
  }

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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  "assets/back_arrow.png",
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Card(
          color: Colors.white,
          margin: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Contact Us",
                  style: TextStyle(
                      fontFamily: "Lato_Bold",
                      fontSize: 20,
                      color: AppColor.brown2),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Leave us a message and we’ll get back to you as soon as our team is able.",
                  style: TextStyle(
                      fontFamily: "Lato_Bold",
                      fontSize: 16,
                      color: AppColor.brown2),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mail_outline_outlined,
                      color: AppColor.orange_0,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "helpcrickapp@gmail.com",
                      style: TextStyle(
                          fontFamily: "Lato_Bold",
                          fontSize: 16,
                          color: AppColor.orange_0),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                /*  Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.07,
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColor.lightGrey,
                      border: Border.all(color: AppColor.grey)),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Your Email',
                                hintStyle:
                                    TextStyle(color: AppColor.medBrown)),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Image.asset(
                          "assets/mail.png",
                          height: 30,
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.07,
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColor.lightGrey,
                      border: Border.all(color: AppColor.grey)),
                  child:  TextField(
                    controller: nameController,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Your Name',
                        hintStyle: TextStyle(color: AppColor.textColor)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.2,
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColor.lightGrey,
                      border: Border.all(color: AppColor.grey)),
                  child: Center(
                    child: StreamBuilder<Object>(
                        stream: null,
                        builder: (context, snapshot) {
                          return  TextField(
                            controller: messageController,
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Message',
                                hintStyle:
                                    TextStyle(color: AppColor.medBrown)),
                            minLines: 6,
                            // any number you need (It works as the rows for the textarea)
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          );
                        }),
                  ),
                ),*/
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      AppColor.brown2,
                      AppColor.brown2,
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
                        FocusManager.instance.primaryFocus?.unfocus();
                       Navigator.pop(context);
                      },
                      child: const Text('Okay',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center)),
                )
              ],
            ),
          ),
        )));
  }

  bool validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  bool checkValidation() {
    if (emailController.text.trim().toString().isEmpty) {
      CommonFunctions()
          .showToastMessage(getContext, "Email Field Is Required.");
      return false;
    } else if (validateEmail(emailController.text.trim().toString())) {
      CommonFunctions().showToastMessage(getContext, "Enter Valid Email.");
      return false;
    } else if (nameController.text.trim().toString().isEmpty) {
      CommonFunctions().showToastMessage(getContext, "Name Field Is Required.");
      return false;
    } else if (messageController.text.trim().toString().isEmpty) {
      CommonFunctions()
          .showToastMessage(getContext, "Message Field Is Required.");
      return false;
    } else {
      return true;
    }
  }
}
