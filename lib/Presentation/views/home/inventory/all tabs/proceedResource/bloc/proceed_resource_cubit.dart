import 'dart:developer';
import 'package:grocery/Application/exports.dart';
part 'proceed_resource_state.dart';

class ProceedResourceCubit extends Cubit<ProceedResourceState> {
  final ProceedResourceRepository repo;
  ProceedResourceCubit({
    required this.repo,
  }) : super(ProceedResourceState.initial());

  List<ProceedResourcesModel> searchList = [];

  searching(controller) {
    searchList = state.proceedResourceModel.where((element) {
      return element.name
              .toString()
              .toLowerCase()
              .contains(controller.toLowerCase()) ||
          element.barcode
              .toString()
              .toLowerCase()
              .contains(controller.toLowerCase());
    }).toList();
  }

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
      log("Cubit Error $e");
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
