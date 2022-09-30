import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Data/repository/manager/resource_action_repository.dart';

import '../../../../../../../Data/errors/custom_error.dart';
import '../../../../../../../Domain/models/inventory/resource_action_model.dart';

part 'resource_action_state.dart';

class ResourceActionCubit extends Cubit<ResourceActionState> {
  final ResourceActionRepository repo;
  ResourceActionCubit({
    required this.repo,
  }) : super(ResourceActionState.initial());

  Future<bool> addResourceAction(map) async {
    emit(state.copyWith(
      status: ResourceActionEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.addResourceAction(map);
      emit(state.copyWith(
        status: ResourceActionEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ResourceActionEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }

//   Future editResourceAction(int id, ResourceActionModel model) async {
//     emit(state
//         .copyWith(status: ResourceActionEnum.loading, resourceActionModel: []));
//     try {
//       var index =
//           modelList.indexWhere((element) => element.resourceActionId == id);
//       modelList[index] = model;
//       emit(state.copyWith(
//           status: ResourceActionEnum.success, resourceActionModel: modelList));
//     } catch (e) {
//       emit(state
//           .copyWith(status: ResourceActionEnum.error, resourceActionModel: []));
//     }
//   }

//   Future deleteResourceAction(int id) async {
//     emit(state
//         .copyWith(status: ResourceActionEnum.loading, resourceActionModel: []));

//     try {
//       var index =
//           modelList.indexWhere((element) => element.resourceActionId == id);
//       modelList.removeAt(index);
//       emit(state.copyWith(
//           status: ResourceActionEnum.success, resourceActionModel: modelList));
//     } catch (e) {
//       emit(state
//           .copyWith(status: ResourceActionEnum.error, resourceActionModel: []));
//     }
//   }
}
