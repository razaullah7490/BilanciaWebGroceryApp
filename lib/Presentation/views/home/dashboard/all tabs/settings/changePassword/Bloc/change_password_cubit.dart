import 'package:grocery/Application/exports.dart';
part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordRepository repo;
  ChangePasswordCubit({
    required this.repo,
  }) : super(ChangePasswordState.initial());

  Future<bool> changePassword(map) async {
    emit(state.copyWith(
      status: ChangePasswordEnum.loading,
      error: const CustomError(error: ""),
    ));

    try {
      var res = await repo.changePassword(map);
      emit(state.copyWith(
        status: ChangePasswordEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ChangePasswordEnum.error,
        error: CustomError(error: e.toString()),
      ));
    }
    return false;
  }
}
