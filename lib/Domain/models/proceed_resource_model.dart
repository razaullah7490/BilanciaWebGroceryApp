class ProceedResourcesModel {
  int resourceId;
  String resourceName;
  int aliquotaIva;
  String ivaType;
  double stockQuantity;
  double stockQuantityThreshold;
  String measureUnit;
  String barCode;
  double plu;
  double shelfLife;
  double unitSalePrice;
  double revenuePercentage;
  String category;
  String status;
  double tare;
  int weightType;
  int ingrediant;
  String packagingDate;
  String expirationDate;
  ProceedResourcesModel({
    required this.resourceId,
    required this.resourceName,
    required this.aliquotaIva,
    required this.ivaType,
    required this.stockQuantity,
    required this.stockQuantityThreshold,
    required this.measureUnit,
    required this.barCode,
    required this.plu,
    required this.shelfLife,
    required this.unitSalePrice,
    required this.revenuePercentage,
    required this.category,
    required this.status,
    required this.tare,
    required this.weightType,
    required this.ingrediant,
    required this.expirationDate,
    required this.packagingDate,
  });
}
