// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grocery/Data/services/auth/forget_password_service.dart';
import '../../errors/custom_error.dart';

class ForgetPasswordRepository {
  final ForgetPasswordService forgetPasswordService;
  ForgetPasswordRepository({
    required this.forgetPasswordService,
  });

  Future<bool> passwordReset(email) async {
    try {
      var res = await forgetPasswordService.passwordReset(email);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
