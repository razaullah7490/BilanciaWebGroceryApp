import 'dart:convert';

class IngredientModel {
  final int ingrediantId;
  final String description;
  IngredientModel({
    required this.ingrediantId,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ingrediantId': ingrediantId,
      'description': description,
    };
  }

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      ingrediantId: map['id'] as int,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory IngredientModel.fromJson(String source) =>
      IngredientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
