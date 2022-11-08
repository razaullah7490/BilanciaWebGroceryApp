// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ingredients_cubit.dart';

enum IngredientsEnum {
  initial,
  loading,
  success,
  error,
}

class IngredientsState extends Equatable {
  final IngredientsEnum status;
  final List<IngredientModel> modelList;
  final CustomError error;
  const IngredientsState({
    required this.status,
    required this.modelList,
    required this.error,
  });

  factory IngredientsState.initial() {
    return const IngredientsState(
      status: IngredientsEnum.initial,
      modelList: [],
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, modelList, error];

  IngredientsState copyWith({
    IngredientsEnum? status,
    List<IngredientModel>? modelList,
    CustomError? error,
  }) {
    return IngredientsState(
      status: status ?? this.status,
      modelList: modelList ?? this.modelList,
      error: error ?? this.error,
    );
  }
}
