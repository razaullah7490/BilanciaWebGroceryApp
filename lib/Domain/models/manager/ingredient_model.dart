class IngredientModel {
  int? ingrediantId;
  String? description;
  bool? isDeleted;
  IngredientModel({
    this.ingrediantId,
    this.description,
    this.isDeleted,
  });

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      ingrediantId: map['id'],
      description: map['description'],
      isDeleted: map['is_deleted'],
    );
  }
}
