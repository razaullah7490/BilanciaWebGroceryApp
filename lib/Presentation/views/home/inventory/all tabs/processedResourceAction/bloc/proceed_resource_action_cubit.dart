import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../Domain/models/inventory/proceed_resource_action_model.dart';
part 'proceed_resource_action_state.dart';

class ProceedResourceActionCubit extends Cubit<ProceedResourceActionState> {
  final List<ProcessedResourceActionModel> modelList;
  ProceedResourceActionCubit({
    required this.modelList,
  }) : super(ProceedResourceActionState.initial());

  Future addProceedResourceAction(ProcessedResourceActionModel model) async {
    emit(state.copyWith(
        status: ProceedResourceActionEnum.loading, resourceActionModel: []));
    try {
      modelList.add(model);
      emit(state.copyWith(
          status: ProceedResourceActionEnum.success,
          resourceActionModel: modelList));
    } catch (e) {
      emit(state.copyWith(
          status: ProceedResourceActionEnum.error, resourceActionModel: []));
    }
  }

  Future editProceedResourceAction(
      int id, ProcessedResourceActionModel model) async {
    emit(state.copyWith(
        status: ProceedResourceActionEnum.loading, resourceActionModel: []));
    try {
      var index = modelList
          .indexWhere((element) => element.processedresourceActionId == id);
      modelList[index] = model;
      emit(state.copyWith(
          status: ProceedResourceActionEnum.success,
          resourceActionModel: modelList));
    } catch (e) {
      emit(state.copyWith(
          status: ProceedResourceActionEnum.error, resourceActionModel: []));
    }
  }

  Future deletProceedResourceAction(int id) async {
    emit(state.copyWith(
        status: ProceedResourceActionEnum.loading, resourceActionModel: []));
    try {
      var index = modelList
          .indexWhere((element) => element.processedresourceActionId == id);
      modelList.removeAt(index);
      emit(state.copyWith(
          status: ProceedResourceActionEnum.success,
          resourceActionModel: modelList));
    } catch (e) {
      emit(state.copyWith(
          status: ProceedResourceActionEnum.error, resourceActionModel: []));
    }
  }
}
