class DashboardStatsModel {
  final int totalUsers;
  final int totalMaterials;
  final int totalAssignments;
  final int totalSessions;

  DashboardStatsModel({
    required this.totalUsers,
    required this.totalMaterials,
    required this.totalAssignments,
    required this.totalSessions,
  });

  // Factory constructor untuk memetakan data statistik dari API
  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      totalUsers: json['total_users'] ?? 0,
      totalMaterials: json['total_materials'] ?? 0,
      totalAssignments: json['total_assignments'] ?? 0,
      totalSessions: json['total_sessions'] ?? 0,
    );
  }
}