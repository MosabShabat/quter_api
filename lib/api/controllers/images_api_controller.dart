import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quter_api/api/api_settings.dart';
import 'package:quter_api/api/controllers/api_helper.dart';
import 'package:quter_api/api/models/api_response.dart';
import 'package:quter_api/api/models/student_image.dart';

class ImagesApiController with ApiHelper {
  Future<List<StudentImage>> getStudentImage() async {
    List<StudentImage> l = [];
    Uri uri = Uri.parse(ApiSettings.images);
    // print(ApiSettings.images);
    var response = await http.get(uri, headers: headers);
    print(response.statusCode);
    //  print(headers);
    if (response.statusCode == 200) {
      var array = jsonDecode(response.body);
      array['data'].forEach((e) => l.add(StudentImage.fromJson(e)));
      return l;
    }
    return [];
  }

  Future<APIResponse> deleteImages({required int id}) async {
    Uri uri = Uri.parse(ApiSettings.images.replaceFirst('{id}', id.toString()));
    var response = await http.delete(uri, headers: headers);
    // if (response.statusCode == 200) {
    //   var jsonResponse = jsonDecode(response.body);
    //  print(jsonResponse.message);
    // Get.snackbar("message", jsonResponse.message!,
    //     backgroundColor: jsonResponse.success! ? Colors.green : Colors.red,
    //     colorText: Colors.white);
    // }
    return failedResponse;
  }

  Future<APIResponse?> uploadImage(String path) async {
    Uri URI = Uri.parse("http://demo-api.mr-dev.tech/api/student/images");
    http.MultipartRequest request = http.MultipartRequest("POST",URI);
    request.files.add(await http.MultipartFile.fromPath("image",path));
    request.headers[headers];
    // request.fields[''] = value;
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if(response.statusCode == 201 || response.statusCode == 400){
      var body = await response.stream.transform(utf8.decoder).first;
      var jsonResponse = jsonDecode(body);
      return APIResponse.fromJson(jsonResponse);
    }
    return null;
  }
}
