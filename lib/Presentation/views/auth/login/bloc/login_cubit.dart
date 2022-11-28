import 'package:grocery/Application/exports.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository repo;
  LoginCubit({
    required this.repo,
  }) : super(LoginState.initial());

  Future<bool> login(Map map) async {
    emit(state.copyWith(
      status: LoginEnum.loading,
      error: const CustomError(error: ""),
    ));

    try {
      var res = await repo.login(map);
      emit(state.copyWith(
        status: LoginEnum.success,
        error: const CustomError(error: ""),
      ));
      return true;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: LoginEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }

  Future<bool> loginAgain(map) async {
    try {
      var login = await repo.login(map);
      return login;
    } catch (e) {
      return false;
    }
  }
}
