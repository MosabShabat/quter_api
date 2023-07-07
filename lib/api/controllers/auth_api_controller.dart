import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:quter_api/api/controllers/api_helper.dart';
import 'package:quter_api/api/models/api_response.dart';
import '../api_settings.dart';
import '../models/student.dart';

class AuthApiController with ApiHelper {
  Future<APIResponse> register({required Student student}) async {
    Uri uri = Uri.parse(ApiSettings.register);
    http.post(uri);
    var data = {
      'email': student.email,
      'password': student.password,
      'full_name': student.fullName,
      'gender': student.gender
    };
    http.Response response = await http.post(uri, body: data);
    return APIResponse.fromJson(jsonDecode(response.body));
  }

  Future<APIResponse> login({email, password}) async {
    Uri uri = Uri.parse(ApiSettings.login);
    http.post(uri);
    var data = {
      'email': email,
      'password': password,
    };
    http.Response response = await http.post(uri, body: data);
    return APIResponse.fromJson(jsonDecode(response.body));
  }

  Future<APIResponse> resetPassword(
      {required String email,
      required String code,
      required String password}) async {
    Uri uri = Uri.parse(ApiSettings.resetPassword);
    http.post(uri);
    var data = {
      'email': email,
      'code': code,
      'password': password,
      'password_confirmation': password,
    };
    // if (response.statusCode == 200 || response.statusCode == 400) {
    //   var jsonResponse = jsonDecode(response.body);
    // }
    http.Response response = await http.post(uri, body: data);
    return APIResponse.fromJson(jsonDecode(response.body));
  }

  Future<APIResponse> forgotPassword({required String email}) async {
    Uri uri = Uri.parse(ApiSettings.forgetPassword);
    var response = await http.post(uri, body: {'email': email});
    return APIResponse.fromJson(jsonDecode(response.body));
  }

  Future<APIResponse> logout() async {
    Uri uri = Uri.parse(ApiSettings.logout);
    var response = await http.get(uri, headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 401) {
      await GetStorage().erase();
      var jsonResponse = jsonDecode(response.body);
      return APIResponse(
          message: response.statusCode == 200
              ? jsonResponse['message']
              : 'Logged out successfully',
          success: true);
    }
    return failedResponse;
  }
}
