// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

enum LoginEnum {
  initial,
  loading,
  success,
  error,
}

class LoginState extends Equatable {
  final LoginEnum status;
  final CustomError error;
  const LoginState({
    required this.status,
    required this.error,
  });
  factory LoginState.initial() {
    return const LoginState(
      status: LoginEnum.initial,
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, error];

  LoginState copyWith({
    LoginEnum? status,
    CustomError? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
