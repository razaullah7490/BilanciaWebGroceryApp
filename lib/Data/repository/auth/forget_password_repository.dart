// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grocery/Application/exports.dart';

class ForgetPasswordRepository {
  final ForgetPasswordService forgetPasswordService;
  ForgetPasswordRepository({
    required this.forgetPasswordService,
  });

  Future<bool> passwordReset(String email) async {
    try {
      var res = await forgetPasswordService.passwordReset(email);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> passwordResetConfirm(map, url) async {
    try {
      var res = await forgetPasswordService.passwordResetConfirm(map, url);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
