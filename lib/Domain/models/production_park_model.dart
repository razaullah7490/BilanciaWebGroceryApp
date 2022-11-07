class ProductionParkModel {
  final int id;
  final String actionType;
  final int resource;
  final double quantity;
  final double money;
  final String moneyType;
  final String dateTime;
  final int printCounter;
  final bool isForInternalUsage;
  final int creatingUser;
  ProductionParkModel({
    required this.id,
    required this.actionType,
    required this.resource,
    required this.quantity,
    required this.money,
    required this.moneyType,
    required this.dateTime,
    required this.printCounter,
    required this.isForInternalUsage,
    required this.creatingUser,
  });

  factory ProductionParkModel.fromMap(Map<String, dynamic> map) {
    return ProductionParkModel(
      id: map['id'] as int,
      actionType: map['action_type'] as String,
      resource: map['resource'] as int,
      quantity: map['quantity'] as double,
      money: map['money'] as double,
      moneyType: map['money_type'] as String,
      dateTime: map['date_time'] as String,
      printCounter: map['print_counter'] as int,
      isForInternalUsage: map['is_for_internal_usage'] as bool,
      creatingUser: map['creating_user'] as int,
    );
  }
}
