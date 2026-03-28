import 'package:flutter/material.dart';
import '../../../constants/app_theme.dart';
import '../../../utils/header.dart';
import 'terms_service_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
                        'About TimeBuddy',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

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
                  _buildAboutSection(
                    title: 'Version History',
                    content:
                        'v1.0.1 - Launch Edition\nPolished UI and Buddy AI core integration.',
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
        color: Colors.white.withOpacity(0.6),
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
