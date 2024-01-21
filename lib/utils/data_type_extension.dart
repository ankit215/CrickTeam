
bool hasMatch(String? s, String p) {
  return (s == null) ? false : RegExp(p).hasMatch(s);
}

RegExp alphaRegExp = RegExp(r'^[a-zA-Z]+$');

extension StringExtension on String? {
  /// Check email validation
/*  bool validateEmail() => hasMatch(this, Patterns.email);

  /// Check phone validation
  bool validatePhone() => hasMatch(this, Patterns.phone);

  /// Check URL validation
  bool validateURL() => hasMatch(this, Patterns.url);*/

  /// Returns true if given String is null or isEmpty
  bool get isEmptyOrNull =>
      this == null ||
      (this != null && this!.isEmpty) ||
      (this != null && this! == 'null');

  // Check null string, return given value if null
  String validate({String value = ''}) {
    if (isEmptyOrNull) {
      return value;
    } else {
      return this!;
    }
  }

  /// Capitalize given String
  String capitalizeFirstLetter() => (validate().isNotEmpty)
      ? (this!.substring(0, 1).toUpperCase() + this!.substring(1).toLowerCase())
      : validate();

 /* /// Image regex
  bool get isImage => hasMatch(this, Patterns.image);

  /// Audio regex
  bool get isAudio => hasMatch(this, Patterns.audio);

  /// Video regex
  bool get isVideo => hasMatch(this, Patterns.video);

  /// Txt regex
  bool get isTxt => hasMatch(this, Patterns.txt);

  /// Document regex
  bool get isDoc => hasMatch(this, Patterns.doc);

  /// Excel regex
  bool get isExcel => hasMatch(this, Patterns.excel);

  /// PPT regex
  bool get isPPT => hasMatch(this, Patterns.ppt);

  /// Document regex
  bool get isApk => hasMatch(this, Patterns.apk);

  /// PDF regex
  bool get isPdf => hasMatch(this, Patterns.pdf);

  /// HTML regex
  bool get isHtml => hasMatch(this, Patterns.html);*/

  /// Return true if given String is Digit
  bool isDigit() {
    if (validate().isEmpty) {
      return false;
    }
    if (validate().length > 1) {
      for (var r in this!.runes) {
        if (r ^ 0x30 > 9) {
          return false;
        }
      }
      return true;
    } else {
      return this!.runes.first ^ 0x30 <= 9;
    }
  }

  bool get isInt => this!.isDigit();

  /// Check weather String is alpha or not
  bool isAlpha() => alphaRegExp.hasMatch(validate());

 /* bool isJson() {
    try {
      json.decode(validate());
    } catch (e) {
      return false;
    }
    return true;
  }*/

  // Copy String to Clipboard
  /*Future<void> copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: validate()));
  }*/

  /// for ex. add comma in price
  String formatNumberWithComma({String separator = ','}) {
    return validate().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}$separator');
  }

  /// It reverses the String
  String get reverse {
    if (validate().isEmpty) {
      return '';
    }
    return toList().reversed.reduce((value, element) => value += element);
  }

  /// It return list of single character from String
  List<String> toList() {
    return validate().trim().split('');
  }

  /// Splits from a [pattern] and returns remaining String after that
  String splitAfter(Pattern pattern) {
    ArgumentError.checkNotNull(pattern, 'pattern');
    var matchIterator = pattern.allMatches(this!).iterator;

    if (matchIterator.moveNext()) {
      var match = matchIterator.current;
      var length = match.end - match.start;
      return validate().substring(match.start + length);
    }
    return '';
  }

  /// Splits from a [pattern] and returns String before that
  String splitBefore(Pattern pattern) {
    ArgumentError.checkNotNull(pattern, 'pattern');
    var matchIterator = pattern.allMatches(validate()).iterator;

    Match? match;
    while (matchIterator.moveNext()) {
      match = matchIterator.current;
    }

    if (match != null) {
      return validate().substring(0, match.start);
    }
    return '';
  }

  /// It matches the String and returns between [startPattern] and [endPattern]
  String splitBetween(Pattern startPattern, Pattern endPattern) {
    return splitAfter(startPattern).splitBefore(endPattern);
  }

  /// Return int value of given string
  int toInt({int defaultValue = 0}) {
    if (this == null) return defaultValue;

    if (isDigit()) {
      return int.parse(this!);
    } else {
      return defaultValue;
    }
  }

  /// Return double value of given string
  double toDouble({double defaultValue = 0.0}) {
    if (this == null) return defaultValue;

    try {
      return double.parse(this!);
    } catch (e) {
      return defaultValue;
    }
  }
}

extension NumExtensions on num? {
  /// Validate given int is not null and returns given value if null.
  num validate({num value = 0}) {
    return this ?? value;
  }
}

extension IntExtensions on int? {
  /// Validate given int is not null and returns given value if null.
  int validate({int value = 0}) {
    return this ?? value;
  }

  /// HTTP status code
  bool isSuccessful() => this! >= 200 && this! <= 206;

  /// Returns microseconds duration
  /// 5.microseconds
  Duration get microseconds => Duration(microseconds: validate());

  /// Returns milliseconds duration
  /// ```dart
  /// 5.milliseconds
  /// ```
  Duration get milliseconds => Duration(milliseconds: validate());

  /// Returns seconds duration
  /// ```dart
  /// 5.seconds
  /// ```
  Duration get seconds => Duration(seconds: validate());

  /// Returns minutes duration
  /// ```dart
  /// 5.minutes
  /// ```
  Duration get minutes => Duration(minutes: validate());

  /// Returns hours duration
  /// ```dart
  /// 5.hours
  /// ```
  Duration get hours => Duration(hours: validate());

  /// Returns days duration
  /// ```dart
  /// 5.days
  /// ```
  Duration get days => Duration(days: validate());
}

// Boolean Extensions
extension BooleanExtensions on bool? {
  /// Validate given bool is not null and returns given value if null.
  bool validate({bool value = false}) => this ?? value;
}

extension DoubleExtensions on double? {
  /// Validate given double is not null and returns given value if null.
  double validate({double value = 0.0}) => this ?? value;
}
