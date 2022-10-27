// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'participants_cubit.dart';

enum ParticipantsEnum {
  initial,
  loading,
  success,
  error,
}

class ParticipantsState extends Equatable {
  final ParticipantsEnum status;
  final List<AllUsersModel> modelList;
  final CustomError error;
  const ParticipantsState({
    required this.status,
    required this.modelList,
    required this.error,
  });

  factory ParticipantsState.initial() {
    return const ParticipantsState(
      status: ParticipantsEnum.initial,
      modelList: [],
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, modelList, error];

  ParticipantsState copyWith({
    ParticipantsEnum? status,
    List<AllUsersModel>? modelList,
    CustomError? error,
  }) {
    return ParticipantsState(
      status: status ?? this.status,
      modelList: modelList ?? this.modelList,
      error: error ?? this.error,
    );
  }
}
