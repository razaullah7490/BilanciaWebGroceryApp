// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'command_cubit.dart';

enum CommandEnum {
  initial,
  loading,
  success,
  error,
}

class CommandState extends Equatable {
  final CommandEnum status;
  final List<CommandModel> model;
  final CustomError error;
  const CommandState({
    required this.status,
    required this.model,
    required this.error,
  });
  factory CommandState.initial() {
    return const CommandState(
      status: CommandEnum.initial,
      model: [],
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, model, error];

  CommandState copyWith({
    CommandEnum? status,
    List<CommandModel>? model,
    CustomError? error,
  }) {
    return CommandState(
      status: status ?? this.status,
      model: model ?? this.model,
      error: error ?? this.error,
    );
  }
}
