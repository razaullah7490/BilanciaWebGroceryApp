// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'proceed_resource_action_cubit.dart';

enum ProceedResourceActionEnum {
  initial,
  loading,
  success,
  error,
}

class ProceedResourceActionState extends Equatable {
  final ProceedResourceActionEnum status;
  final List<ProcessedResourceActionModel> resourceActionModel;
  final CustomError error;
  const ProceedResourceActionState({
    required this.status,
    required this.resourceActionModel,
    required this.error,
  });

  factory ProceedResourceActionState.initial() {
    return const ProceedResourceActionState(
      status: ProceedResourceActionEnum.initial,
      resourceActionModel: [],
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, resourceActionModel, error];

  ProceedResourceActionState copyWith({
    ProceedResourceActionEnum? status,
    List<ProcessedResourceActionModel>? resourceActionModel,
    CustomError? error,
  }) {
    return ProceedResourceActionState(
      status: status ?? this.status,
      resourceActionModel: resourceActionModel ?? this.resourceActionModel,
      error: error ?? this.error,
    );
  }
}
