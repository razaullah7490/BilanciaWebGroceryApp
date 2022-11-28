// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grocery/Application/exports.dart';

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

  Future<ResourceActionModel> getResoruceAction(pageNumber) async {
    try {
      var res = await resourceActionService.getResoruceAction(pageNumber);
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
