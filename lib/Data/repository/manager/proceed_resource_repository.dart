// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grocery/Data/services/manager/proceed_resource_service.dart';
import 'package:grocery/Domain/models/inventory/proceed_resource_model.dart';

import '../../errors/custom_error.dart';

class ProceedResourceRepository {
  final ProceedResourceService proceedResourceService;
  ProceedResourceRepository({
    required this.proceedResourceService,
  });

  Future<bool> addProceedResource(Map<String, dynamic> map) async {
    try {
      var res = await proceedResourceService.addProceedResource(map);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<List<ProceedResourcesModel>> getProceedResource() async {
    try {
      var res = await proceedResourceService.getProceedResource();
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> editProceedResource(id, map) async {
    try {
      var res = await proceedResourceService.editProceedResource(id, map);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> deleteProceedResource(id) async {
    try {
      var res = await proceedResourceService.deleteProceedResource(id);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
