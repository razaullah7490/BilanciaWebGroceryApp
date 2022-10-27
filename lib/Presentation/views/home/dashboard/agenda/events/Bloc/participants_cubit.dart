import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Data/repository/manager/all_users_repository.dart';
import 'package:grocery/Domain/models/manager/all_users_model.dart';
import '../../../../../../../Data/errors/custom_error.dart';
part 'participants_state.dart';

class ParticipantsCubit extends Cubit<ParticipantsState> {
  final AllUsersRepository repo;
  ParticipantsCubit({
    required this.repo,
  }) : super(ParticipantsState.initial());

  Future<List<AllUsersModel>> getAllUsers() async {
    emit(state.copyWith(
      status: ParticipantsEnum.loading,
      error: const CustomError(error: ""),
      modelList: [],
    ));

    try {
      var res = await repo.getAllUsers();
      emit(state.copyWith(
        status: ParticipantsEnum.success,
        error: const CustomError(error: ""),
        modelList: res,
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ParticipantsEnum.success,
        error: CustomError(error: e.toString()),
        modelList: [],
      ));
      return [];
    }
  }
}
