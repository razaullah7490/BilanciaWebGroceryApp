part of 'product_cubit.dart';

enum ProductEnum {
  initial,
  loading,
  success,
  error,
}

class ProductState extends Equatable {
  final ProductEnum status;
  final List<ProductModel> productModel;

  const ProductState({
    required this.status,
    required this.productModel,
  });

  factory ProductState.initial() {
    return const ProductState(
      status: ProductEnum.initial,
      productModel: [],
    );
  }

  @override
  List<Object?> get props => [status, productModel];

  ProductState copyWith({
    ProductEnum? status,
    List<ProductModel>? productModel,
  }) {
    return ProductState(
      status: status ?? this.status,
      productModel: productModel ?? this.productModel,
    );
  }
}
