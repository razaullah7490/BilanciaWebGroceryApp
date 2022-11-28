import 'package:grocery/Application/exports.dart';

class LoginRepository {
  final LoginService loginService;
  LoginRepository({
    required this.loginService,
  });

  Future<bool> login(Map map) async {
    try {
      final res = await loginService.login(map);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
