import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Data/repository/manager/notification_repository.dart';
import 'package:grocery/Domain/models/notification_model.dart';
import '../../../../../../Data/errors/custom_error.dart';
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
}
