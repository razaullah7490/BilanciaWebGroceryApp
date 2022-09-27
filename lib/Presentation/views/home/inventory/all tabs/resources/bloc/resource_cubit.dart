import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Domain/models/resources_model.dart';
part 'resource_state.dart';

class ResourceCubit extends Cubit<ResourceState> {
  final List<ResourcesModel> modelList;
  ResourceCubit({
    required this.modelList,
  }) : super(ResourceState.initial());

  Future addResource(ResourcesModel model) async {
    emit(state.copyWith(status: ResourceEnum.loading, resourceModel: []));
    try {
      modelList.add(model);
      emit(state.copyWith(
          status: ResourceEnum.success, resourceModel: modelList));
    } catch (e) {
      emit(state.copyWith(status: ResourceEnum.error, resourceModel: []));
    }
  }

  Future editResource(int id, ResourcesModel model) async {
    emit(state.copyWith(status: ResourceEnum.loading, resourceModel: []));
    try {
      var index = modelList.indexWhere((element) => element.resourceId == id);
      modelList[index] = model;
      emit(state.copyWith(
          status: ResourceEnum.success, resourceModel: modelList));
    } catch (e) {
      emit(state.copyWith(status: ResourceEnum.error, resourceModel: []));
    }
  }

  Future deleteResource(int id) async {
    emit(state.copyWith(status: ResourceEnum.loading, resourceModel: []));
    try {
      var index = modelList.indexWhere((element) => element.resourceId == id);
      modelList.removeAt(index);
      emit(state.copyWith(
          status: ResourceEnum.success, resourceModel: modelList));
    } catch (e) {
      emit(state.copyWith(status: ResourceEnum.error, resourceModel: []));
    }
  }
}
