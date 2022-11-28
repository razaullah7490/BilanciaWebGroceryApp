import 'package:grocery/Application/exports.dart';

class IvaRepository {
  final IvaService ivaService;
  IvaRepository({
    required this.ivaService,
  });

  Future<List<IvaModel>> getIva() async {
    try {
      var res = await ivaService.getIva();
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> addIva(ivaValue) async {
    try {
      var res = await ivaService.addIva(ivaValue);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  // Future<bool> editIva(id, ivaValue) async {
  //   try {
  //     var res = await ivaService.editIva(id, ivaValue);
  //     return res;
  //   } catch (e) {
  //     throw CustomError(error: e.toString());
  //   }
  // }

  Future<bool> deleteIva(id) async {
    try {
      var res = await ivaService.deleteIva(id);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
