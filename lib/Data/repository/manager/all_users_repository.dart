import 'package:grocery/Data/services/manager/all_users_service.dart';
import 'package:grocery/Domain/models/manager/all_users_model.dart';
import '../../errors/custom_error.dart';

class AllUsersRepository {
  final AllUsersService allUsersService;
  AllUsersRepository({
    required this.allUsersService,
  });

  Future<List<AllUsersModel>> getAllUsers() async {
    try {
      var res = await allUsersService.getAllUsers();
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
