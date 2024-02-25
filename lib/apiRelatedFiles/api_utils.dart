import 'dart:convert';
import 'dart:io';
import 'package:crick_team/utils/data_type_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../loginSignupRelatedFiles/LoginScreen.dart';
import '../main.dart';
import '../utils/common.dart';
import '../utils/constant.dart';
import '../utils/shared_pref.dart';
import 'network_available.dart';

Map<String, String> buildHeaderTokens() {
  Map<String, String> header = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    HttpHeaders.cacheControlHeader: 'no-cache',
    HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
    'Access-Control-Allow-Headers': '*',
    'Access-Control-Allow-Origin': '*',
    // 'security_key': 'WXVtaVRhbGsgQXBwIENyZWF0ZWQgQnkgQ2hhbmRhbg',
    'authorization': getStringAsync(token),
  };

  if (getBoolAsync(isLogin)) {
    header.putIfAbsent(HttpHeaders.authorizationHeader,
        () => getStringAsync(token));
  }
  debugPrint("header: ${jsonEncode(header)}");
  return header;
}

Uri buildBaseUrl(String endPoint) {
  Uri url = Uri.parse(endPoint);
  if (!endPoint.startsWith('http')) url = Uri.parse('$mBaseUrl$endPoint');
  return url;
}

Future<http.Response> buildHttpResponse(String endPoint,
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

Future handleResponse(Response response) async {
  if (!await isNetworkAvailable()) {
    hideLoader();
    throw errorInternetNotAvailable;
  } else if (response.statusCode.isSuccessful()) {
    return jsonDecode(response.body);
  } else if (response.statusCode == 401) {
    hideLoader();
    Navigator.pushAndRemoveUntil(
        getContext,
        MaterialPageRoute(
          builder: (getContext) =>
          const LoginScreen(),
        ),
            (route) => false);
    var body = jsonDecode(response.body);
    // toast(body['message']);
  }else if(response.statusCode==400){
    return jsonDecode(response.body);
  } else {
    hideLoader();
    try {
      var body = jsonDecode(response.body);
      // toast(body['message']);
      throw parseHtmlString(body['message']);
    } on Exception {
      throw errorSomethingWentWrong;
    }
  }
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

Future<MultipartRequest> getMultiPartRequest(String endPoint,
    {String method = 'POST', String? baseUrl}) async {
  String url = baseUrl ?? buildBaseUrl(endPoint).toString();
  return MultipartRequest(method, Uri.parse(url));
}

Future<void> sendMultiPartRequest(MultipartRequest multiPartRequest,
    {Function(dynamic)? onSuccess, Function(dynamic)? onError}) async {
  debugPrint(
      'url: ${multiPartRequest.url}\nheaders: ${multiPartRequest.headers}\nrequestFields: ${multiPartRequest.fields}');
  http.Response response =
      await http.Response.fromStream(await multiPartRequest.send());
  debugPrint(
      'url: ${multiPartRequest.url}\nheaders: ${multiPartRequest.headers}\nrequestFields: ${multiPartRequest.fields}\nresponseCode: ${response.statusCode}\nresponseBody ${response.body}');

  if (response.statusCode.isSuccessful()) {
    onSuccess?.call(response.body);
  } else {
    onError?.call(errorSomethingWentWrong);
  }
}

//region Common
enum HttpMethod { get, post, delete, put }
//endregion
