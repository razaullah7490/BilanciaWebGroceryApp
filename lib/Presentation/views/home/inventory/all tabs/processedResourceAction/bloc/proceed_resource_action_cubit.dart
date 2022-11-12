import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Data/repository/manager/proceed_resource_action_repository.dart';
import '../../../../../../../Data/errors/custom_error.dart';
import '../../../../../../../Domain/models/inventory/resource_action_model.dart';
part 'proceed_resource_action_state.dart';

class ProceedResourceActionCubit extends Cubit<ProceedResourceActionState> {
  final ProceedResourceActionRepository repo;
  ProceedResourceActionCubit({
    required this.repo,
  }) : super(ProceedResourceActionState.initial());

  Future<bool> addProceedResourceAction(map) async {
    emit(state.copyWith(
      status: ProceedResourceActionEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.addProceedResourceAction(map);
      emit(state.copyWith(
        status: ProceedResourceActionEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ProceedResourceActionEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }

  Future<ResourceActionModel> getProceedResourceAction(pageNumber) async {
    emit(state.copyWith(
      status: ProceedResourceActionEnum.loading,
      error: const CustomError(error: ""),
      resourceActionModel: ResourceActionModel(),
    ));
    try {
      var res = await repo.getProceedResourceAction(pageNumber);
      emit(state.copyWith(
        status: ProceedResourceActionEnum.success,
        error: const CustomError(error: ""),
        resourceActionModel: res,
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ProceedResourceActionEnum.error,
        error: CustomError(error: e.toString()),
        resourceActionModel: ResourceActionModel(),
      ));
      return ResourceActionModel();
    }
  }

  Future<bool> deletProceedResourceAction(id) async {
    emit(state.copyWith(
      status: ProceedResourceActionEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.deletProceedResourceAction(id);
      emit(state.copyWith(
        status: ProceedResourceActionEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ProceedResourceActionEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }
}
