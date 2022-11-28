import 'package:grocery/Application/exports.dart';
part 'production_park_state.dart';

class ProductionParkCubit extends Cubit<ProductionParkState> {
  final ProductionParkRepository repo;
  ProductionParkCubit({
    required this.repo,
  }) : super(ProductionParkState.initial());

  Future<List<ProductionParkModel>> getProductionPark(id) async {
    emit(state.copyWith(
      status: ProductionParkEnum.loading,
      modelList: [],
      error: const CustomError(error: ""),
    ));

    try {
      var res = await repo.getProductionPark(id);
      emit(state.copyWith(
        status: ProductionParkEnum.success,
        modelList: res,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ProductionParkEnum.error,
        modelList: [],
        error: CustomError(error: e.toString()),
      ));
      return [];
    }
  }

  Future<bool> addProductionPark(Map<String, dynamic> map) async {
    emit(state.copyWith(
      status: ProductionParkEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.addProductionPark(map);
      emit(state.copyWith(
        status: ProductionParkEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ProductionParkEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }
}
