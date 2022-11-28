import 'package:grocery/Application/exports.dart';

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
