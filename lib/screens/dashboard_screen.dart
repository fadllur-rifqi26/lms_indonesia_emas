import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../views/assignments_view.dart';
import '../views/dashboard_home_view.dart';
import '../views/materials_view.dart';
import '../views/sessions_view.dart';
import '../views/users_view.dart';
import 'sign_in_screen.dart';

class DashboardScreen extends StatefulWidget {
  final UserModel currentUser;

  const DashboardScreen({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  // Mendapatkan daftar menu berdasarkan role pengguna
  List<Map<String, dynamic>> get _menuItems {
    if (widget.currentUser.role == 'Admin') {
      return [
        {'icon': Icons.dashboard, 'title': 'Dashboard'},
        {'icon': Icons.people, 'title': 'Pengguna'},
        {'icon': Icons.book, 'title': 'Bahan Ajar'},
        {'icon': Icons.assignment, 'title': 'Penugasan'},
        {'icon': Icons.class_, 'title': 'Sesi Kelas'},
      ];
    } else if (widget.currentUser.role == 'Guru') {
      return [
        {'icon': Icons.dashboard, 'title': 'Dashboard'},
        {'icon': Icons.book, 'title': 'Bahan Ajar'},
        {'icon': Icons.assignment, 'title': 'Penugasan'},
        {'icon': Icons.class_, 'title': 'Sesi Kelas'},
      ];
    } else {
      // Peran Siswa
      return [
        {'icon': Icons.dashboard, 'title': 'Dashboard'},
        {'icon': Icons.book, 'title': 'Bahan Ajar Saya'},
        {'icon': Icons.assignment, 'title': 'Tugas & Kuis'},
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final menus = _menuItems;

    return Scaffold(
      body: Row(
        children: [
          // 1. Sidebar Navigasi Kiri Dinamis
          Container(
            width: 260,
            color: const Color(0xFF181B20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    'LMS Indonesia Emas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(color: Color(0xFF2A2E39), height: 1),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemCount: menus.length,
                    itemBuilder: (context, index) {
                      return _buildSidebarItem(
                        index,
                        menus[index]['icon'],
                        menus[index]['title'],
                      );
                    },
                  ),
                ),
                const Divider(color: Color(0xFF2A2E39), height: 1),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                  ),
                ),
              ],
            ),
          ),
          
          // 2. Area Konten Utama di Kanan
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Atas
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFF181B20),
                    border: Border(
                      bottom: BorderSide(color: Color(0xFF2A2E39)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        menus[_selectedIndex]['title'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0xFF2A2E39),
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.currentUser.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              Text('Role: ${widget.currentUser.role}', style: const TextStyle(color: Colors.greenAccent, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Konten Berdasarkan Peran & Menu yang Dipilih
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: _getSelectedView(menus[_selectedIndex]['title']),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(int index, IconData icon, String title) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        color: isSelected ? const Color(0xFF21252D) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF10B981) : Colors.grey),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSelectedView(String menuTitle) {
    switch (menuTitle) {
      case 'Dashboard':
        return const DashboardHomeView();
      case 'Pengguna':
        return const UsersView();
      case 'Bahan Ajar':
      case 'Bahan Ajar Saya':
        return const MaterialsView();
      case 'Penugasan':
      case 'Tugas & Kuis':
        return const AssignmentsView();
      case 'Sesi Kelas':
        return const SessionsView();
      default:
        return const DashboardHomeView();
    }
  }
}