import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Data/errors/custom_error.dart';
import 'package:grocery/Data/repository/auth/login_repository.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository repo;
  LoginCubit({
    required this.repo,
  }) : super(LoginState.initial());

  Future login(Map map) async {
    emit(state.copyWith(
      status: LoginEnum.loading,
      error: const CustomError(error: ""),
    ));

    try {
      await repo.login(map);
      emit(state.copyWith(
        status: LoginEnum.success,
        error: const CustomError(error: ""),
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: LoginEnum.error,
        error: CustomError(error: e.toString()),
      ));
    }
  }
}
