// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_cubit.dart';

enum CategoryEnum {
  initial,
  loading,
  success,
  error,
}

class CategoryState extends Equatable {
  final CategoryEnum status;
  final List<CategoryModel> categoryModel;
  final CustomError error;
  const CategoryState({
    required this.status,
    required this.categoryModel,
    required this.error,
  });

  factory CategoryState.initial() {
    return const CategoryState(
      status: CategoryEnum.initial,
      categoryModel: [],
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, categoryModel, error];

  CategoryState copyWith({
    CategoryEnum? status,
    List<CategoryModel>? categoryModel,
    CustomError? error,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categoryModel: categoryModel ?? this.categoryModel,
      error: error ?? this.error,
    );
  }
}
