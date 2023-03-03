part of 'export_cubit.dart';

enum ExportEnum {
  initial,
  loading,
  success,
  error,
}

class ExportState extends Equatable {
  final ExportEnum status;
  final CustomError error;
  const ExportState({
    required this.status,
    required this.error,
  });

  factory ExportState.initial() {
    return const ExportState(
      status: ExportEnum.initial,
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, error];

  ExportState copyWith({
    ExportEnum? status,
    CustomError? error,
  }) {
    return ExportState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
