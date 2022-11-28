// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grocery/Application/exports.dart';

class IngredientRepository {
  final IngredientService ingredientService;
  IngredientRepository({
    required this.ingredientService,
  });

  Future<List<IngredientModel>> getIngredients() async {
    try {
      var res = await ingredientService.getIngredients();
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> addIngredient(String description) async {
    try {
      var res = await ingredientService.addIngredient(description);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> deleteIngredient(int id) async {
    try {
      var res = await ingredientService.deleteIngredient(id);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
