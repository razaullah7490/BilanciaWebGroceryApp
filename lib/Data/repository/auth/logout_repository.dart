import 'package:grocery/Data/services/auth/logout_service.dart';
import '../../errors/custom_error.dart';

class LogoutRepository {
  final LogoutService logoutService;
  LogoutRepository({
    required this.logoutService,
  });

  Future<bool> logout() async {
    try {
      var res = await logoutService.logout();
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
