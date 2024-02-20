import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  setUserType(String userType) async {
    SharedPreferences type = await SharedPreferences.getInstance();
    type.setString("user_type", userType);
  }

  Future<String> getUserType() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var userType = pref.getString("user_type");
    if(userType==null){
      return "";
    }
    return userType;
  }
}
