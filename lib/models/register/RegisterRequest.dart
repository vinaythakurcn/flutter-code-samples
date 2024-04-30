class RegisterRequest {
    String? deviceId;
    String? email;
    String? name;
    String? phone;
    String? token;

    RegisterRequest({this.deviceId, this.email, this.name, this.phone, this.token});

    factory RegisterRequest.fromJson(Map<String, dynamic> json) {
        return RegisterRequest(
            deviceId: json['deviceId'], 
            email: json['email'], 
            name: json['name'], 
            phone: json['phone'], 
            token: json['token'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['deviceId'] = deviceId;
        data['email'] = email;
        data['name'] = name;
        data['phone'] = phone;
        data['token'] = token;
        return data;
    }
}