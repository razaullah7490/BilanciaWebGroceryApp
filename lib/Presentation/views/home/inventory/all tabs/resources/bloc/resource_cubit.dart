import 'package:grocery/Application/exports.dart';
part 'resource_state.dart';

class ResourceCubit extends Cubit<ResourceState> {
  final ResourcesRepository repo;
  ResourceCubit({
    required this.repo,
  }) : super(ResourceState.initial());

  List<ResourcesModel> searchList = [];

  searching(controller) {
    searchList = state.resourceModel.where((element) {
      return element.resourceName
              .toString()
              .toLowerCase()
              .contains(controller.toLowerCase()) ||
          element.barCode
              .toString()
              .toLowerCase()
              .contains(controller.toLowerCase());
    }).toList();
  }

  Future<bool> addResource(map) async {
    emit(state.copyWith(
      status: ResourceEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.addResource(map);
      emit(state.copyWith(
        status: ResourceEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ResourceEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }

  Future<List<ResourcesModel>> getResource() async {
    emit(state.copyWith(
      status: ResourceEnum.loading,
      error: const CustomError(error: ""),
      resourceModel: [],
    ));

    try {
      var res = await repo.getResource();
      emit(state.copyWith(
        status: ResourceEnum.success,
        error: const CustomError(error: ""),
        resourceModel: res,
      ));

      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ResourceEnum.error,
        error: CustomError(error: e.toString()),
        resourceModel: [],
      ));
      return [];
    }
  }

  Future<bool> editResource(id, map) async {
    emit(state.copyWith(
      status: ResourceEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.editResource(id, map);
      emit(state.copyWith(
        status: ResourceEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ResourceEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }

  Future<bool> deleteResource(id) async {
    emit(state.copyWith(
      status: ResourceEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = repo.deleteResource(id);
      emit(state.copyWith(
        status: ResourceEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ResourceEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }
}
