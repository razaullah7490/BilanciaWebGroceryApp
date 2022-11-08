import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Data/repository/manager/iva_repository.dart';
import 'package:grocery/Domain/models/manager/iva_model.dart';
import '../../../../../../../Data/errors/custom_error.dart';
part 'manager_iva_state.dart';

class ManagerIvaCubit extends Cubit<ManagerIvaState> {
  final IvaRepository repo;
  ManagerIvaCubit({
    required this.repo,
  }) : super(ManagerIvaState.initial());

  Future<List<IvaModel>> getIva() async {
    emit(state.copyWith(
      status: IvaEnum.loading,
      modelList: [],
      error: const CustomError(error: ""),
    ));

    try {
      var res = await repo.getIva();
      emit(state.copyWith(
        status: IvaEnum.success,
        modelList: res,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: IvaEnum.error,
        modelList: [],
        error: CustomError(error: e.toString()),
      ));
      return [];
    }
  }

  Future<bool> addIva(ivaValue) async {
    emit(state.copyWith(
      status: IvaEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.addIva(ivaValue);
      emit(state.copyWith(
        status: IvaEnum.success,
        error: const CustomError(error: ""),
      ));

      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: IvaEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }

  // Future<bool> editIva(id, ivaValue) async {
  //   emit(state.copyWith(
  //     status: IvaEnum.loading,
  //     error: const CustomError(error: ""),
  //   ));
  //   try {
  //     var res = await repo.editIva(id, ivaValue);
  //     emit(state.copyWith(
  //       status: IvaEnum.success,
  //       error: const CustomError(error: ""),
  //     ));
  //     return res;
  //   } on CustomError catch (e) {
  //     emit(state.copyWith(
  //       status: IvaEnum.error,
  //       error: CustomError(error: e.toString()),
  //     ));
  //     return false;
  //   }
  // }

  Future<bool> deleteIva(id) async {
    emit(state.copyWith(
      status: IvaEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.deleteIva(id);
      emit(state.copyWith(
        status: IvaEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: IvaEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }
}
