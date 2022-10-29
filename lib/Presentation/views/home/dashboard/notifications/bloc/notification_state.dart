// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_cubit.dart';

enum NotificationEnum {
  initial,
  loading,
  success,
  error,
}

class NotificationState extends Equatable {
  final NotificationEnum status;
  final List<NotificationModel> modelList;
  final CustomError error;
  const NotificationState({
    required this.status,
    required this.modelList,
    required this.error,
  });

  factory NotificationState.initial() {
    return const NotificationState(
      status: NotificationEnum.initial,
      modelList: [],
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, modelList, error];

  NotificationState copyWith({
    NotificationEnum? status,
    List<NotificationModel>? modelList,
    CustomError? error,
  }) {
    return NotificationState(
      status: status ?? this.status,
      modelList: modelList ?? this.modelList,
      error: error ?? this.error,
    );
  }
}
