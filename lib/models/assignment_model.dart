class AssignmentModel {
  final String id;
  final String title;
  final String subject;
  final String uploaderName;
  final String deadline;

  AssignmentModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.uploaderName,
    required this.deadline,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      subject: json['subject'] ?? '',
      uploaderName: json['uploader_name'] ?? '',
      deadline: json['deadline'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subject': subject,
      'uploader_name': uploaderName,
      'deadline': deadline,
    };
  }
}