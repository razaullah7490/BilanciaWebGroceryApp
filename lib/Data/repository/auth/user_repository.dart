import 'package:grocery/Application/exports.dart';

class UserRepository {
  final UserServices userServices;
  UserRepository({
    required this.userServices,
  });

  Future<List<UserModel>> getUser() async {
    try {
      var res = await userServices.getUser();
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> editUser(map) async {
    try {
      var res = await userServices.editUser(map);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
