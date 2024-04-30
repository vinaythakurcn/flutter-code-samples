import 'UserData.dart';

class UserProfileResponse {
  String? message;
  UserData? data;
  bool? success;

  UserProfileResponse({this.message, this.data, this.success});

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      message: json['message'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}