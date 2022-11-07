class NotificationModel {
  final int id;
  final String title;
  final String message;
  final String dateTime;
  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.dateTime,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as int,
      title: map['title'] as String,
      message: map['message'] as String,
      dateTime: map['date_time'] as String,
    );
  }
}
