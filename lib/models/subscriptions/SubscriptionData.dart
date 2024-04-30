class SubscriptionData {
  String? id1;
  String? createdAt;
  int? duration;
  bool? isActive;
  String? name;
  double? price;
  String? updatedAt;

  SubscriptionData(
      {this.id1,
      this.createdAt,
      this.duration,
      this.isActive,
      this.name,
      this.price,
      this.updatedAt});

  factory SubscriptionData.fromJson(Map<String, dynamic> json) {
    return SubscriptionData(
      id1: json['_id'],
      createdAt: json['createdAt'],
      duration: json['duration'],
      isActive: json['isActive'],
      name: json['name'],
      price: json['price'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id1;
    data['createdAt'] = createdAt;
    data['duration'] = duration;
    data['isActive'] = isActive;
    data['name'] = name;
    data['price'] = price;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
