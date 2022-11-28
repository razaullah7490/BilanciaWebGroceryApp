import 'package:grocery/Application/exports.dart';

class TagRepository {
  final TagService tagService;
  TagRepository({
    required this.tagService,
  });

  Future<List<TagModel>> getAllTags() async {
    try {
      var res = await tagService.getAllTags();
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> addTag(map) async {
    try {
      var res = await tagService.addTag(map);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> editTag(id, map) async {
    try {
      var res = await tagService.editTag(id, map);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> deleteTag(id) async {
    try {
      var res = await tagService.deleteTag(id);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
