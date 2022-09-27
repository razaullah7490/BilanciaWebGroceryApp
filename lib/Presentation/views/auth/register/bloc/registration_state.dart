// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'registration_cubit.dart';

enum RegisterEnum {
  initial,
  loading,
  success,
  error,
}

class RegistrationState extends Equatable {
  final RegisterEnum status;
  final CustomError error;
  const RegistrationState({
    required this.status,
    required this.error,
  });

  factory RegistrationState.initial() {
    return const RegistrationState(
      status: RegisterEnum.initial,
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, error];

  RegistrationState copyWith({
    RegisterEnum? status,
    CustomError? error,
  }) {
    return RegistrationState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
