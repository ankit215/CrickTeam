import 'dart:io';
import 'package:crick_team/utils/data_type_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import 'AppColor.dart';

final navigatorKey = GlobalKey<NavigatorState>();

/*Future<void> urlLauncher(String link) async {
  Uri url = Uri.parse(link);
  debugPrint("launch_url: $url");
  await url_launcher.launchUrl(url).catchError((e) {
    toast('Invalid URL: $link');
  });
}*/
String getFirstLetters(String input) {
  List<String> words = input.split(" ");
  String result = "";

  for (String word in words) {
    if (word.isNotEmpty) {
      result += word[0];
    }
  }
  return result.toUpperCase(); // Convert to uppercase if needed
}

Widget emptyWidget(String message) {
  return Center(
    child: Text(
      message,
      style: const TextStyle(
        fontSize: 20,
        color: AppColor.lightGrey,
        fontWeight: FontWeight.w500, // bold
      ),
    ),
  );
}

Future<String> getCompressedImage(String imageFile) async {
  File compressedFile = await FlutterNativeImage.compressImage(imageFile,
      quality: 20, percentage: 60);
  return compressedFile.path;
}

getDate(String expiryDate) {
  DateTime tempDate = DateFormat("yyyy-mm-dd").parse(expiryDate);
  String date = DateFormat('dd-mm-yy').format(tempDate);
  return date;
}

bool isLoading = false;

void showLoader() {
  if (isLoading) {
    return;
  }
  isLoading = true;
  showDialog(
      context: getContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        FocusManager.instance.primaryFocus?.unfocus();
        return WillPopScope(
          onWillPop: () async => !isLoading,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: AppColor.whiteTrans,
            // color: MyColors.transparent10,
            alignment: Alignment.center,
            child: loader(),
          ),
        );
      });
}

Widget loader({double size = 40, double strokeWidth = 3}) {
  return SizedBox(
    height: size,
    width: size,
    child: CircularProgressIndicator(
      strokeWidth: strokeWidth,
      color: AppColor.orange,
    ),
  );
}

void hideLoader() {
  if (isLoading) {
    isLoading = false;
    pop();
  }
}

/// Toast for default time
void toast(
  String? value, {
  ToastGravity? gravity,
  length = Toast.LENGTH_SHORT,
  Color? bgColor,
  Color? textColor,
  bool print = false,
}) {
  if (value.validate().isEmpty) {
    debugPrint("ToastValue: $value");
  } else {
    Fluttertoast.showToast(
      msg: value.validate(),
      gravity: gravity,
      toastLength: length,
      backgroundColor: bgColor,
      textColor: textColor,
    );
    if (print) debugPrint("ToastValue: $value");
  }
}

void toastLong(
  String? value, {
  ToastGravity? gravity,
  length = Toast.LENGTH_LONG,
  Color? bgColor,
  Color? textColor,
  bool print = false,
}) {
  if (value.validate().isEmpty) {
    debugPrint("ToastValue: $value");
  } else {
    Fluttertoast.showToast(
      msg: value.validate(),
      gravity: gravity,
      toastLength: length,
      backgroundColor: bgColor,
      textColor: textColor,
    );
    if (print) debugPrint("ToastValue: $value");
  }
}

String parseHtmlString(String? htmlString) {
  return parse(parse(htmlString).body!.text).documentElement!.text;
}

/*PageRouteAnimation? pageRouteAnimationGlobal;

enum PageRouteAnimation { fade, scale, rotate, slide, slideBottomTop }

Duration pageRouteTransitionDurationGlobal = 400.milliseconds;

Route<T> buildPageRoute<T>(
    Widget child, PageRouteAnimation? pageRouteAnimation, Duration? duration) {
  if (pageRouteAnimation != null) {
    if (pageRouteAnimation == PageRouteAnimation.fade) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.rotate) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) =>
            RotationTransition(turns: ReverseAnimation(anim), child: child),
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.scale) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) =>
            ScaleTransition(scale: anim, child: child),
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.slide) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) => SlideTransition(
          position:
              Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                  .animate(anim),
          child: child,
        ),
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.slideBottomTop) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) => SlideTransition(
          position:
              Tween(begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0.0))
                  .animate(anim),
          child: child,
        ),
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    }
  }
  return MaterialPageRoute<T>(builder: (_) => child);
}

/// Redirect to given widget without context
Future<T?> push<T>(
  Widget widget, {
  bool isNewTask = false,
  PageRouteAnimation? pageRouteAnimation,
  Duration? duration,
}) async {
  if (isNewTask) {
    return await Navigator.of(getContext).pushAndRemoveUntil(
      buildPageRoute(
          widget, pageRouteAnimation ?? pageRouteAnimationGlobal, duration),
      (route) => false,
    );
  } else {
    return await Navigator.of(getContext).push(
      buildPageRoute(
          widget, pageRouteAnimation ?? pageRouteAnimationGlobal, duration),
    );
  }

}


}*/

/// Dispose current screen or close current alert_dialog
void pop([Object? object]) {
  if (Navigator.canPop(getContext)) Navigator.pop(getContext, object);
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var smallLineLength = size.width / 20;
    const smallLineHeight = 10;
    var path = Path();

    path.lineTo(0, size.width);
    for (int i = 1; i <= 20; i++) {
      if (i % 2 == 0) {
        path.lineTo(smallLineLength * i, size.height);
      } else {
        path.lineTo(smallLineLength * i, size.height - smallLineHeight);
      }
    }
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) => false;
}
