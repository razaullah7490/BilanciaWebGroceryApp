// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_cubit.dart';

enum UserEnum {
  initial,
  loading,
  success,
  error,
}

class UserState extends Equatable {
  final UserEnum status;
  final List<UserModel> userModel;
  final CustomError error;
  const UserState({
    required this.status,
    required this.userModel,
    required this.error,
  });

  factory UserState.initial() {
    return const UserState(
      status: UserEnum.initial,
      userModel: [],
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, userModel, error];

  UserState copyWith({
    UserEnum? status,
    List<UserModel>? userModel,
    CustomError? error,
  }) {
    return UserState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
      error: error ?? this.error,
    );
  }
}
