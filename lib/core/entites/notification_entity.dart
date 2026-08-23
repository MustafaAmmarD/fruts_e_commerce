class NotificationEntity {
  final String id;
  final String title;
  final String body;
  final DateTime date;
  final bool isRead;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.isRead,
  });

  NotificationEntity copyWith({
    String? id,
    String? title,
    String? body,
    DateTime? date,
    bool? isRead,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      date: date ?? this.date,
      isRead: isRead ?? this.isRead,
    );
  }
}
