import 'RegisterData.dart';

class RegisterResponse {
    String? message;
    RegisterData? data;
    bool? success;

    RegisterResponse({this.message, this.data, this.success});

    factory RegisterResponse.fromJson(Map<String, dynamic> json) {
        return RegisterResponse(
            message: json['message'],
            data: json['data'] != null ? RegisterData.fromJson(json['data']) : null,
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