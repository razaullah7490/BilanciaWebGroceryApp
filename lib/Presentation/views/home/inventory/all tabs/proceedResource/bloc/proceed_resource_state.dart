// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'proceed_resource_cubit.dart';

enum ProceedResourceEnum {
  initial,
  loading,
  success,
  error,
}

class ProceedResourceState extends Equatable {
  final ProceedResourceEnum status;
  final List<ProceedResourcesModel> proceedResourceModel;
  const ProceedResourceState({
    required this.status,
    required this.proceedResourceModel,
  });

  factory ProceedResourceState.initial() {
    return const ProceedResourceState(
      status: ProceedResourceEnum.initial,
      proceedResourceModel: [],
    );
  }

  @override
  List<Object?> get props => [status, proceedResourceModel];

  ProceedResourceState copyWith({
    ProceedResourceEnum? status,
    List<ProceedResourcesModel>? proceedResourceModel,
  }) {
    return ProceedResourceState(
      status: status ?? this.status,
      proceedResourceModel: proceedResourceModel ?? this.proceedResourceModel,
    );
  }
}
