class CommandViewModel {
  static List<CommandTypeModel> commandTypeList = [
    CommandTypeModel(id: "fp", value: "Registratore Telematico"),
    CommandTypeModel(
        id: "update_from_scales", value: "Aggiorna cloud da bilance"),
    CommandTypeModel(
        id: "update_from_server", value: "Aggiorna bilance da cloud"),
    CommandTypeModel(id: "end_workday", value: "Chiusura giornaliera"),
  ];

  static checkTitle(String title) {
    switch (title) {
      case "fp":
        return "Registratore Telematico";
      case "update_from_scales":
        return "Aggiorna cloud da bilance";
      case "update_from_server":
        return "Aggiorna bilance da cloud";
      case "end_workday":
        return "Chiusura giornaliera";
    }
  }
}

class CommandTypeModel {
  final String id;
  final String value;
  CommandTypeModel({
    required this.id,
    required this.value,
  });
}
