import 'package:grocery/Application/exports.dart';
part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordRepository repo;
  ForgetPasswordCubit({
    required this.repo,
  }) : super(ForgetPasswordState.initial());

  Future<bool> passwordReset(String email) async {
    emit(state.copyWith(
      status: ForgetPasswordEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.passwordReset(email);
      emit(state.copyWith(
        status: ForgetPasswordEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ForgetPasswordEnum.error,
        error: CustomError(error: e.toString()),
      ));
    }
    return false;
  }

  Future<bool> passwordResetConfirm(map, url) async {
    emit(state.copyWith(
      status: ForgetPasswordEnum.loading,
      error: const CustomError(error: ""),
    ));

    try {
      var res = await repo.passwordResetConfirm(map, url);
      emit(state.copyWith(
        status: ForgetPasswordEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ForgetPasswordEnum.error,
        error: CustomError(error: e.toString()),
      ));
    }
    return false;
  }
}
