import 'package:grocery/Application/exports.dart';

class DeleteRepo {

  Future<bool> deleteAccount(id) async {
    try {
      var res = await UserServices().deleteAccount(id);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }


}
