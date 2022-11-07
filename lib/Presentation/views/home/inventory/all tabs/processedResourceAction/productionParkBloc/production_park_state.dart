// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'production_park_cubit.dart';

enum ProductionParkEnum {
  initial,
  loading,
  success,
  error,
}

class ProductionParkState extends Equatable {
  final ProductionParkEnum status;
  final List<ProductionParkModel> modelList;
  final CustomError error;
  const ProductionParkState({
    required this.status,
    required this.modelList,
    required this.error,
  });

  factory ProductionParkState.initial() {
    return const ProductionParkState(
      status: ProductionParkEnum.initial,
      modelList: [],
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, modelList, error];

  ProductionParkState copyWith({
    ProductionParkEnum? status,
    List<ProductionParkModel>? modelList,
    CustomError? error,
  }) {
    return ProductionParkState(
      status: status ?? this.status,
      modelList: modelList ?? this.modelList,
      error: error ?? this.error,
    );
  }
}
