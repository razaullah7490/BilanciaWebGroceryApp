import 'package:grocery/Application/exports.dart';
part 'command_state.dart';

class CommandCubit extends Cubit<CommandState> {
  final CommandRepository repo;
  CommandCubit({
    required this.repo,
  }) : super(CommandState.initial());
  Future<List<CommandModel>> getCommands() async {
    emit(state.copyWith(
      status: CommandEnum.loading,
      model: [],
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.getCommands();
      emit(state.copyWith(
        status: CommandEnum.success,
        model: res,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: CommandEnum.error,
        model: [],
        error: CustomError(error: e.toString()),
      ));
      return [];
    }
  }

  Future<bool> addCommands(commandType) async {
    emit(state.copyWith(
      status: CommandEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.addCommands(commandType);
      emit(state.copyWith(
        status: CommandEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: CommandEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }

  Future<bool> deleteCommand(commandTypeId) async {
    emit(state.copyWith(
      status: CommandEnum.loading,
      error: const CustomError(error: ""),
    ));

    try {
      var res = await repo.deleteCommand(commandTypeId);
      emit(state.copyWith(
        status: CommandEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: CommandEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }
}
