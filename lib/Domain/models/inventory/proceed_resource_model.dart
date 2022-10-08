class ProceedResourcesModel {
  int? id;
  List<Map>? madeWith;
  bool? isDeleted;
  String? name;
  String? ivaType;
  double? stockQuantity;
  double? stockQuantityThreshold;
  String? measureUnit;
  String? barcode;
  int? plu;
  int? shelfLife;
  double? unitSalePrice;
  double? unitPurchasePrice;
  double? tare;
  int? weightType;
  String? packagingDate;
  String? expirationDate;
  double? threshold1;
  double? threshold2;
  double? price1;
  double? price2;
  String? image;
  bool? flgConfig;
  int? traceability;
  int? traceabilityId;
  double? revenuePercentage;
  bool? isActive;
  int? ivaAliquota;
  int? ingredient;
  int? category;
  int? business;
  List<int>? assignedTo;

  ProceedResourcesModel({
    required this.id,
    required this.madeWith,
    required this.isDeleted,
    required this.name,
    required this.ivaType,
    required this.stockQuantity,
    required this.stockQuantityThreshold,
    required this.measureUnit,
    required this.barcode,
    required this.plu,
    required this.shelfLife,
    required this.unitSalePrice,
    required this.unitPurchasePrice,
    required this.tare,
    required this.weightType,
    required this.packagingDate,
    required this.expirationDate,
    required this.threshold1,
    required this.threshold2,
    required this.price1,
    required this.price2,
    required this.image,
    required this.flgConfig,
    required this.traceability,
    required this.traceabilityId,
    required this.revenuePercentage,
    required this.isActive,
    required this.ivaAliquota,
    required this.ingredient,
    required this.category,
    required this.business,
    required this.assignedTo,
  });

  ProceedResourcesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['made_with'] != null) {
      madeWith = <Map>[];
      json['made_with'].forEach((v) {
        madeWith!.add(v);
      });
    }
    isDeleted = json['is_deleted'];
    name = json['name'];
    ivaType = json['iva_type'];
    stockQuantity = json['stock_quantity'];
    stockQuantityThreshold = json['stock_quantity_threshold'];
    measureUnit = json['measure_unit'];
    barcode = json['barcode'];
    plu = json['plu'];
    shelfLife = json['shelf_life'];
    unitSalePrice = json['unit_sale_price'];
    unitPurchasePrice = json['unit_purchase_price'];
    tare = json['tare'];
    weightType = json['weight_type'] as int;
    packagingDate = json['packaging_date'];
    expirationDate = json['expiration_date'];
    threshold1 = json['threshold_1'];
    threshold2 = json['threshold_2'];
    price1 = json['price_1'];
    price2 = json['price_2'];
    image = json['image'];
    flgConfig = json['flg_config'];
    traceability = json['traceability'];
    traceabilityId = json['traceability_id'];
    revenuePercentage = json['revenue_percentage'];
    isActive = json['is_active'];
    ivaAliquota = json['iva_aliquota'];
    ingredient = json['ingredient'];
    category = json['category'];
    business = json['business'];
    assignedTo = json['assigned_to'].cast<int>();
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['made_with'] = madeWith!.map((v) => v.toJson()).toList();
  //   data['is_deleted'] = isDeleted;
  //   data['name'] = name;
  //   data['iva_type'] = ivaType;
  //   data['stock_quantity'] = stockQuantity;
  //   data['stock_quantity_threshold'] = stockQuantityThreshold;
  //   data['measure_unit'] = measureUnit;
  //   data['barcode'] = barcode;
  //   data['plu'] = plu;
  //   data['shelf_life'] = shelfLife;
  //   data['unit_sale_price'] = unitSalePrice;
  //   data['unit_purchase_price'] = unitPurchasePrice;
  //   data['tare'] = tare;
  //   data['weight_type'] = weightType;
  //   data['packaging_date'] = packagingDate;
  //   data['expiration_date'] = expirationDate;
  //   data['threshold_1'] = threshold1;
  //   data['threshold_2'] = threshold2;
  //   data['price_1'] = price1;
  //   data['price_2'] = price2;
  //   data['image'] = image;
  //   data['flg_config'] = flgConfig;
  //   data['traceability'] = traceability;
  //   data['traceability_id'] = traceabilityId;
  //   data['revenue_percentage'] = revenuePercentage;
  //   data['is_active'] = isActive;
  //   data['iva_aliquota'] = ivaAliquota;
  //   data['ingredient'] = ingredient;
  //   data['category'] = category;
  //   data['business'] = business;
  //   data['assigned_to'] = assignedTo;
  //   return data;
  // }
}

// class MadeWith {
//   int? id;
//   double? resourcePercentageUsed;
//   int? processedResource;
//   int? resource;

//   MadeWith(
//       {required this.id,
//       required this.resourcePercentageUsed,
//       required this.processedResource,
//       required this.resource});

//   MadeWith.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     resourcePercentageUsed = json['resource_percentage_used'];
//     processedResource = json['processed_resource'];
//     resource = json['resource'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['resource_percentage_used'] = resourcePercentageUsed;
//     data['processed_resource'] = processedResource;
//     data['resource'] = resource;
//     return data;
//   }
//}
