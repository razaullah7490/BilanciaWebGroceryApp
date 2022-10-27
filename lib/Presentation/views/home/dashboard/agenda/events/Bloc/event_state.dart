// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_cubit.dart';

enum EventEnum {
  initial,
  loading,
  success,
  error,
}

class EventState extends Equatable {
  final EventEnum status;
  final List<EventModel> eventModel;
  final CustomError error;
  const EventState({
    required this.status,
    required this.eventModel,
    required this.error,
  });

  factory EventState.initial() {
    return const EventState(
      status: EventEnum.initial,
      eventModel: [],
      error: CustomError(error: ""),
    );
  }

  @override
  List<Object?> get props => [status, eventModel, error];

  EventState copyWith({
    EventEnum? status,
    List<EventModel>? eventModel,
    CustomError? error,
  }) {
    return EventState(
      status: status ?? this.status,
      eventModel: eventModel ?? this.eventModel,
      error: error ?? this.error,
    );
  }
}
