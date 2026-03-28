import 'package:flutter/material.dart';
import '../../../constants/app_theme.dart';
import '../../../utils/header.dart';

class PrivacySafetyScreen extends StatelessWidget {
  const PrivacySafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: Column(
        children: [
          const TimeBuddyHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Privacy & Safety',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _buildPrivacySection(
                    title: 'Your Data',
                    content:
                        'TimeBuddy takes your privacy seriously. All your tasks and habits are stored locally on your device or encrypted in our secure cloud if you use sync features.',
                  ),
                  const SizedBox(height: 24),
                  _buildPrivacySection(
                    title: 'Guardian Shield',
                    content:
                        'Parent Mode is protected by a secondary PIN to ensure child safety and controlled management of limits and rewards.',
                  ),
                  const SizedBox(height: 24),
                  _buildPrivacySection(
                    title: 'Analytics',
                    content:
                        'We only collect anonymous usage data to improve the Buddy AI experience. No personal identifiers are ever shared with third parties.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySection({
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: AppTheme.ambientShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C2F30),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
