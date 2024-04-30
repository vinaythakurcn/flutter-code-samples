import 'UserData.dart';

class RegisterData {
    String? token;
    UserData? user;

    RegisterData({this.token, this.user});

    factory RegisterData.fromJson(Map<String, dynamic> json) {
        return RegisterData(
            token: json['token'],
            user: json['user'] != null ? UserData.fromJson(json['user']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['token'] = token;
        if (user != null) {
            data['user'] = user!.toJson();
        }
        return data;
    }
}