class SessionModel {
  final String id;
  final String title;
  final String schedule;
  final String room;
  final String status;

  SessionModel({
    required this.id,
    required this.title,
    required this.schedule,
    required this.room,
    required this.status,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      schedule: json['schedule'] ?? '',
      room: json['room'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'schedule': schedule,
      'room': room,
      'status': status,
    };
  }
}