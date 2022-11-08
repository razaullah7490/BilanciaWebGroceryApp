class IngredientModel {
  final int ingrediantId;
  final String description;
  final bool isDeleted;
  IngredientModel({
    required this.ingrediantId,
    required this.description,
    required this.isDeleted,
  });

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      ingrediantId: map['id'] as int,
      description: map['description'] as String,
      isDeleted: map['is_deleted'] as bool,
    );
  }
}
