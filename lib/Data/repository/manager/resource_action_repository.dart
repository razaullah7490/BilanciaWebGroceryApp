// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grocery/Data/services/manager/resource_action_service.dart';
import 'package:grocery/Domain/models/inventory/resource_action_model.dart';

import '../../errors/custom_error.dart';

class ResourceActionRepository {
  final ResourceActionService resourceActionService;
  ResourceActionRepository({
    required this.resourceActionService,
  });

  Future<bool> addResourceAction(map) async {
    try {
      var res = await resourceActionService.addResourceAction(map);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<List<ResourceActionModel>> getResoruceAction() async {
    try {
      var res = await resourceActionService.getResoruceAction();
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> deleteResourceAction(id) async {
    try {
      var res = await resourceActionService.deleteResourceAction(id);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
