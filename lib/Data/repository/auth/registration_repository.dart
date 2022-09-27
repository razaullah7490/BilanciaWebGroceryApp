import 'package:grocery/Data/services/auth/registration_service.dart';
import '../../errors/custom_error.dart';

class RegistrationRepository {
  final RegisterationService registerationService;
  RegistrationRepository({
    required this.registerationService,
  });

  Future<bool> register(Map map) async {
    try {
      final res = await registerationService.register(map);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
