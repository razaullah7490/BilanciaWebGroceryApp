import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery/Domain/models/category_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final List<CategoryModel> modelList;
  CategoryCubit({
    required this.modelList,
  }) : super(CategoryState.initial());

  Future addCategory(CategoryModel model) async {
    emit(state.copyWith(status: CategoryEnum.loading, categoryModel: []));
    try {
      modelList.add(model);
      emit(state.copyWith(
          status: CategoryEnum.success, categoryModel: modelList));
    } catch (e) {
      emit(state.copyWith(status: CategoryEnum.error, categoryModel: []));
    }
  }

  Future editCategory(int id, CategoryModel model) async {
    emit(state.copyWith(status: CategoryEnum.loading, categoryModel: []));
    try {
      var index = modelList.indexWhere((element) => element.categoryId == id);
      modelList[index] = model;
      emit(state.copyWith(
          status: CategoryEnum.success, categoryModel: modelList));
    } catch (e) {
      emit(state.copyWith(status: CategoryEnum.error, categoryModel: []));
    }
  }

  Future deleteCategory(int id) async {
    emit(state.copyWith(status: CategoryEnum.loading, categoryModel: []));
    try {
      var index = modelList.indexWhere((element) => element.categoryId == id);
      modelList.removeAt(index);
      emit(state.copyWith(
          status: CategoryEnum.success, categoryModel: modelList));
    } catch (e) {
      emit(state.copyWith(status: CategoryEnum.error, categoryModel: []));
    }
  }
}
