import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Data/repository/manager/ingredient_repository.dart';
import 'package:grocery/Domain/models/manager/ingredient_model.dart';
import '../../../../../../../Data/errors/custom_error.dart';
part 'ingredients_state.dart';

class IngredientsCubit extends Cubit<IngredientsState> {
  final IngredientRepository repo;
  IngredientsCubit({
    required this.repo,
  }) : super(IngredientsState.initial());

  Future<List<IngredientModel>> getIngredients() async {
    emit(state.copyWith(
      status: IngredientsEnum.loading,
      modelList: [],
      error: const CustomError(error: ""),
    ));

    try {
      var res = await repo.getIngredients();
      emit(state.copyWith(
        status: IngredientsEnum.success,
        modelList: res,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: IngredientsEnum.error,
        modelList: [],
        error: CustomError(error: e.toString()),
      ));
      return [];
    }
  }

  Future<bool> addIngredient(String description) async {
    emit(state.copyWith(
      status: IngredientsEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.addIngredient(description);
      emit(state.copyWith(
        status: IngredientsEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: IngredientsEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }

  Future<bool> deleteIngredient(int id) async {
    emit(state.copyWith(
      status: IngredientsEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.deleteIngredient(id);
      emit(state.copyWith(
        status: IngredientsEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: IngredientsEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }
}
