import 'dart:convert';

class ResourcesModel {
  int resourceId;
  String resourceName;
  int aliquotaIva;
  String ivaType;
  double stockQuantity;
  double stockQuantityThreshold;
  String measureUnit;
  String barCode;
  int plu;
  int shelfLife;
  double unitSalePrice;
  double revenuePercentage;
  int category;
  double tare;
  int weightType;
  int ingrediant;
  String packagingDate;
  String expirationDate;
  bool isDeleted;
  bool status;
  double unitPurchasePrice;
  String image;
  double threshold1;
  double threshold2;
  double price1;
  double price2;
  bool flgConfig;
  int traceability;
  int traceabilityId;

  ResourcesModel({
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
    required this.tare,
    required this.weightType,
    required this.ingrediant,
    required this.expirationDate,
    required this.packagingDate,
    required this.isDeleted,
    required this.status,
    required this.unitPurchasePrice,
    required this.image,
    required this.threshold1,
    required this.threshold2,
    required this.price1,
    required this.price2,
    required this.flgConfig,
    required this.traceability,
    required this.traceabilityId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'resourceId': resourceId,
      'resourceName': resourceName,
      'aliquotaIva': aliquotaIva,
      'ivaType': ivaType,
      'stockQuantity': stockQuantity,
      'stockQuantityThreshold': stockQuantityThreshold,
      'measureUnit': measureUnit,
      'barCode': barCode,
      'plu': plu,
      'shelfLife': shelfLife,
      'unitSalePrice': unitSalePrice,
      'revenuePercentage': revenuePercentage,
      'category': category,
      'tare': tare,
      'weightType': weightType,
      'ingrediant': ingrediant,
      'packagingDate': packagingDate,
      'expirationDate': expirationDate,
    };
  }

  factory ResourcesModel.fromMap(Map<String, dynamic> map) {
    return ResourcesModel(
      resourceId: map['id'] as int,
      resourceName: map['name'] as String,
      aliquotaIva: map['iva_aliquota'],
      ivaType: map['iva_type'] as String,
      stockQuantity: map['stock_quantity'] as double,
      stockQuantityThreshold: map['stock_quantity_threshold'] as double,
      measureUnit: map['measure_unit'] as String,
      barCode: map['barcode'] as String,
      plu: map['plu'] ?? 0,
      shelfLife: map['shelf_life'] as int,
      unitSalePrice: map['unit_sale_price'] as double,
      revenuePercentage: map['revenue_percentage'] as double,
      category: map['category'] as int,
      tare: map['tare'] as double,
      weightType: map['weight_type'] as int,
      ingrediant: map['ingredient'] ?? 0,
      packagingDate: map['packaging_date'] ?? "",
      expirationDate: map['expiration_date'] ?? "",
      isDeleted: map['is_deleted'],
      status: map['is_active'] ?? false,
      unitPurchasePrice: map['unit_purchase_price'] ?? 0.0,
      image: map["image"] ?? "",
      threshold1: map["threshold_1"],
      threshold2: map["threshold_2"],
      price1: map["price_1"],
      price2: map["price_2"],
      flgConfig: map["flg_config"],
      traceability: map["traceability"],
      traceabilityId: map["traceability_id"],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResourcesModel.fromJson(String source) =>
      ResourcesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
