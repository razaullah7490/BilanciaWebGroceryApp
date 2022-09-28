class ProcessedResourceActionModel {
  int processedresourceActionId;
  String processedresourceActionName;
  double quantity;
  double money;
  double priceCounter;
  String resource;
  bool isForInternalUsage;
  ProcessedResourceActionModel({
    required this.processedresourceActionId,
    required this.processedresourceActionName,
    required this.quantity,
    required this.money,
    required this.priceCounter,
    required this.resource,
    required this.isForInternalUsage,
  });
}
