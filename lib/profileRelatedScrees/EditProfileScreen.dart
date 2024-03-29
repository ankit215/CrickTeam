import 'dart:io';
import 'package:crick_team/utils/constant.dart';
import 'package:crick_team/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apiRelatedFiles/api_utils.dart';
import '../apiRelatedFiles/rest_apis.dart';
import '../loginSignupRelatedFiles/LoginScreen.dart';
import '../main.dart';
import '../mainScreens/MainScreen.dart';
import '../utils/AppColor.dart';
import '../utils/CommonFunctions.dart';
import '../utils/common.dart';

class EditProfileScreen extends StatefulWidget {
  final String from;
  const EditProfileScreen({super.key, required this.from});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

String user = "";

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? imageFile;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String userImage = "";
  var monthList = [
    'MM',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  List<String> selectGenderList = [
    'Select Gender',
    'Male',
    'Female',
    'Other',
  ];

  List<String> indianStates = [
    'Select State',
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Delhi',
    'Lakshadweep',
    'Puducherry',
  ];

  String dobDay = "DD";
  String dobMonth = "MM";
  String selectState = "Select State";
  String selectGender = "Select Gender";
  String dobYear = "YYYY";
  DateTime dobNow = DateTime.now();

  checkDaysInMonth(String year, String month) {
    if (year != "YYYY" && month != "MM") {
      int mm = monthList.indexOf(month);
      var date = lastDayOfMonth(DateTime(int.parse(year), mm));
      debugPrint("checkDaysInMonth: $date, date.day: ${date.day}");
      if (dobDay != "DD") {
        if (int.parse(dobDay) > date.day) {
          dobDay = "${date.day}";
        }
      }
    }
  }

  List<String> getDays() {
    List<String> days = [];
    days.add("DD");
    int mDays = 31;
    if (dobYear != "YYYY" && dobMonth != "MM") {
      int mm = monthList.indexOf(dobMonth);
      debugPrint("dobYear: $dobYear, dobMonth: $mm");
      var date = lastDayOfMonth(DateTime(int.parse(dobYear), mm));
      debugPrint("getDays: $date, date.day: ${date.day}");
      if (dobNow.month == mm && dobNow.year == int.parse(dobYear)) {
        mDays = dobNow.day;
      } else {
        mDays = date.day;
      }
    }
    for (int i = 1; i <= mDays; i++) {
      if (i < 10) {
        days.add("0$i");
      } else {
        days.add("$i");
      }
    }

    return days;
  }

  List<String> getYear() {
    List<String> days = [];
    days.add("YYYY");
    for (int i = dobNow.year; i > (dobNow.year - 80); i--) {
      days.add("$i");
    }

    return days;
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    /**
     * GETTING USER TYPE HERE. (USER TYPE = 2 (CONSUMER) & USER TYPE = 5 (EMPLOYEE)
     **/
    DateTime dobDate;
    firstNameController.text = getStringAsync(userName);
    emailController.text = getStringAsync(userEmail);
    addressController.text = getStringAsync(address);
    emailController.text = getStringAsync(userEmail);
    selectGender=getStringAsync(gender)=="1"?"Male":getStringAsync(gender)=="2"?"Female":getStringAsync(gender)=="3"?"Others":"Select Gender";
    if (getStringAsync(dob).isNotEmpty) {
      dobDate = DateFormat('MMM/dd/yyyy').parse(getStringAsync(dob));
      dobDay = (dobDate.day < 10) ? '0${dobDate.day}' : '${dobDate.day}';
      dobMonth = monthList[dobDate.month];
      dobYear = dobDate.year.toString();
      debugPrint("dobDay__$dobDay/dobMonth__$dobMonth/dobYear__$dobYear/");
    }
  }

  String capitalizeOnlyFirstLater(String value) {
    if (value.trim().isEmpty) return "";
    return "${value[0].toUpperCase()}${value.substring(1)}";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Stack(
        children: [
          Image.asset(
            "assets/app_background.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
            // resizeToAvoidBottomInset: false,
            backgroundColor: AppColor.transparent,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Row(children: [
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/back_arrow.png',
                        alignment: Alignment.centerLeft,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    const Spacer(),
                     Text(widget.from=="profile_screen"?"EDIT PROFILE":"ADD DETAILS",
                        style: const TextStyle(
                            fontSize: 20.0,
                            letterSpacing: 2,
                            color: AppColor.brown2,
                            fontFamily: "Lato_Semibold"),
                        textAlign: TextAlign.center),
                    const Spacer(),
                    const SizedBox(
                      width: 55,
                    ),
                  ]),
                )
              ]),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(children: [
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
                                child: getStringAsync(image).isNotEmpty&&imageFile==null?
                                Image.network(
                                  mediaUrl + getStringAsync(image),
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                )
                                    :imageFile == null&&getStringAsync(image).isEmpty
                                    ? Image.asset(
                                        "assets/user_placeholder.png",
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        imageFile!,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
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
                              borderRadius: BorderRadius.circular(100),
                              color: AppColor.brown2,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                _showBottomSheet(getContext);
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "NAME",
                    style: TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 1,
                        color: AppColor.brown2,
                        fontFamily: "Lato_Semibold"),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColor.lightGrey,
                        border: Border.all(color: AppColor.grey)),
                    child: TextField(
                      controller: firstNameController,
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Enter Name',
                          hintStyle: TextStyle(color: AppColor.medBrown)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "EMAIL",
                    style: TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 1,
                        color: AppColor.brown2,
                        fontFamily: "Lato_Semibold"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColor.lightGrey,
                        border: Border.all(color: AppColor.grey)),
                    child: TextField(
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(color: AppColor.medBrown)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "DOB",
                    style: TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 1,
                        color: AppColor.brown2,
                        fontFamily: "Lato_Semibold"),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.lightGrey,
                            border: Border.all(color: AppColor.grey)),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                hintText: "MM",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                              ),
                              value: dobMonth,
                              dropdownColor: AppColor.lightGrey,
                              iconEnabledColor: AppColor.medBrown,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: monthList.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items,
                                    style: TextStyle(
                                        color: (dobMonth == "MM")
                                            ? AppColor.medBrown
                                            : Colors.black,
                                        fontFamily: "Lato_Regular"),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                int mm = monthList.indexOf(newValue!);
                                if (dobNow.month == mm) {
                                  dobDay = 'DD';
                                }
                                checkDaysInMonth(dobYear, newValue);
                                setState(() {
                                  dobMonth = newValue;
                                });
                              },
                            )),
                      )),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.lightGrey,
                            border: Border.all(color: AppColor.grey)),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                hintText: "DD",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                              ),
                              value: dobDay,
                              dropdownColor: AppColor.lightGrey,
                              iconEnabledColor: AppColor.medBrown,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: getDays().map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items,
                                    style: TextStyle(
                                        color: (dobDay == "DD")
                                            ? AppColor.medBrown
                                            : Colors.black,
                                        fontFamily: "Lato_Regular"),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dobDay = newValue!;
                                });
                              },
                            )),
                      )),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.lightGrey,
                            border: Border.all(color: AppColor.grey)),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                hintText: "YYYY",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                              ),
                              value: dobYear,
                              dropdownColor: Colors.white,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              iconEnabledColor: AppColor.medBrown,
                              items: getYear().map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items,
                                    style: TextStyle(
                                        color: (dobYear == "YYYY")
                                            ? AppColor.medBrown
                                            : Colors.black,
                                        fontFamily: "Lato_Regular"),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                int mm = monthList.indexOf(dobMonth);
                                if (dobNow.year.toString() == newValue &&
                                    dobNow.month == mm) {
                                  dobDay = 'DD';
                                }
                                checkDaysInMonth(newValue!, dobMonth);
                                setState(() {
                                  dobYear = newValue;
                                });
                              },
                            )),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "ADRESS",
                    style: TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 1,
                        color: AppColor.brown2,
                        fontFamily: "Lato_Semibold"),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColor.lightGrey,
                        border: Border.all(color: AppColor.grey)),
                    child: TextField(
                      controller: addressController,
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Enter Address',
                          hintStyle: TextStyle(color: AppColor.medBrown)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "STATE",
                    style: TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 1,
                        color: AppColor.brown2,
                        fontFamily: "Lato_Semibold"),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColor.lightGrey,
                        border: Border.all(color: AppColor.grey)),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 1),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            hintText: "Select State",
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                          ),
                          value: selectState,
                          dropdownColor: AppColor.lightGrey,
                          iconEnabledColor: AppColor.medBrown,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: indianStates.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: TextStyle(
                                    color: (selectState == "Select State")
                                        ? AppColor.medBrown
                                        : Colors.black,
                                    fontFamily: "Lato_Regular"),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectState = newValue!;
                            });
                          },
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "GENDER",
                    style: TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 1,
                        color: AppColor.brown2,
                        fontFamily: "Lato_Semibold"),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColor.lightGrey,
                        border: Border.all(color: AppColor.grey)),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 1),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            hintText: "Select Gender",
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                          ),
                          value: selectGender,
                          dropdownColor: AppColor.lightGrey,
                          iconEnabledColor: AppColor.medBrown,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: selectGenderList.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: TextStyle(
                                    color: (selectGender == "Select Gender")
                                        ? AppColor.medBrown
                                        : Colors.black,
                                    fontFamily: "Lato_Regular"),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectGender = newValue!;
                            });
                          },
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {
                            if (checkValidation()) {
                              updateUserDetails();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            padding: const EdgeInsets.all(0.0),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColor.yellowV2,
                                    AppColor.orange,
                                    AppColor.red,
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              constraints: const BoxConstraints(
                                  maxWidth: 300.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: const Text(
                                "Submit",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: "Lato_Semibold"),
                              ),
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
    );
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
    if (firstNameController.text.trim().toString() == '') {
      CommonFunctions()
          .showToastMessage(getContext, "First Name Field Is Required");
      return false;
    } else if (validateEmail(emailController.text.trim().toString())) {
      CommonFunctions().showToastMessage(getContext, "Enter valid email");
      return false;
    } else if (dobDay == "DD") {
      CommonFunctions().showToastMessage(getContext, "Day Field Is Required.");
      return false;
    } else if (dobMonth == "MM") {
      CommonFunctions()
          .showToastMessage(getContext, "Month Field Is Required.");
      return false;
    } else if (dobYear == "YYYY") {
      CommonFunctions().showToastMessage(getContext, "Year Field Is Required.");
      return false;
    } else if (addressController.text.trim().toString().isEmpty) {
      CommonFunctions()
          .showToastMessage(getContext, "Address Field Is Required.");
      return false;
    } else if (selectGender=="Select Gender") {
      CommonFunctions()
          .showToastMessage(getContext, "Gender Field Is Required.");
      return false;
    } else {
      return true;
    }
  }

  Future _imagePick(ImageSource source) async {
    var images = await ImagePicker().pickImage(source: source);
    if (images != null) {
      debugPrint("image_path: ${images.path}");
      imageFile = await FlutterNativeImage.compressImage(images.path,
          quality: 20, percentage: 60);
      // await setValue(image, imageFile!.path);
      setState(() {});
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              title: const Text(
                "Gallery",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              leading: const Icon(Icons.image),
              onTap: () {
                _imagePick(ImageSource.gallery);
                // _getFromGallery();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                "Camera",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              leading: const Icon(Icons.camera),
              onTap: () {
                _imagePick(ImageSource.camera);
                // _getFromCamera();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> updateUserDetails() async {
    showLoader();
    MultipartRequest multiPartRequest =
        await getMultiPartRequest('edit_profile', method: 'POST');
    multiPartRequest.fields['id'] = getStringAsync(userId);
    multiPartRequest.fields['name'] =
        firstNameController.text.trim().toString();
    multiPartRequest.fields['email_address'] =
        emailController.text.trim().toString();
    multiPartRequest.fields['address'] = addressController.text.trim().toString();
    multiPartRequest.fields['dob'] = "$dobMonth/$dobDay/$dobYear";
    multiPartRequest.fields['gender'] = selectGender == "Male"
        ? "1"
        : selectGender == "Female"
            ? "2"
            : "3";
    if (imageFile != null) {
      multiPartRequest.files
          .add(await MultipartFile.fromPath('profile_photo', imageFile!.path));
    }
    multiPartRequest.headers.addAll(buildHeaderTokens());
    var res = await updateProfile(multiPartRequest);
    hideLoader();
    if (res.success == 1) {
      setValue(userName,firstNameController.text.trim().toString() );
      setValue(userEmail,emailController.text.trim().toString() );
      toast(res.message);
      if(widget.from=="profile_screen"){
        Navigator.pop(getContext, res.body);
      }else{
        Navigator.push(getContext, MaterialPageRoute(builder: (context) =>  MainScreen(index: 0,)));
      }

    } else if (res.message == "Invalid Token" && res.code == 400) {
      toast(res.message);
      Navigator.pushAndRemoveUntil(
          getContext,
          MaterialPageRoute(
            builder: (getContext) => const LoginScreen(),
          ),
          (route) => false);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
    } else if (res.message == "Invalid Token" && res.code == 400) {
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
      CommonFunctions().showToastMessage(getContext, res.message!);
    }
  }

  static int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[
      31,
      -1,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];
    return daysInMonth[month - 1];
  }
}
