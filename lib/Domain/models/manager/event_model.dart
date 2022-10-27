// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EventModel {
  final int id;
  final String beginDate;
  final String endDate;
  final String title;
  final String description;
  final List<int> participants;
  final int eventTag;
  EventModel({
    required this.id,
    required this.beginDate,
    required this.endDate,
    required this.title,
    required this.description,
    required this.participants,
    required this.eventTag,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'begin_datetime': beginDate,
      'end_datetime': endDate,
      'title': title,
      'description': description,
      'participants': participants,
      'tag': eventTag,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      beginDate: map['begin_datetime'] as String,
      endDate: map['end_datetime'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      participants: List<int>.from((map['participants'] ?? [])),
      eventTag: map['tag'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
