import 'SubscriptionData.dart';

class AllSubscriptionsResponse {
  String? message;
  List<SubscriptionData>? data;
  bool? success;

  AllSubscriptionsResponse({this.message, this.data, this.success});

  factory AllSubscriptionsResponse.fromJson(Map<String, dynamic> json) {
    return AllSubscriptionsResponse(
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((i) => SubscriptionData.fromJson(i))
              .toList()
          : null,
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
