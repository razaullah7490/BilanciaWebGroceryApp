import 'package:grocery/Application/exports.dart';

class ProductionParkRepository {
  final ProductionParkService service;
  ProductionParkRepository({
    required this.service,
  });

  Future<List<ProductionParkModel>> getProductionPark(id) async {
    try {
      var res = await service.getProductionPark(id);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> addProductionPark(Map<String, dynamic> map) async {
    try {
      var res = await service.addProductionPark(map);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
