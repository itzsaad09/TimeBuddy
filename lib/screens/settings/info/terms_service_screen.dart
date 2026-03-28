import 'package:flutter/material.dart';
import '../../../constants/app_theme.dart';
import '../../../utils/header.dart';

class TermsServiceScreen extends StatelessWidget {
  const TermsServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: Column(
        children: [
          const TimeBuddySubHeader(title: 'Terms of Service'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  _buildTermsCard(
                    title: '1. User Account',
                    content:
                        'You are responsible for maintaining the confidentiality of your account and password. TimeBuddy is designed for use by minors under the supervision of a guardian.',
                  ),
                  const SizedBox(height: 16),
                  _buildTermsCard(
                    title: '2. Guardian Responsibility',
                    content:
                        'The "Parent Mode" functions are intended solely for use by adults. Guardians must ensure that reward systems and time limits are set appropriately for the user.',
                  ),
                  const SizedBox(height: 16),
                  _buildTermsCard(
                    title: '3. Data Licensing',
                    content:
                        'By using TimeBuddy, you grant us a worldwide license to use your task and habit data strictly for the purpose of personalizing your experience and improving Buddy AI.',
                  ),
                  const SizedBox(height: 16),
                  _buildTermsCard(
                    title: '4. Limitation of Liability',
                    content:
                        'TimeBuddy is not responsible for any missed tasks or rewards due to technical malfunctions or user error.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsCard({required String title, required String content}) {
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C2F30),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
