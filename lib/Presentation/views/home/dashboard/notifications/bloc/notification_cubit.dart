import 'package:grocery/Application/exports.dart';
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository repo;
  NotificationCubit({
    required this.repo,
  }) : super(NotificationState.initial());

  Future<List<NotificationModel>> getNotifications() async {
    emit(state.copyWith(
      status: NotificationEnum.loading,
      modelList: [],
      error: const CustomError(error: ""),
    ));

    try {
      var res = await repo.getNotifications();
      emit(state.copyWith(
        status: NotificationEnum.success,
        modelList: res,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: NotificationEnum.error,
        modelList: [],
        error: CustomError(error: e.toString()),
      ));
      return [];
    }
  }

  Future<bool> editNotification(id) async {
    emit(state.copyWith(
      status: NotificationEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.editNotification(id);
      emit(state.copyWith(
        status: NotificationEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: NotificationEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }
}
