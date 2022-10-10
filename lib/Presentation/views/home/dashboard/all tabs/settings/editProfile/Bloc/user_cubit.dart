import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Data/repository/auth/user_repository.dart';
import 'package:grocery/Domain/models/auth/user_model.dart';
import '../../../../../../../../Data/errors/custom_error.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository repo;
  UserCubit({
    required this.repo,
  }) : super(UserState.initial());

  Future<List<UserModel>> getUser() async {
    emit(state.copyWith(
      status: UserEnum.loading,
      error: const CustomError(error: ""),
      userModel: [],
    ));

    try {
      var res = await repo.getUser();
      emit(state.copyWith(
        status: UserEnum.success,
        error: const CustomError(error: ""),
        userModel: res,
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: UserEnum.error,
        error: CustomError(error: e.toString()),
        userModel: [],
      ));
      log("Cubit error $e");
      return [];
    }
  }

  Future<bool> editUser(map) async {
    emit(state.copyWith(
      status: UserEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.editUser(map);
      emit(state.copyWith(
        status: UserEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: UserEnum.error,
        error: CustomError(error: e.toString()),
      ));
    }
    return false;
  }
}
