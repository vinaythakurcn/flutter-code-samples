import 'SubscriptionData.dart';

class UserSubscription {
  String? id1;
  String? createdAt;
  bool? isCancelled;
  bool? isExpired;
  int? nextBillingDate;
  int? startingDate;
  dynamic subscriptionId;
  String? updatedAt;
  String? userId;

  UserSubscription(
      {this.id1,
      this.createdAt,
      this.isCancelled,
      this.isExpired,
      this.nextBillingDate,
      this.startingDate,
      this.subscriptionId,
      this.updatedAt,
      this.userId});

  factory UserSubscription.fromJson(Map<String, dynamic> json) {
    return UserSubscription(
      id1: json['_id'],
      createdAt: json['createdAt'],
      isCancelled: json['isCancelled'],
      isExpired: json['isExpired'],
      nextBillingDate: json['nextBillingDate'],
      startingDate: json['startingDate'],
      updatedAt: json['updatedAt'],
      userId: json['userId'],
      subscriptionId: json['subscriptionId'] != null
          ? json['subscriptionId'] is String
              ? json['subscriptionId']
              : SubscriptionData.fromJson(json['subscriptionId'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id1;
    data['createdAt'] = createdAt;
    data['isCancelled'] = isCancelled;
    data['isExpired'] = isExpired;
    data['nextBillingDate'] = nextBillingDate;
    data['startingDate'] = startingDate;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    if (subscriptionId != null) {
      data['subscriptionId'] = (data['subscriptionId'] is String)
          ? subscriptionId
          : subscriptionId!.toJson();
    }
    return data;
  }
}
