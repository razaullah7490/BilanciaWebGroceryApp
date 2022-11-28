// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grocery/Application/exports.dart';

class ProceedResourceActionRepository {
  final ProceedResourceActionService proceedResourceActionService;
  ProceedResourceActionRepository({
    required this.proceedResourceActionService,
  });

  Future<bool> addProceedResourceAction(map) async {
    try {
      var res =
          await proceedResourceActionService.addProceedResourceAction(map);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<ResourceActionModel> getProceedResourceAction(pageNumber) async {
    try {
      var res = await proceedResourceActionService
          .getProceedResourceAction(pageNumber);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> deletProceedResourceAction(id) async {
    try {
      var res =
          await proceedResourceActionService.deleteProceedResourceAction(id);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
