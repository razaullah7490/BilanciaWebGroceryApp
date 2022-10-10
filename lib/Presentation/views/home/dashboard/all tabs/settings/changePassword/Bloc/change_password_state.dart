// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'change_password_cubit.dart';

enum ChangePasswordEnum {
  initial,
  loading,
  success,
  error,
}

class ChangePasswordState extends Equatable {
  final ChangePasswordEnum status;
  final CustomError error;
  const ChangePasswordState({
    required this.status,
    required this.error,
  });

  factory ChangePasswordState.initial() {
    return const ChangePasswordState(
      status: ChangePasswordEnum.initial,
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, error];

  ChangePasswordState copyWith({
    ChangePasswordEnum? status,
    CustomError? error,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
