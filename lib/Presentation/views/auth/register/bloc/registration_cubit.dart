import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Data/errors/custom_error.dart';
import 'package:grocery/Data/repository/auth/registration_repository.dart';
part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final RegistrationRepository repo;
  RegistrationCubit({
    required this.repo,
  }) : super(RegistrationState.initial());

  Future registration(Map map) async {
    emit(state.copyWith(
      status: RegisterEnum.loading,
      error: const CustomError(error: ""),
    ));

    try {
      await repo.register(map);
      emit(state.copyWith(
        status: RegisterEnum.success,
        error: const CustomError(error: ""),
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: RegisterEnum.error,
        error: CustomError(error: e.toString()),
      ));
    }
  }
}
