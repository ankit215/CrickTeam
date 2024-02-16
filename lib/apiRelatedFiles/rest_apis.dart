import 'dart:convert';
import 'package:crick_team/utils/data_type_extension.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modalClasses/AddTeamModel.dart';
import '../modalClasses/GetMatchModel.dart';
import '../modalClasses/GetPlayerSearchModel.dart';
import '../modalClasses/GetTeamDetailModel.dart';
import '../modalClasses/GetTeamModel.dart';
import '../modalClasses/LoginModel.dart';
import '../modalClasses/UpdateProfileModel.dart';
import '../modalClasses/api_response_model.dart';
import '../utils/common.dart';
import '../utils/constant.dart';
import '../utils/shared_pref.dart';
import 'api_utils.dart';
import 'network_available.dart';

late SharedPreferences sharedPreferences;
// Must be initialize before using shared preference
Future<void> iniSharePref() async {
  sharedPreferences = await SharedPreferences.getInstance();
}

Future<Response> buildMultiPartRequest(
    MultipartRequest multiPartRequest) async {
  debugPrint(
      'url: ${multiPartRequest.url}\nheaders: ${multiPartRequest.headers}\nrequestFields: ${multiPartRequest.fields}');

  http.Response response =
      await http.Response.fromStream(await multiPartRequest.send());
  debugPrint(
      'responseCode: ${response.statusCode}\nresponseBody ${response.body}');

  return response;
}

Future<void> saveUserData(LoginData data, {bool login = true}) async {
  await setValue(isLogin, login);
  await setValue(userId, data.id.toString().validate());
  await setValue(accountType, data.type.validate());
  await setValue(userName, data.name.validate());
  await setValue(dob, data.dob.validate());
  await setValue(image, data.profilePhoto.validate());
  await setValue(userEmail, data.emailAddress.validate());
  await setValue(token, data.token.validate());
  await setValue(address, data.address.validate());
  await setValue(gender, data.gender.toString().validate());
}

/*Future<void> saveCreateUserData(SignUpData data, {bool login = true}) async {
  await setValue(isLogin, login);
  await setValue(userId, data.id.toString().validate());
  await setValue(accountType, data.accountType.validate());
  await setValue(userName, data.fullName.validate());
  await setValue(firstName, data.firstName.validate());
  await setValue(lastName, data.lastName.validate());
  await setValue(birthday, data.dob.validate());
  await setValue(userCoins, data.userCoins.validate());
  await setValue(workId, data.workId.validate());
  await setValue(ssn, data.sSN.validate());
  await setValue(joined, data.createdAt.validate());
  await setValue(token, data.token.validate());
  await setValue(image, data.file.validate());
  await setValue(userEmail, data.email.validate());
}*/

Future<void> saveUpdateUserData(UpdateProfileData data,
    {bool login = true}) async {
  await setValue(isLogin, login);
  await setValue(userId, data.id.toString().validate());
  await setValue(accountType, data.type.validate());
  await setValue(userName, data.name.validate());
  await setValue(dob, data.dob.validate());
  await setValue(image, data.profilePhoto.validate());
  await setValue(userEmail, data.emailAddress.validate());
  await setValue(token, data.token.validate());
  await setValue(address, data.address.validate());
  await setValue(gender, data.gender.toString().validate());
}

Future<Response> buildHttpResponse(String endPoint,
    {HttpMethod method = HttpMethod.get, Map? request}) async {
  if (await isNetworkAvailable()) {
    var headers = buildHeaderTokens();
    Uri url = buildBaseUrl(endPoint);

    debugPrint('url: $url\nrequest: $request\nmethod: $method');

    Response response;

    if (method == HttpMethod.post) {
      response =
          await http.post(url, body: jsonEncode(request), headers: headers);
    } else if (method == HttpMethod.delete) {
      response = await delete(url, headers: headers);
    } else if (method == HttpMethod.put) {
      response = await put(url, body: jsonEncode(request), headers: headers);
    } else {
      response = await get(url, headers: headers);
    }

    debugPrint(
        'responseCode: ${response.statusCode}\nresponseBody ${response.body}');

    return response;
  } else {
    throw errorInternetNotAvailable;
  }
}

Future<LoginModel> login(Map request) async {
  showLoader();
  var login = LoginModel.fromJson(await (handleResponse(await buildHttpResponse(
      'login',
      request: request,
      method: HttpMethod.post))));

  await saveUserData(login.body!);
  hideLoader();
  return login;
}
Future<UpdateProfileModel> updateProfile(
    MultipartRequest multiPartRequest) async {
  var updateProfileModel = UpdateProfileModel.fromJson(
      await (handleResponse(await buildMultiPartRequest(multiPartRequest))));
  await saveUpdateUserData(updateProfileModel.body!);
  return updateProfileModel;
}
Future<AddTeamModel> createTeam(
    MultipartRequest multiPartRequest) async {
  var createTeamModel = AddTeamModel.fromJson(
      await (handleResponse(await buildMultiPartRequest(multiPartRequest))));
  return createTeamModel;
}
Future<SimpleApiModel> createPlayer(Map request) async {
  showLoader();
  var createPlayer = SimpleApiModel.fromJson(
      await (handleResponse(await buildHttpResponse(
          'create_player',
          request: request,
          method: HttpMethod.post))));
  hideLoader();
  return createPlayer;
}
Future<SimpleApiModel> createMatch(Map request) async {
  showLoader();
  var createPlayer = SimpleApiModel.fromJson(
      await (handleResponse(await buildHttpResponse(
          'create_match',
          request: request,
          method: HttpMethod.post))));
  hideLoader();
  return createPlayer;
}
Future<SimpleApiModel> tossResult(Map request) async {
  showLoader();
  var tossResult = SimpleApiModel.fromJson(
      await (handleResponse(await buildHttpResponse(
          'toss_result',
          request: request,
          method: HttpMethod.post))));
  hideLoader();
  return tossResult;
}
Future<SimpleApiModel> selectPlayers(Map request) async {
  showLoader();
  var tossResult = SimpleApiModel.fromJson(
      await (handleResponse(await buildHttpResponse(
          'select_players',
          request: request,
          method: HttpMethod.post))));
  hideLoader();
  return tossResult;
}
Future<GetTeamModel> getTeamList(String search) async {
  showLoader();
  return GetTeamModel.fromJson(await (handleResponse(
      await buildHttpResponse("team_list?search_parameters=$search",method: HttpMethod.get))));
}
Future<GetMatchModel> getMatchList() async {
  showLoader();
  return GetMatchModel.fromJson(await (handleResponse(
      await buildHttpResponse("match_list",method: HttpMethod.get))));
}
Future<GetPlayerSearchModel> getPlayerSearch(String mobileNo) async {
  showLoader();
  return GetPlayerSearchModel.fromJson(await (handleResponse(
      await buildHttpResponse("player_search?mobile_number=$mobileNo",method: HttpMethod.get))));
}
Future<GetTeamDetailModel> getTeamDetail(String teamId) async {
  showLoader();
  return GetTeamDetailModel.fromJson(await (handleResponse(
      await buildHttpResponse("team_detail/$teamId",method: HttpMethod.get))));
}

// Future<CompanyModel> getCompany(String search, String userId) async {
//   /* if(search.isEmpty){*/
//   showLoader(); /*}*/
//   return CompanyModel.fromJson(await (handleResponse(
//       await buildHttpResponse("get_company?search=$search&user_id=$userId"))));
// }




Future<SimpleApiModel> logoutUser(Map request) async {
  showLoader();
  return SimpleApiModel.fromJson(await (handleResponse(await buildHttpResponse(
      "log_out",
      request: request,
      method: HttpMethod.post))));
}

Future<SimpleApiModel> deleteAccount(Map request) async {
  showLoader();
  return SimpleApiModel.fromJson(await (handleResponse(await buildHttpResponse(
      "deleteaccount",
      request: request,
      method: HttpMethod.post))));
}
