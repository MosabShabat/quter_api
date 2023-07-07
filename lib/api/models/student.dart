class Student {
  int? id;
  String? fullName;
  String? email;
  String? gender;
  String? verificationCode;
  String? fcmToken;
  String? token;
  String? refreshToken;
  bool? isActive;
  String? password;

  Student(
      {this.id,
      this.fullName,
      this.email,
      this.gender,
      this.verificationCode,
      this.fcmToken,
      this.token,
      this.refreshToken,
      this.isActive});
  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    gender = json['gender'];
    verificationCode = json['verification_code'];
    fcmToken = json['fcm_token'];
    token = json['token'];
    refreshToken = json['refresh_token'];
    isActive = json['is_active'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['verification_code'] = this.verificationCode;
    data['fcm_token'] = this.fcmToken;
    data['token'] = this.token;
    data['refresh_token'] = this.refreshToken;
    data['is_active'] = this.isActive;
    return data;
  }
}
