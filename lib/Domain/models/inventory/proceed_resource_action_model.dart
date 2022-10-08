class ProcessedResourceActionModel {
  int processedresourceActionId;
  String processedresourceActionName;
  double quantity;
  double money;
  String moneyType;
  int priceCounter;
  int resource;
  bool isForInternalUsage;
  ProcessedResourceActionModel({
    required this.processedresourceActionId,
    required this.processedresourceActionName,
    required this.quantity,
    required this.money,
    required this.moneyType,
    required this.priceCounter,
    required this.resource,
    required this.isForInternalUsage,
  });

  factory ProcessedResourceActionModel.fromMap(Map<String, dynamic> map) {
    return ProcessedResourceActionModel(
      processedresourceActionId: map['id'] as int,
      processedresourceActionName: map['action_type'] as String,
      quantity: map['quantity'] as double,
      money: map['money'] as double,
      moneyType: map['money_type'] as String,
      priceCounter: map['print_counter'] as int,
      resource: map['resource'] as int,
      isForInternalUsage: map['is_for_internal_usage'] as bool,
    );
  }
}
