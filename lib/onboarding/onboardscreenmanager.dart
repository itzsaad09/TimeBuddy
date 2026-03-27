import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'permissions/micpermission.dart';
import 'permissions/notificationpermission.dart';
import 'permissions/storagepermission.dart';
import '../constants/app_theme.dart';

class OnboardScreenManager extends StatefulWidget {
  const OnboardScreenManager({super.key});

  @override
  State<OnboardScreenManager> createState() => _OnboardScreenManagerState();
}

class _OnboardScreenManagerState extends State<OnboardScreenManager> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  Future<void> _completeOnboarding() async {
    // Request all permissions at the end including Android 13+ media permissions
    await [
      Permission.microphone,
      Permission.storage, // For <= Android 12
      Permission.photos, // For Android 13+
      Permission.videos, // For Android 13+
      Permission.notification,
    ].request();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    if (!mounted) return;

    // Navigate to the main app screen using defined route
    Navigator.of(context).pushReplacementNamed('/home');
  }

  Future<void> _handleNext() async {
    if (_currentPage == 0) {
      await Permission.microphone.request();
    } else if (_currentPage == 1) {
      // For newer android versions (Android 13+), we request photos/videos
      // This is the granular replacement for .storage
      await [
        Permission.storage,
        Permission.photos,
        Permission.videos,
      ].request();
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            children: const [
              MicPermissionScreen(),
              StoragePermissionScreen(),
              NotificationPermissionScreen(),
            ],
          ),

          // Progress Indicators (Dots)
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppTheme.primary
                        : AppTheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),

          // Action Button
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: _currentPage == 2
                ? ElevatedButton(
                    onPressed: _completeOnboarding,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 64),
                      elevation: 8,
                    ),
                    child: const Text('Get Started'),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => _pageController.jumpToPage(2),
                        child: const Text('Skip'),
                      ),
                      ElevatedButton(
                        onPressed: _handleNext,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: const Text('Next'),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
