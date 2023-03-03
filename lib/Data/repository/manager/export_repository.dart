import 'package:grocery/Application/exports.dart';

import '../../services/manager/export_service.dart';

class ExportRepository {
  final ExportService service;
  ExportRepository({
    required this.service,
  });

  Future<bool> export() async {
    try {
      var res = await service.export();
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
