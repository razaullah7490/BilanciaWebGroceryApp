import 'package:grocery/Application/exports.dart';
part 'tags_state.dart';

class TagsCubit extends Cubit<TagsState> {
  final TagRepository repo;
  TagsCubit({
    required this.repo,
  }) : super(TagsState.initial());
  Future<List<TagModel>> getAllTags() async {
    emit(state.copyWith(
      status: TagsEnum.loading,
      error: const CustomError(error: ""),
      tagModel: [],
    ));
    try {
      var res = await repo.getAllTags();
      emit(state.copyWith(
        status: TagsEnum.success,
        error: const CustomError(error: ""),
        tagModel: res,
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: TagsEnum.error,
        error: CustomError(error: e.toString()),
        tagModel: [],
      ));
      return [];
    }
  }

  Future<bool> addTag(map) async {
    emit(state.copyWith(
      status: TagsEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.addTag(map);
      emit(state.copyWith(
        status: TagsEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: TagsEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }

  Future<bool> editTag(id, map) async {
    emit(state.copyWith(
      status: TagsEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.editTag(id, map);
      emit(state.copyWith(
        status: TagsEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: TagsEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }

  Future<bool> deleteTag(id) async {
    emit(state.copyWith(
      status: TagsEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.deleteTag(id);
      emit(state.copyWith(
        status: TagsEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: TagsEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }
}
