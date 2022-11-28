// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grocery/Application/exports.dart';

class ChangePasswordRepository {
  final ChangePasswordService changePasswordService;
  ChangePasswordRepository({
    required this.changePasswordService,
  });
  Future<bool> changePassword(map) async {
    try {
      var res = await changePasswordService.changePassword(map);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
