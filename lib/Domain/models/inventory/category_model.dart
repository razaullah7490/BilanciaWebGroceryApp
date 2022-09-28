import 'dart:convert';

class CategoryModel {
  int categoryId;
  String categoryName;
  double defaultPrice;
  double minPrice;
  double maxPrice;
  double discountPrice;
  String ivaType;
  bool status;
  int aliquotaIva;
  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.defaultPrice,
    required this.minPrice,
    required this.maxPrice,
    required this.discountPrice,
    required this.ivaType,
    required this.status,
    required this.aliquotaIva,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'categoryName': categoryName,
      'defaultPrice': defaultPrice,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'discountPrice': discountPrice,
      'ivaType': ivaType,
      'status': status,
      'aliquotaIva': aliquotaIva,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['id'] as int,
      categoryName: map['name'] as String,
      defaultPrice: map['default_price'],
      minPrice: map['min_value'],
      maxPrice: map['max_value'],
      discountPrice: map['discount_value'],
      ivaType: map['iva_type'] as String,
      status: map['is_active'],
      aliquotaIva: map['iva_aliquota'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
