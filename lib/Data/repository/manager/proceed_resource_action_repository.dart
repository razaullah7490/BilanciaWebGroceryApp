// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../Domain/models/inventory/proceed_resource_action_model.dart';
import '../../errors/custom_error.dart';
import '../../services/manager/proceed_resource_action_service.dart';

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

  Future<List<ProcessedResourceActionModel>> getProceedResourceAction() async {
    try {
      var res = await proceedResourceActionService.getProceedResourceAction();
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
