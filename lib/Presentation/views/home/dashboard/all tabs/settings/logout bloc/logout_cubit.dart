import 'package:grocery/Application/exports.dart';
part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutRepository repo;
  LogoutCubit({
    required this.repo,
  }) : super(LogoutState.initial());

  Future<bool> logout() async {
    emit(state.copyWith(
      status: LogoutEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.logout();
      emit(state.copyWith(
        status: LogoutEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: LogoutEnum.error,
        error: CustomError(error: e.toString()),
      ));
    }
    return false;
  }
}
