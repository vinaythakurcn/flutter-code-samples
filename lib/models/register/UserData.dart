import '../subscriptions/UserSubscription.dart';

class UserData {
  String? id1;
  String? createdAt;
  String? deviceId;
  String? email;
  bool? isActive;
  // int? joiningDate;
  String? name;
  String? phone;
  String? updatedAt;
  String? securityPasscode;
  UserSubscription? userSubscription;
  bool? freeTrialEligible;

  UserData({
    this.id1,
    this.createdAt,
    this.deviceId,
    this.email,
    this.isActive,
    // this.joiningDate,
    this.name,
    this.phone,
    this.userSubscription,
    this.updatedAt,
    this.securityPasscode,
    this.freeTrialEligible,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id1: json['_id'],
      createdAt: json['createdAt'],
      deviceId: json['deviceId'],
      email: json['email'],
      isActive: json['isActive'],
      // joiningDate: json['joiningDate'],
      name: json['name'],
      phone: json['phone'],
      freeTrialEligible: json['freeTrialEligible'],
      userSubscription:
          json['userSubscription'] != null && json['userSubscription'] is Map
              ? UserSubscription.fromJson(json['userSubscription'])
              : null,
      updatedAt: json['updatedAt'],
      securityPasscode: json['securityPasscode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id1;
    data['createdAt'] = createdAt;
    data['deviceId'] = deviceId;
    data['email'] = email;
    data['isActive'] = isActive;
    // data['joiningDate'] = joiningDate;
    data['name'] = name;
    data['phone'] = phone;
    data['updatedAt'] = updatedAt;
    data['freeTrialEligible'] = freeTrialEligible;
    data['securityPasscode'] = securityPasscode;
    if (userSubscription != null) {
      data['userSubscription'] = userSubscription!.toJson();
    }
    return data;
  }
}