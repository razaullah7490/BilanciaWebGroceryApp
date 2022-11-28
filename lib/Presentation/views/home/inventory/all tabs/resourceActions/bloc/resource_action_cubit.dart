import 'package:grocery/Application/exports.dart';
part 'resource_action_state.dart';

class ResourceActionCubit extends Cubit<ResourceActionState> {
  final ResourceActionRepository repo;
  ResourceActionCubit({
    required this.repo,
  }) : super(ResourceActionState.initial());

  // int totalPages = 0;

  // fromStart() async {
  //   emit(state.copyWith(
  //       status: ResourceActionEnum.initial,
  //       error: const CustomError(error: "")));
  // }

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

  Future<ResourceActionModel> getResourceAction(pageNumber) async {
    emit(state.copyWith(
      status: ResourceActionEnum.loading,
      error: const CustomError(error: ""),
      resourceActionModel: ResourceActionModel(),
    ));
    try {
      var res = await repo.getResoruceAction(pageNumber);
      emit(state.copyWith(
        status: ResourceActionEnum.success,
        error: const CustomError(error: ""),
        resourceActionModel: res,
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ResourceActionEnum.error,
        error: CustomError(error: e.toString()),
        resourceActionModel: ResourceActionModel(),
      ));
      return ResourceActionModel();
    }
  }

  Future<bool> deleteResourceAction(id) async {
    emit(state.copyWith(
      status: ResourceActionEnum.loading,
      error: const CustomError(error: ""),
    ));

    try {
      var res = await repo.deleteResourceAction(id);
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
}
