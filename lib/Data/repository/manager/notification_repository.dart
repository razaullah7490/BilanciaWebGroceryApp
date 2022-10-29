// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grocery/Data/services/manager/notification_service.dart';
import '../../../Domain/models/notification_model.dart';
import '../../errors/custom_error.dart';

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
}
