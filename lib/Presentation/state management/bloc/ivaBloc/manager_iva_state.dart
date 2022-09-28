// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'manager_iva_cubit.dart';

enum IvaEnum {
  initial,
  loading,
  success,
  error,
}

class ManagerIvaState extends Equatable {
  final IvaEnum status;
  final List<IvaModel> modelList;
  final CustomError error;
  const ManagerIvaState({
    required this.status,
    required this.modelList,
    required this.error,
  });

  factory ManagerIvaState.initial() {
    return const ManagerIvaState(
      status: IvaEnum.initial,
      modelList: [],
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, modelList, error];

  ManagerIvaState copyWith({
    IvaEnum? status,
    List<IvaModel>? modelList,
    CustomError? error,
  }) {
    return ManagerIvaState(
      status: status ?? this.status,
      modelList: modelList ?? this.modelList,
      error: error ?? this.error,
    );
  }
}
