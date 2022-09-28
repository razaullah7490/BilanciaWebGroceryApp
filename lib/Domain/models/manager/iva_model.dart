// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class IvaModel {
  final int id;
  final bool isDeleted;
  final bool isBackendChanged;
  final double value;
  final int businessId;
  const IvaModel({
    required this.id,
    required this.isDeleted,
    required this.isBackendChanged,
    required this.value,
    required this.businessId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isDeleted': isDeleted,
      'isBackendChanged': isBackendChanged,
      'value': value,
      'businessId': businessId,
    };
  }

  factory IvaModel.fromMap(Map<String, dynamic> map) {
    return IvaModel(
      id: map['id'] as int,
      isDeleted: map['is_deleted'] as bool,
      isBackendChanged: map['is_backend_changed'] as bool,
      value: map['value'] as double,
      businessId: map['business'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory IvaModel.fromJson(String source) =>
      IvaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
