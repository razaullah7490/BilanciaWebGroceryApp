// class ResourceActionModel {
//   int resourceActionId;
//   String resourceActionName;
//   double quantity;
//   double money;
//   String moneyType;
//   int priceCounter;
//   int resource;
//   bool isForInternalUsage;
//   ResourceActionModel({
//     required this.resourceActionId,
//     required this.resourceActionName,
//     required this.quantity,
//     required this.money,
//     required this.moneyType,
//     required this.priceCounter,
//     required this.resource,
//     required this.isForInternalUsage,
//   });
//   factory ResourceActionModel.fromMap(Map<String, dynamic> map) {
//     return ResourceActionModel(
//       resourceActionId: map['id'] as int,
//       resourceActionName: map['action_type'] as String,
//       quantity: map['quantity'] as double,
//       money: map['money'] as double,
//       moneyType: map['money_type'] as String,
//       priceCounter: map['print_counter'] as int,
//       resource: map['resource'] as int,
//       isForInternalUsage: map['is_for_internal_usage'] as bool,
//     );
//   }
// }

class ResourceActionModel {
  Links? links;
  int? count;
  int? totalPages;
  List<Results>? results;

  ResourceActionModel({this.links, this.count, this.totalPages, this.results});

  ResourceActionModel.fromJson(Map<String, dynamic> json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    count = json['count'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }
}

class Links {
  String? next;
  String? previous;

  Links({this.next, this.previous});

  Links.fromJson(Map<String, dynamic> json) {
    next = json['next'];
    previous = json['previous'];
  }
}

class Results {
  int? resourceActionId;
  String? resourceActionName;
  double? quantity;
  double? money;
  String? moneyType;
  int? priceCounter;
  int? resource;
  bool? isForInternalUsage;
  String? dateTime;

  Results({
    this.resourceActionId,
    this.resourceActionName,
    this.quantity,
    this.money,
    this.moneyType,
    this.priceCounter,
    this.resource,
    this.isForInternalUsage,
    this.dateTime,
  });

  Results.fromJson(Map<String, dynamic> json) {
    resourceActionId = json['id'];
    resourceActionName = json['action_type'];
    resource = json['resource'];
    quantity = json['quantity'];
    money = json['money'];
    moneyType = json['money_type'];
    dateTime = json['date_time'];
    priceCounter = json['print_counter'];
    isForInternalUsage = json['is_for_internal_usage'];
  }
}
