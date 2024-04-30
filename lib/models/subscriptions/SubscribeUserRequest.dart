class SubscribeUserRequest {
  String? subscriptionId;
  String? paymentId;
  String? coupon;

  SubscribeUserRequest({this.subscriptionId, this.paymentId, this.coupon});

  factory SubscribeUserRequest.fromJson(Map<String, dynamic> json) {
    return SubscribeUserRequest(
      subscriptionId: json['subscriptionId'],
      paymentId: json['paymentId'],
      coupon: json['coupon'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subscriptionId'] = subscriptionId;
    data['paymentId'] = paymentId;
    data['coupon'] = coupon;
    return data;
  }
}