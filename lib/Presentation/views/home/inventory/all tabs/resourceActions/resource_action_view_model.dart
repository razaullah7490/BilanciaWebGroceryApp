class ResourceActionViewModel {
  // static const List<String> actionTypeList = [
  //   // "purchase",
  //   // "internal_purchase",
  //   // "sale",
  //   // "internal_usage",
  //   // "waste",
  //   // "production",
  //   "Acquisto",
  //   "Acquisto a uso interno",
  //   "Vendita",
  //   "Uso interno",
  //   "Scarto",
  //   "Produzione",
  // ];

  //  static const List<String> moneyTypeList = [
  //   // "unit_price",
  //   // "total_price",
  //   "Prezzo unitario",
  //   "Prezzo totale",
  // ];

  //   static const List<String> proceedResourceActionTypeList = [
  //   // "creation",
  //   // "sale",
  //   // "internal_usage",
  //   // "waste",
  //   "creation",
  //   "Vendita",
  //   "Uso interno",
  //   "Scarto",
  // ];

  static List<ActionTypeModel> actionTypeModelList = [
    ActionTypeModel(id: "purchase", value: "Acquisto"),
    ActionTypeModel(id: "internal_purchase", value: "Acquisto a uso interno"),
    ActionTypeModel(id: "sale", value: "Vendita"),
    ActionTypeModel(id: "internal_usage", value: "Uso interno"),
    ActionTypeModel(id: "waste", value: "Scarto"),
    ActionTypeModel(id: "production", value: "Produzione"),
  ];

  static checkActionType(String title) {
    switch (title) {
      case "purchase":
        return "Acquisto";
      case "internal_purchase":
        return "Acquisto a uso interno";
      case "sale":
        return "Vendita";
      case "internal_usage":
        return "Uso interno";
      case "waste":
        return "Scarto";
      case "production":
        return "Produzione";
      case "creation":
        return "creation";
    }
  }

  static List<MoneyTypeModel> moneyTypeModelList = [
    MoneyTypeModel(id: "unit_price", value: "Prezzo unitario"),
    MoneyTypeModel(id: "total_price", value: "Prezzo totale"),
  ];

  static List<ProceedResourceActionTypeModel>
      proceedResourceActionTypeModelList = [
    ProceedResourceActionTypeModel(id: "creation", value: "creation"),
    ProceedResourceActionTypeModel(id: "sale", value: "Vendita"),
    ProceedResourceActionTypeModel(id: "internal_usage", value: "Uso interno"),
    ProceedResourceActionTypeModel(id: "waste", value: "Scarto"),
  ];
}

class ActionTypeModel {
  final String id;
  final String value;
  ActionTypeModel({
    required this.id,
    required this.value,
  });
}

class MoneyTypeModel {
  final String id;
  final String value;
  MoneyTypeModel({
    required this.id,
    required this.value,
  });
}

class ProceedResourceActionTypeModel {
  final String id;
  final String value;
  ProceedResourceActionTypeModel({
    required this.id,
    required this.value,
  });
}
