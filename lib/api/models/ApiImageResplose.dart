import 'package:quter_api/api/models/student_image.dart';

class APIImageResponse {
  bool? status;
  String? message;
  StudentImage? object;

  APIImageResponse({this.status, this.message, this.object});

  APIImageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    object = json['object'] != null
        ? new StudentImage.fromJson(json['object'])
        : null;
  }
}

class Object {
  String? image;
  int? studentId;
  int? id;
  String? imageUrl;

  Object({this.image, this.studentId, this.id, this.imageUrl});

  Object.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    studentId = json['student_id'];
    id = json['id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['student_id'] = this.studentId;
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
