// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'resource_cubit.dart';

enum ResourceEnum {
  initial,
  loading,
  success,
  error,
}

class ResourceState extends Equatable {
  final ResourceEnum status;
  final List<ResourcesModel> resourceModel;
  final CustomError error;
  const ResourceState({
    required this.status,
    required this.resourceModel,
    required this.error,
  });

  factory ResourceState.initial() {
    return const ResourceState(
      status: ResourceEnum.initial,
      resourceModel: [],
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, resourceModel, error];

  ResourceState copyWith({
    ResourceEnum? status,
    List<ResourcesModel>? resourceModel,
    CustomError? error,
  }) {
    return ResourceState(
      status: status ?? this.status,
      resourceModel: resourceModel ?? this.resourceModel,
      error: error ?? this.error,
    );
  }
}
