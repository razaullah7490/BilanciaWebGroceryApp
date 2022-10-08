import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Data/repository/manager/proceed_resource_repository.dart';

import '../../../../../../../Data/errors/custom_error.dart';
import '../../../../../../../Domain/models/inventory/proceed_resource_model.dart';
part 'proceed_resource_state.dart';

class ProceedResourceCubit extends Cubit<ProceedResourceState> {
  final ProceedResourceRepository repo;
  ProceedResourceCubit({
    required this.repo,
  }) : super(ProceedResourceState.initial());

  Future<bool> addProccedResource(Map<String, dynamic> map) async {
    emit(state.copyWith(
      status: ProceedResourceEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.addProceedResource(map);
      emit(state.copyWith(
        status: ProceedResourceEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ProceedResourceEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }

  Future<List<ProceedResourcesModel>> getProceedResource() async {
    emit(state.copyWith(
      status: ProceedResourceEnum.loading,
      proceedResourceModel: [],
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.getProceedResource();
      emit(state.copyWith(
        status: ProceedResourceEnum.success,
        proceedResourceModel: res,
        error: const CustomError(error: ""),
      ));

      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ProceedResourceEnum.error,
        proceedResourceModel: [],
        error: CustomError(error: e.toString()),
      ));
      return [];
    }
  }

  Future<bool> editProceedResource(id, map) async {
    emit(state.copyWith(
      status: ProceedResourceEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.editProceedResource(id, map);
      emit(state.copyWith(
        status: ProceedResourceEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ProceedResourceEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }

  Future<bool> deleteProceedResource(id) async {
    emit(state.copyWith(
      status: ProceedResourceEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.deleteProceedResource(id);
      emit(state.copyWith(
        status: ProceedResourceEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ProceedResourceEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }
}
