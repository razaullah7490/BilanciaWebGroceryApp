import 'package:grocery/Application/exports.dart';

class ResourcesRepository {
  final ResourcesService resourcesService;
  ResourcesRepository({
    required this.resourcesService,
  });

  Future<bool> addResource(map) async {
    try {
      var res = await resourcesService.addResource(map);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<List<ResourcesModel>> getResource() async {
    try {
      var res = await resourcesService.getResource();
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> editResource(id, map) async {
    try {
      var res = await resourcesService.editResource(id, map);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> deleteResource(id) async {
    try {
      var res = await resourcesService.deleteResource(id);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
