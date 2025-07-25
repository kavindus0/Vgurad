// lib/widgets/admin/farmer_tips_management_tab.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vguard/core/app_constants.dart';
import 'package:vguard/models/farmer_tip.dart';
import 'package:vguard/services/admin_data_service.dart';

class FarmerTipsManagementTab extends StatefulWidget {
  const FarmerTipsManagementTab({super.key});

  @override
  State<FarmerTipsManagementTab> createState() =>
      _FarmerTipsManagementTabState();
}

class _FarmerTipsManagementTabState extends State<FarmerTipsManagementTab> {
  final AdminDataService _adminDataService = AdminDataService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  void _addFarmerTip() async {
    if (_titleController.text.isEmpty ||
        _contentController.text.isEmpty ||
        _categoryController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields.')));
      return;
    }

    final newTip = FarmerTip(
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      category: _categoryController.text.trim(),
      dateAdded: DateTime.now(), // Set current date
    );

    try {
      await _adminDataService.addFarmerTip(newTip);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Farmer tip added successfully!')),
        );
        _titleController.clear();
        _contentController.clear();
        _categoryController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to add farmer tip: $e')));
      }
    }
  }

  void _deleteFarmerTip(String id) async {
    try {
      await _adminDataService.deleteFarmerTip(id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Farmer tip deleted successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete farmer tip: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.paddingXLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '+ Add New Tip',
            style: AppTextStyles.heading2.copyWith(color: AppColors.black87),
          ),
          const SizedBox(height: AppSizes.paddingMedium),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: 'Enter tip title',
              labelText: 'Title',
            ),
          ),
          const SizedBox(height: AppSizes.paddingMedium),
          TextField(
            controller: _categoryController,
            decoration: const InputDecoration(
              hintText: 'Enter category',
              labelText: 'Category',
            ),
          ),
          const SizedBox(height: AppSizes.paddingMedium),
          TextField(
            controller: _contentController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'Enter tip content',
              labelText: 'Content',
            ),
          ),
          const SizedBox(height: AppSizes.paddingXLarge),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _addFarmerTip,
              icon: const Icon(Icons.add),
              label: const Text('Add Tip'),
            ),
          ),
          const SizedBox(height: AppSizes.paddingXLarge),
          Text(
            'Existing Farmer Tips',
            style: AppTextStyles.heading2.copyWith(color: AppColors.black87),
          ),
          const SizedBox(height: AppSizes.paddingMedium),
          StreamBuilder<List<FarmerTip>>(
            stream: _adminDataService.getFarmerTips(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No farmer tips added yet.'));
              } else {
                final tips = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tips.length,
                  itemBuilder: (context, index) {
                    final tip = tips[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: AppSizes.paddingSmall,
                      ),
                      elevation: AppSizes.cardElevation,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadiusMedium,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSizes.paddingMedium),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tip.title,
                                    style: AppTextStyles.bodyLarge.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppSizes.paddingSmall * 0.6,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSizes.paddingSmall,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryGreen.withOpacity(
                                        0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        AppSizes.borderRadiusSmall,
                                      ),
                                    ),
                                    child: Text(
                                      tip.category,
                                      style: TextStyle(
                                        color: AppColors.primaryGreen,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: AppSizes.paddingSmall),
                                  Text(
                                    'Date Added: ${DateFormat('yyyy-MM-dd').format(tip.dateAdded)}',
                                    style: TextStyle(
                                      color: AppColors.grey400,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: AppSizes.paddingSmall),
                                  Text(
                                    tip.content,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: AppColors.grey600,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: AppColors.red,
                              ),
                              onPressed: () => _deleteFarmerTip(tip.id!),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
