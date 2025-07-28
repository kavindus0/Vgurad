import 'package:flutter/material.dart';
import 'package:vguard/core/app_constants.dart';
import 'package:vguard/widgets/admin/disease_management_tab.dart';
import 'package:vguard/widgets/admin/expert_management_tab.dart';
import 'package:vguard/widgets/admin/farmer_tips_management_tab.dart';

class AdminSectionPage extends StatefulWidget {
  const AdminSectionPage({super.key});

  @override
  State<AdminSectionPage> createState() => _AdminSectionPageState();
}

class _AdminSectionPageState extends State<AdminSectionPage>
    with SingleTickerProviderStateMixin {
  /// final AuthService _authService = AuthService();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleSignOut() async {
    ///   await _authService.signOut();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged out from Admin section.')),
      );

      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.darkGreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.white),
            onPressed: _handleSignOut,
            tooltip: 'Logout Admin',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            color: AppColors.white, // Background for the tabs
            child: TabBar(
              controller: _tabController,
              indicatorColor:
                  AppColors.primaryGreen, // Color of the selected tab indicator
              labelColor:
                  AppColors.primaryGreen, // Color of the selected tab text
              unselectedLabelColor:
                  AppColors.grey600, // Color of unselected tab text
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              tabs: const [
                Tab(text: 'Disease Database'),
                Tab(text: 'Farmer Tips'),
                Tab(text: 'Expert Help'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DiseaseManagementTab(),
          FarmerTipsManagementTab(),
          ExpertManagementTab(),
        ],
      ),
    );
  }
}
