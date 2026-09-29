class MaterialModel {
  final String id;
  final String title;
  final String subject;
  final String uploaderName;
  final String fileUrl;

  MaterialModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.uploaderName,
    required this.fileUrl,
  });

  // Factory constructor untuk memetakan data JSON dari Backend
  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      subject: json['subject'] ?? '',
      uploaderName: json['uploader_name'] ?? '',
      fileUrl: json['file_url'] ?? '',
    );
  }

  // Mengubah objek kembali ke bentuk Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subject': subject,
      'uploader_name': uploaderName,
      'file_url': fileUrl,
    };
  }
}