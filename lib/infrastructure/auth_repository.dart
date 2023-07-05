import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/user.dart';

const TokenUrl = "http://127.0.0.1:7000/api/token/";
const RefreshTokenUrl = "http://127.0.0.1:7000/api/token/refresh/";
const VerifyTokenUrl = "http://127.0.0.1:7000/api/token/verify/";

class AuthRepository {
  Future<bool> verify(String token) async {
    Map<String, String> headers = {'content-type': 'application/json'};
    final body = json.encode({"token": token});
    final res = await http.post(Uri.parse(VerifyTokenUrl),
        body: body, headers: headers);
    if (res.statusCode != 200 && res.statusCode != 401) {
      throw Exception(
          "Failed to verify: Invalid status code ${res.statusCode}.");
    }
    return (res.statusCode == 200);
  }

  Future<UserToken?> login(String username, String password) async {
    Map<String, String> headers = {'content-type': 'application/json'};
    final body = json.encode({
      "username": username,
      "password": password,
    });
    final res =
        await http.post(Uri.parse(TokenUrl), body: body, headers: headers);
    if (res.statusCode == 200) {
      String responseBody = utf8.decode(res.bodyBytes);
      final Map<String, dynamic> responseJson = jsonDecode(responseBody);
      return UserToken.fromJson(responseJson);
    } else {
      return null;
    }
  }

  Future<UserToken?> refreshToken(String refreshToken) async {
    Map<String, String> headers = {'content-type': 'application/json'};
    final body = json.encode({
      "refresh": refreshToken,
    });
    final res = await http.post(Uri.parse(RefreshTokenUrl),
        body: body, headers: headers);
    if (res.statusCode == 200) {
      String responseBody = utf8.decode(res.bodyBytes);
      final Map<String, dynamic> responseJson = jsonDecode(responseBody);
      return UserToken.fromJson(responseJson);
    } else {
      return null;
    }
  }
}
