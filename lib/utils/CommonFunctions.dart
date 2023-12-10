import 'package:flutter/material.dart';

import '../main.dart';
import 'AppColor.dart';

/// The last day of a given month
DateTime lastDayOfMonth(DateTime month) {
  var beginningNextMonth = (month.month < 12)
      ? DateTime(month.year, month.month + 1, 1)
      : DateTime(month.year + 1, 1, 1);
  return beginningNextMonth.subtract(const Duration(days: 1));
}

class CommonFunctions {
  /*static Future<String> selectDate() async {
    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.single,
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: const TextStyle(
        color: AppColor.grey,
        fontFamily: "Ubuntu_Bold",
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: "Ubuntu_Bold",
      ),
      dayTextStyle: const TextStyle(
        color: Colors.black,
        fontFamily: "Ubuntu_Regular",
        fontWeight: FontWeight.bold,
      ),
      selectedDayHighlightColor: AppColor.yellow,
      todayTextStyle: const TextStyle(
        color: AppColor.orange,
        fontSize: 18,
        fontFamily: "Ubuntu_Bold",
      ),
      selectedDayTextStyle: const TextStyle(
        color: AppColor.orange,
        fontSize: 18,
        fontFamily: "Ubuntu_Bold",
      ),
      closeDialogOnCancelTapped: true,
    );
    final values = await showCalendarDatePicker2Dialog(
      context: getContext,
      config: config,
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(15),
      dialogBackgroundColor: Colors.white,
    );
    if (values != null) {
      String formattedDate = DateFormat('MMMM dd, yyyy').format(values.single!);
      debugPrint(
          "SELECTED_DATE___$formattedDate"); //get the picked date in the format => 2022-07-04 00:00:00.000
      return formattedDate;
    } else {
      debugPrint("Date is not selected");
    }
    return "";
  }*/

 /* static void showSuccessDialog(String title) {
    showDialog(
      context: getContext,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 16,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              const SizedBox(height: 20),
              // Load a Lottie file from your assets
              // Lottie.asset('assets/red_tick.js'),
              // Load a Lottie file from a remote url
              SizedBox(
                height: 150,
                width: 150,
                child: Lottie.network(
                    'https://assets10.lottiefiles.com/temp_editor_files/lf30_editor_ojnieuya.json'),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontFamily: "Ubuntu_Bold",
                      fontSize: 20,
                      color: AppColor.yellowMed),
                ),
              ),
              // const SizedBox(height: 10),
              // const Center(
              //   child: Text(
              //     "Your transaction was submitted!",
              //     style: TextStyle(
              //         fontFamily: "Ubuntu_Regular",
              //         fontSize: 14,
              //         color: AppColor.brown),
              //   ),
              // ),
              const SizedBox(height: 30)
            ],
          ),
        );
      },
    );
  }*/

  static void showSuccessImageDialog(String image, String title, String desc) {
    showDialog(
      context: getContext,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 16,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              const SizedBox(height: 20),
              // Load a Lottie file from your assets
              // Lottie.asset('assets/red_tick.js'),
              // Load a Lottie file from a remote url
              Image.asset(image, height: 150, width: 150),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: "Ubuntu_Bold",
                      fontSize: 20,
                      color: (title == "Scan Successful")
                          ? AppColor.green
                          : AppColor.orange_0),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  desc,
                  style: const TextStyle(
                      fontFamily: "Ubuntu_Bold",
                      fontSize: 16,
                      color: AppColor.brown2),
                ),
              ),

              // const SizedBox(height: 10),
              // const Center(
              //   child: Text(
              //     "Your transaction was submitted!",
              //     style: TextStyle(
              //         fontFamily: "Ubuntu_Regular",
              //         fontSize: 14,
              //         color: AppColor.brown),
              //   ),
              // ),
              const SizedBox(height: 30)
            ],
          ),
        );
      },
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showToastMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColor.red,
      content: Text(
        message,
        style: const TextStyle(
            fontFamily: "Ubuntu_Regular", fontSize: 16, letterSpacing: 1),
      ),
    ));
  }
}
