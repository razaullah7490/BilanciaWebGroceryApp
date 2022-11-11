class CommandModel {
  final int id;
  final String commandType;
  final String commandData;
  final String issuingDateTime;
  final String status;
  final int microServerId;
  const CommandModel({
    required this.id,
    required this.commandType,
    required this.commandData,
    required this.issuingDateTime,
    required this.status,
    required this.microServerId,
  });

  factory CommandModel.fromMap(Map<String, dynamic> map) {
    return CommandModel(
      id: map['id'] as int,
      commandType: map['command_type'] as String,
      commandData: map['command_data'] as String,
      issuingDateTime: map['issuing_date_time'] as String,
      status: map['status'] as String,
      microServerId: map['microserver'] as int,
    );
  }
}
