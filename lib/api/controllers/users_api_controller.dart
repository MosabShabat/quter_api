import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quter_api/api/models/user.dart';

import '../api_settings.dart';

class UserApiController {
  Future<List<User>?> read() async {
    Uri uri = Uri.parse(ApiSettings.users);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      return jsonArray.map((jsonObject) => User.fromJson(jsonObject)).toList();
    }
    return [];
  }
}
