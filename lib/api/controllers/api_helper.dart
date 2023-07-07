import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:quter_api/api/models/api_response.dart';

class ApiHelper {
  APIResponse get failedResponse =>
      APIResponse(message: 'Something went wrong, try again', success: false);
  Map<String, String> get headers {
    return {
      HttpHeaders.authorizationHeader: "Bearer ${GetStorage().read('token')}",
      HttpHeaders.acceptHeader: 'application/json',
    };
  }
}
