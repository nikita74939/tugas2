import 'package:flutter/material.dart';
import 'package:tugas2/utils/app_theme.dart';

import '../../pages/group_profile_page.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Math', style: AppTheme.titleLarge),
            Text(
              'Tools',
              style: AppTheme.titleLarge.copyWith(
                color: AppTheme.textSecondary.withOpacity(0.4),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
        _buildAvatar(context),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const GroupInfoPage()),
          ),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.people, color: Colors.white, size: 20),
      ),
    );
  }
}
