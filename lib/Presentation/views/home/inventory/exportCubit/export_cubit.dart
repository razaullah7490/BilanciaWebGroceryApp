import 'package:grocery/Application/exports.dart';
part 'export_state.dart';

class ExportCubit extends Cubit<ExportState> {
  final ExportRepository repo;
  ExportCubit({
    required this.repo,
  }) : super(ExportState.initial());

  Future<bool> export() async {
    emit(state.copyWith(
      status: ExportEnum.loading,
      error: const CustomError(error: ""),
    ));

    try {
      var res = await repo.export();
      emit(state.copyWith(
        status: ExportEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: ExportEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }
}
