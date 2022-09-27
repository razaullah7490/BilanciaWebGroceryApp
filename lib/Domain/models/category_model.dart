class CategoryModel {
  int categoryId;
  String categoryName;
  int defaultPrice;
  int minPrice;
  int maxPrice;
  String ivaType;
  String status;
  int aliquotaIva;
  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.defaultPrice,
    required this.minPrice,
    required this.maxPrice,
    required this.ivaType,
    required this.status,
    required this.aliquotaIva,
  });
}
