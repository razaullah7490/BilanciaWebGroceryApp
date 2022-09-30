// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResourceActionModel {
  int resourceActionId;
  String resourceActionName;
  double quantity;
  double money;
  String moneyType;
  int priceCounter;
  int resource;
  bool isForInternalUsage;
  ResourceActionModel({
    required this.resourceActionId,
    required this.resourceActionName,
    required this.quantity,
    required this.money,
    required this.moneyType,
    required this.priceCounter,
    required this.resource,
    required this.isForInternalUsage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'resourceActionId': resourceActionId,
      'resourceActionName': resourceActionName,
      'quantity': quantity,
      'money': money,
      'moneyType': moneyType,
      'priceCounter': priceCounter,
      'resource': resource,
      'isForInternalUsage': isForInternalUsage,
    };
  }

  factory ResourceActionModel.fromMap(Map<String, dynamic> map) {
    return ResourceActionModel(
      resourceActionId: map['id'] as int,
      resourceActionName: map['action_type'] as String,
      quantity: map['quantity'] as double,
      money: map['money'] as double,
      moneyType: map['money_type'] as String,
      priceCounter: map['print_counter'] as int,
      resource: map['resource'] as int,
      isForInternalUsage: map['is_for_internal_usage'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResourceActionModel.fromJson(String source) =>
      ResourceActionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
