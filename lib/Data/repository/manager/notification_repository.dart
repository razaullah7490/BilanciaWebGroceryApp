import 'package:grocery/Application/exports.dart';

class NotificationRepository {
  final NotificationService service;
  NotificationRepository({
    required this.service,
  });
  Future<List<NotificationModel>> getNotifications() async {
    try {
      var res = await service.getNotifications();
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> editNotification(id) async {
    try {
      var res = await service.editNotification(id);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
