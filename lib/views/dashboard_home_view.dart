import 'package:flutter/material.dart';
import '../models/dashboard_stats_model.dart';
import '../services/api_service.dart';

class DashboardHomeView extends StatefulWidget {
  const DashboardHomeView({Key? key}) : super(key: key);

  @override
  State<DashboardHomeView> createState() => _DashboardHomeViewState();
}

class _DashboardHomeViewState extends State<DashboardHomeView> {
  final ApiService _apiService = ApiService();
  late Future<DashboardStatsModel> _statsFuture;

  @override
  void initState() {
    super.initState();
    _statsFuture = _apiService.fetchDashboardStats();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DashboardStatsModel>(
      future: _statsFuture,
      builder: (context, snapshot) {
        // Ketika data sedang dimuat (menampilkan indikator loading)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF10B981),
            ),
          );
        } 
        // Ketika terjadi error
        else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Terjadi kesalahan: ${snapshot.error}',
              style: const TextStyle(color: Colors.redAccent),
            ),
          );
        } 
        // Jika data berhasil didapatkan
        else if (snapshot.hasData) {
          final stats = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ringkasan Statistik',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStatCard('Total Pengguna', stats.totalUsers.toString(), 'Seluruh civitas akademika'),
                  const SizedBox(width: 16),
                  _buildStatCard('Total Bahan Ajar', stats.totalMaterials.toString(), 'Modul materi aktif'),
                  const SizedBox(width: 16),
                  _buildStatCard('Total Penugasan', stats.totalAssignments.toString(), 'Tugas beredar di sistem'),
                  const SizedBox(width: 16),
                  _buildStatCard('Total Sesi Kelas', stats.totalSessions.toString(), 'Sesi pertemuan & absensi'),
                ],
              ),
            ],
          );
        }

        return const Center(
          child: Text('Tidak ada data statistik.', style: TextStyle(color: Colors.grey)),
        );
      },
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF181B20),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF2A2E39)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}