class UserModel {
  final String id;
  final String name;
  final String email;
  final String role; // Contoh: 'Admin', 'Guru', 'Siswa'

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  // Factory constructor untuk memetakan data JSON dari Backend ke objek UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'Siswa',
    );
  }

  // Mengubah objek UserModel kembali ke bentuk Map (JSON) jika dibutuhkan
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
    };
  }
}