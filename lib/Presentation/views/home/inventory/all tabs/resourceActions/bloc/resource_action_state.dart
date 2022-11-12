// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'resource_action_cubit.dart';

enum ResourceActionEnum {
  initial,
  loading,
  success,
  error,
}

class ResourceActionState extends Equatable {
  final ResourceActionEnum status;
  final ResourceActionModel resourceActionModel;
  final CustomError error;
  const ResourceActionState({
    required this.status,
    required this.resourceActionModel,
    required this.error,
  });

  factory ResourceActionState.initial() {
    return ResourceActionState(
      status: ResourceActionEnum.initial,
      resourceActionModel: ResourceActionModel(),
      error: const CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, resourceActionModel, error];

  ResourceActionState copyWith({
    ResourceActionEnum? status,
    ResourceActionModel? resourceActionModel,
    CustomError? error,
  }) {
    return ResourceActionState(
      status: status ?? this.status,
      resourceActionModel: resourceActionModel ?? this.resourceActionModel,
      error: error ?? this.error,
    );
  }
}
