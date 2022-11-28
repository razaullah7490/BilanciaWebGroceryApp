import 'package:grocery/Application/exports.dart';
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
