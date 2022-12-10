class ProcessedResourceViewModel {
  // static List<String> weightTypeList = [
  //   // "1",
  //   // "2",
  //   // "3",
  //   // "4",
  //   "Peso",
  //   "Corpo",
  //   "Peso variabile",
  //   "Corpo variabile",
  // ];
  // static List<String> traceabilityList = [
  //   // "0",
  //   // "1",
  //   // "2",
  //   "Nessuna tracciabilità",
  //   "Tracciabilità attiva",
  //   "Tracciabilità variabile",
  // ];

  static List<WeightTypeModel> weightTypeModelList = [
    WeightTypeModel(id: "1", text: "Peso"),
    WeightTypeModel(id: "2", text: "Corpo"),
    WeightTypeModel(id: "3", text: "Peso variabile"),
    WeightTypeModel(id: "4", text: "Corpo variabile"),
  ];

  static List<TraceabilityModel> traceabilityModelList = [
    TraceabilityModel(id: "0", text: "Nessuna tracciabilità"),
    TraceabilityModel(id: "1", text: "Tracciabilità attiva"),
    TraceabilityModel(id: "2", text: "Tracciabilità variabile"),
  ];
}

class TraceabilityModel {
  final String id;
  final String text;
  TraceabilityModel({
    required this.id,
    required this.text,
  });
}

class WeightTypeModel {
  final String id;
  final String text;
  WeightTypeModel({
    required this.id,
    required this.text,
  });
}
