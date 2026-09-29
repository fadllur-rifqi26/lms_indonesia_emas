import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dashboard_stats_model.dart';
import '../models/material_model.dart';
import '../models/assignment_model.dart';
import '../models/session_model.dart';
import '../models/user_model.dart';

class ApiService {
  // Deklarasi baseUrl wajib berada di dalam class ApiService
  final String baseUrl = 'https://your-backend-url.com/api';

  // 1. Mengambil Statistik Dashboard
  Future<DashboardStatsModel> fetchDashboardStats() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/dashboard/stats'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DashboardStatsModel.fromJson(data);
      } else {
        throw Exception('Gagal memuat data statistik dari server.');
      }
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 800));
      return DashboardStatsModel(
        totalUsers: 24,
        totalMaterials: 15,
        totalAssignments: 6,
        totalSessions: 12,
      );
    }
  }

  // 2. Mengambil Daftar Pengguna
  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users'));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<UserModel> users = body
            .map((item) => UserModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return users;
      } else {
        throw Exception('Gagal memuat data pengguna.');
      }
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 800));
      return [
        UserModel(id: '1', name: 'Admin Sistem', email: 'admin@lms.com', role: 'Admin'),
        UserModel(id: '2', name: 'Budi Santoso, M.Pd.', email: 'budi@guru.com', role: 'Guru'),
        UserModel(id: '3', name: 'Siti Aminah', email: 'siti@siswa.com', role: 'Siswa'),
      ];
    }
  }

  // 3. Fungsi Login
  Future<UserModel> login(String email, String password) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      if (email.toLowerCase().contains('admin')) {
        return UserModel(id: '1', name: 'Administrator Utama', email: email, role: 'Admin');
      } else if (email.toLowerCase().contains('guru')) {
        return UserModel(id: '2', name: 'Budi Santoso, M.Pd.', email: email, role: 'Guru');
      } else {
        return UserModel(id: '3', name: 'Siti Aminah (Siswa)', email: email, role: 'Siswa');
      }
    } catch (e) {
      throw Exception('Gagal melakukan login. Periksa kembali email dan password.');
    }
  }

  // 4. Mengambil Daftar Bahan Ajar
  Future<List<MaterialModel>> fetchMaterials() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/materials'));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<MaterialModel> materials = body
            .map((item) => MaterialModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return materials;
      } else {
        throw Exception('Gagal memuat bahan ajar.');
      }
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 800));
      return [
        MaterialModel(
          id: '1',
          title: 'Modul Dasar Pemrograman Flutter',
          subject: 'Pemrograman Mobile',
          uploaderName: 'Budi Santoso, M.Pd.',
          fileUrl: 'flutter_modul.pdf',
        ),
        MaterialModel(
          id: '2',
          title: 'Konsep Database Relasional & SQL',
          subject: 'Basis Data',
          uploaderName: 'Administrator Utama',
          fileUrl: 'db_sql.pdf',
        ),
      ];
    }
  }

  // 5. Mengambil Daftar Penugasan
  Future<List<AssignmentModel>> fetchAssignments() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/assignments'));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<AssignmentModel> assignments = body
            .map((item) => AssignmentModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return assignments;
      } else {
        throw Exception('Gagal memuat penugasan.');
      }
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 800));
      return [
        AssignmentModel(
          id: '1',
          title: 'Praktik Hunting Foto Ragam Komposisi Visual',
          subject: 'Fotografi & Videografi',
          uploaderName: 'Zainal Arifin, S.Kom.',
          deadline: '01 Aug 2026, 12:18',
        ),
        AssignmentModel(
          id: '2',
          title: 'Editing Video B-Roll Sinematik Durasi 1 Menit',
          subject: 'Fotografi & Videografi',
          uploaderName: 'Zainal Arifin, S.Kom.',
          deadline: '01 Aug 2026, 12:18',
        ),
      ];
    }
  }

  // 6. Mengambil Daftar Sesi Kelas
  Future<List<SessionModel>> fetchSessions() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/sessions'));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<SessionModel> sessions = body
            .map((item) => SessionModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return sessions;
      } else {
        throw Exception('Gagal memuat sesi kelas.');
      }
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 800));
      return [
        SessionModel(
          id: '1',
          title: 'Pertemuan 1: Pengenalan Arsitektur Flutter & State Management',
          schedule: 'Senin, 08:00 - 10:00 WIB',
          room: 'Lab Komputer A',
          status: 'Aktif',
        ),
        SessionModel(
          id: '2',
          title: 'Pertemuan 2: Integrasi REST API dan FutureBuilder',
          schedule: 'Rabu, 10:00 - 12:00 WIB',
          room: 'Lab Komputer B',
          status: 'Dijadwalkan',
        ),
      ];
    }
  }
}