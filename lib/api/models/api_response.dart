import 'package:quter_api/api/models/user.dart';

import 'student.dart';

class APIResponse {
  bool? success;
  String? message;
  Student? object;
  int? code;
  APIResponse({this.success, this.message, this.object});
  APIResponse.fromJson(Map<String, dynamic> json) {
    success = json['status'];
    message = json['message'];
    if (json['object'] != null) {
      object = Student.fromJson(json['object']);
    }
    if (json['code'] != null) {
      code = json['code'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = success;
    data['message'] = message;
    data['object'] = object;
    data['code'] = code;
    return data;
  }

}
