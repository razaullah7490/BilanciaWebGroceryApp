import 'package:grocery/Application/exports.dart';

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
