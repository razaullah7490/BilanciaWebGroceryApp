import 'package:grocery/Data/services/manager/category_service.dart';
import 'package:grocery/Domain/models/inventory/category_model.dart';
import '../../errors/custom_error.dart';

class CategoryRepository {
  final CatergoryService catergoryService;
  CategoryRepository({
    required this.catergoryService,
  });

  Future<bool> addCategory(map) async {
    try {
      var res = await catergoryService.addCategory(map);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<List<CategoryModel>> getCategory() async {
    try {
      var res = await catergoryService.getCategory();
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> editCategory(id, map) async {
    try {
      var res = await catergoryService.editCategory(id, map);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> deleteCategory(id) async {
    try {
      var res = await catergoryService.deleteCategory(id);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
