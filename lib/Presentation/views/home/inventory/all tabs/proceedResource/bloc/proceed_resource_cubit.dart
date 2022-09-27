import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Domain/models/proceed_resource_model.dart';
part 'proceed_resource_state.dart';

class ProceedResourceCubit extends Cubit<ProceedResourceState> {
  final List<ProceedResourcesModel> modelList;
  ProceedResourceCubit({
    required this.modelList,
  }) : super(ProceedResourceState.initial());

  Future addProccedResource(ProceedResourcesModel model) async {
    emit(state.copyWith(
        status: ProceedResourceEnum.loading, proceedResourceModel: []));
    try {
      modelList.add(model);
      emit(state.copyWith(
          status: ProceedResourceEnum.success,
          proceedResourceModel: modelList));
    } catch (e) {
      emit(state.copyWith(
          status: ProceedResourceEnum.error, proceedResourceModel: []));
    }
  }

  Future editProceedResource(int id, ProceedResourcesModel model) async {
    emit(state.copyWith(
        status: ProceedResourceEnum.loading, proceedResourceModel: []));
    try {
      var index = modelList.indexWhere((element) => element.resourceId == id);
      modelList[index] = model;
      emit(state.copyWith(
          status: ProceedResourceEnum.success,
          proceedResourceModel: modelList));
    } catch (e) {
      emit(state.copyWith(
          status: ProceedResourceEnum.error, proceedResourceModel: []));
    }
  }

  Future deleteProceedResource(int id) async {
    emit(state.copyWith(
        status: ProceedResourceEnum.loading, proceedResourceModel: []));
    try {
      var index = modelList.indexWhere((element) => element.resourceId == id);
      modelList.removeAt(index);
      emit(state.copyWith(
          status: ProceedResourceEnum.success,
          proceedResourceModel: modelList));
    } catch (e) {
      emit(state.copyWith(
          status: ProceedResourceEnum.error, proceedResourceModel: []));
    }
  }
}
