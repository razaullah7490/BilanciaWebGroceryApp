// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grocery/Data/services/agenda/event_service.dart';
import '../../../Domain/models/manager/event_model.dart';
import '../../errors/custom_error.dart';

class EventRepository {
  final EventService eventService;
  EventRepository({
    required this.eventService,
  });

  Future<bool> addEvent(map) async {
    try {
      var res = await eventService.addEvent(map);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<List<EventModel>> getEvent() async {
    try {
      var res = await eventService.getEvent();
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> editEvent(id, map) async {
    try {
      var res = await eventService.editEvent(id, map);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<bool> deleteEvent(id) async {
    try {
      var res = await eventService.deleteEvent(id);
      return res;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
