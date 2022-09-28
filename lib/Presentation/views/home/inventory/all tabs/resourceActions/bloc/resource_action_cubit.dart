import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../Domain/models/inventory/resource_action_model.dart';

part 'resource_action_state.dart';

class ResourceActionCubit extends Cubit<ResourceActionState> {
  final List<ResourceActionModel> modelList;
  ResourceActionCubit({
    required this.modelList,
  }) : super(ResourceActionState.initial());

  Future addResourceAction(ResourceActionModel model) async {
    emit(state
        .copyWith(status: ResourceActionEnum.loading, resourceActionModel: []));
    try {
      modelList.add(model);
      emit(state.copyWith(
          status: ResourceActionEnum.success, resourceActionModel: modelList));
    } catch (e) {
      emit(state
          .copyWith(status: ResourceActionEnum.error, resourceActionModel: []));
    }
  }

  Future editResourceAction(int id, ResourceActionModel model) async {
    emit(state
        .copyWith(status: ResourceActionEnum.loading, resourceActionModel: []));
    try {
      var index =
          modelList.indexWhere((element) => element.resourceActionId == id);
      modelList[index] = model;
      emit(state.copyWith(
          status: ResourceActionEnum.success, resourceActionModel: modelList));
    } catch (e) {
      emit(state
          .copyWith(status: ResourceActionEnum.error, resourceActionModel: []));
    }
  }

  Future deleteResourceAction(int id) async {
    emit(state
        .copyWith(status: ResourceActionEnum.loading, resourceActionModel: []));

    try {
      var index =
          modelList.indexWhere((element) => element.resourceActionId == id);
      modelList.removeAt(index);
      emit(state.copyWith(
          status: ResourceActionEnum.success, resourceActionModel: modelList));
    } catch (e) {
      emit(state
          .copyWith(status: ResourceActionEnum.error, resourceActionModel: []));
    }
  }
}
