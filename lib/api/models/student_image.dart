class StudentImage {
  late int id;
  late String image;
  late String studentId;
  late String imageUrl;

  StudentImage();

  StudentImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    if (json['student_id'] is int?) {
      studentId = json['student_id'].toString();
    }
    imageUrl = json['image_url'];
  }
}
