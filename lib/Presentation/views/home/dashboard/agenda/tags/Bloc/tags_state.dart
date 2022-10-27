// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tags_cubit.dart';

enum TagsEnum {
  initial,
  loading,
  success,
  error,
}

class TagsState extends Equatable {
  final TagsEnum status;
  final List<TagModel> tagModel;
  final CustomError error;
  const TagsState({
    required this.status,
    required this.tagModel,
    required this.error,
  });
  factory TagsState.initial() {
    return const TagsState(
      status: TagsEnum.initial,
      tagModel: [],
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, tagModel, error];

  TagsState copyWith({
    TagsEnum? status,
    List<TagModel>? tagModel,
    CustomError? error,
  }) {
    return TagsState(
      status: status ?? this.status,
      tagModel: tagModel ?? this.tagModel,
      error: error ?? this.error,
    );
  }
}
