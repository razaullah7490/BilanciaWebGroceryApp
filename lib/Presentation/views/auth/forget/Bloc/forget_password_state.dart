// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forget_password_cubit.dart';

enum ForgetPasswordEnum {
  initial,
  loading,
  success,
  error,
}

class ForgetPasswordState extends Equatable {
  final ForgetPasswordEnum status;
  final CustomError error;
  const ForgetPasswordState({
    required this.status,
    required this.error,
  });

  factory ForgetPasswordState.initial() {
    return const ForgetPasswordState(
      status: ForgetPasswordEnum.initial,
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, error];

  ForgetPasswordState copyWith({
    ForgetPasswordEnum? status,
    CustomError? error,
  }) {
    return ForgetPasswordState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
