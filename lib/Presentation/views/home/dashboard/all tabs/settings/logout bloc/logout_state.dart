// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'logout_cubit.dart';

enum LogoutEnum {
  initial,
  loading,
  success,
  error,
}

class LogoutState extends Equatable {
  final LogoutEnum status;
  final CustomError error;
  const LogoutState({
    required this.status,
    required this.error,
  });

  factory LogoutState.initial() {
    return const LogoutState(
      status: LogoutEnum.initial,
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, error];

  LogoutState copyWith({
    LogoutEnum? status,
    CustomError? error,
  }) {
    return LogoutState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
