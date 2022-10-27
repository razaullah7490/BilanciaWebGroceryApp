import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Data/repository/agenda/event_repository.dart';
import 'package:grocery/Domain/models/manager/event_model.dart';

import '../../../../../../../Data/errors/custom_error.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  final EventRepository repo;
  EventCubit({
    required this.repo,
  }) : super(EventState.initial());

  Future<List<EventModel>> getEvent() async {
    emit(state.copyWith(
      status: EventEnum.loading,
      eventModel: [],
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.getEvent();
      emit(state.copyWith(
        status: EventEnum.success,
        eventModel: res,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: EventEnum.error,
        eventModel: [],
        error: CustomError(error: e.toString()),
      ));
      return [];
    }
  }

  Future<bool> addEvent(map) async {
    emit(state.copyWith(
      status: EventEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.addEvent(map);
      emit(state.copyWith(
        status: EventEnum.success,
        error: const CustomError(error: ""),
      ));

      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: EventEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }

  Future<bool> editEvent(id, map) async {
    emit(state.copyWith(
      status: EventEnum.loading,
      error: const CustomError(error: ""),
    ));

    try {
      var res = await repo.editEvent(id, map);
      emit(state.copyWith(
        status: EventEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: EventEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }

  Future<bool> deleteEvent(id) async {
    emit(state.copyWith(
      status: EventEnum.loading,
      error: const CustomError(error: ""),
    ));
    try {
      var res = await repo.deleteEvent(id);
      emit(state.copyWith(
        status: EventEnum.success,
        error: const CustomError(error: ""),
      ));
      return res;
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: EventEnum.error,
        error: CustomError(error: e.toString()),
      ));
      return false;
    }
  }
}
