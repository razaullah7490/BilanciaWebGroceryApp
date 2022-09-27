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
  const ProceedResourceActionState({
    required this.status,
    required this.resourceActionModel,
  });

  factory ProceedResourceActionState.initial() {
    return const ProceedResourceActionState(
      status: ProceedResourceActionEnum.initial,
      resourceActionModel: [],
    );
  }

  @override
  List<Object?> get props => [status, resourceActionModel];

  ProceedResourceActionState copyWith({
    ProceedResourceActionEnum? status,
    List<ProcessedResourceActionModel>? resourceActionModel,
  }) {
    return ProceedResourceActionState(
      status: status ?? this.status,
      resourceActionModel: resourceActionModel ?? this.resourceActionModel,
    );
  }
}
