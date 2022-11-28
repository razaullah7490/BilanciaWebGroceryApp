import 'dart:developer';
import 'package:grocery/Application/exports.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository repo;
  CategoryCubit({
    required this.repo,
  }) : super(CategoryState.initial());

  List<CategoryModel> searchList = [];

  searching(controller) {
    searchList = state.categoryModel.where((element) {
      return element.categoryName
          .toString()
          .toLowerCase()
          .contains(controller.toLowerCase());
    }).toList();
  }

  Future<bool> addCategory(map) async {
    emit(state.copyWith(
      status: CategoryEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.addCategory(map);
      emit(state.copyWith(
        status: CategoryEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      log("Cubit error $e");
      emit(state.copyWith(
        status: CategoryEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }

  Future<List<CategoryModel>> getCategory() async {
    emit(state.copyWith(
      status: CategoryEnum.loading,
      error: const CustomError(error: ""),
      categoryModel: [],
    ));
    try {
      var res = await repo.getCategory();
      emit(state.copyWith(
        status: CategoryEnum.success,
        error: const CustomError(error: ""),
        categoryModel: res,
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: CategoryEnum.error,
        categoryModel: [],
        error: CustomError(error: e.toString()),
      ));
      log("Cubit error $e");
      return [];
    }
  }

  Future<bool> editCategory(id, map) async {
    emit(state.copyWith(
      status: CategoryEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.editCategory(id, map);
      emit(state.copyWith(
        status: CategoryEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: CategoryEnum.error,
        error: CustomError(error: e.toString()),
      ));
    }
    return false;
  }

  Future<bool> deleteCategory(id) async {
    emit(state.copyWith(
      status: CategoryEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.deleteCategory(id);
      emit(state.copyWith(
        status: CategoryEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: CategoryEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }
}
