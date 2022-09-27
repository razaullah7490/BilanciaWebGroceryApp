class ResourceActionModel {
  int resourceActionId;
  String resourceActionName;
  double quantity;
  double money;
  double priceCounter;
  String resource;
  bool isForInternalUsage;
  ResourceActionModel({
    required this.resourceActionId,
    required this.resourceActionName,
    required this.quantity,
    required this.money,
    required this.priceCounter,
    required this.resource,
    required this.isForInternalUsage,
  });
}
