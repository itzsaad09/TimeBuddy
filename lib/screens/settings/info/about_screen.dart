import 'package:flutter/material.dart';
import '../../../constants/app_theme.dart';
import '../../../utils/header.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'terms_service_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: Column(
        children: [
          const TimeBuddySubHeader(title: 'About TimeBuddy'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // Brand Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: AppTheme.ambientShadow,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: Color(0xFF38B6FF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.face_rounded,
                            color: Color(0xFFFEB700),
                            size: 60,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'TimeBuddy',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF38B6FF),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your companion in focus and fun.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  _buildAboutSection(
                    title: 'Our Mission',
                    content:
                        'To empower children and parents through fun, game-like habit building and focus management.',
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      final version = snapshot.hasData
                          ? "v${snapshot.data!.version}+${snapshot.data!.buildNumber}"
                          : "v1.0.0";
                      return _buildAboutSection(
                        title: 'Version History',
                        content:
                            '$version - Build Edition\nPolished UI and Buddy AI core integration.',
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TermsServiceScreen(),
                        ),
                      );
                    },
                    child: _buildAboutSection(
                      title: 'Terms of Service',
                      content:
                          'By using TimeBuddy, you agree to our terms of data handling and guardian supervision.',
                      isAction: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection({
    required String title,
    required String content,
    bool isAction = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C2F30),
                  ),
                ),
                const SizedBox(height: 8),
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
          ),
          if (isAction) const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
