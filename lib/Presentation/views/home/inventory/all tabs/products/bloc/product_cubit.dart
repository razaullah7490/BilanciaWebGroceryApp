import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Domain/models/products_model.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final List<ProductModel> modelList;
  ProductCubit({
    required this.modelList,
  }) : super(ProductState.initial());

  Future addProduct(ProductModel model) async {
    emit(state.copyWith(status: ProductEnum.loading, productModel: []));
    try {
      modelList.add(model);
      emit(
          state.copyWith(status: ProductEnum.success, productModel: modelList));
    } catch (e) {
      emit(state.copyWith(status: ProductEnum.error, productModel: []));
    }
  }

  Future editProduct(int id, ProductModel model) async {
    emit(state.copyWith(status: ProductEnum.loading, productModel: []));

    try {
      var index = modelList.indexWhere((element) => element.productID == id);
      modelList[index] = model;
      emit(
          state.copyWith(status: ProductEnum.success, productModel: modelList));
    } catch (e) {
      emit(state.copyWith(status: ProductEnum.error, productModel: []));
    }
  }

  Future deleteProduct(int id) async {
    emit(state.copyWith(status: ProductEnum.loading, productModel: []));

    try {
      var index = modelList.indexWhere((element) => element.productID == id);
      modelList.removeAt(index);
      emit(
          state.copyWith(status: ProductEnum.success, productModel: modelList));
    } catch (e) {
      emit(state.copyWith(status: ProductEnum.error, productModel: []));
    }
  }
}
