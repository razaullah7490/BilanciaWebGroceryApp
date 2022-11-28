// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grocery/Application/exports.dart';

class CommandRepository {
  final CommandService service;
  CommandRepository({
    required this.service,
  });

  Future<List<CommandModel>> getCommands() async {
    try {
      var res = await service.getCommands();
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> addCommands(commandType) async {
    try {
      var res = await service.addCommands(commandType);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> deleteCommand(commandTypeId) async {
    try {
      var res = await service.deleteCommand(commandTypeId);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
