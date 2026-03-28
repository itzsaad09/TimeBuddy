import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:audio_session/audio_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/app_theme.dart';
import 'onboarding/onboardscreenmanager.dart';
import 'screens/welcome_video_screen.dart';
import 'screens/settings/settings_screen.dart'; // Add this
import 'utils/navbar.dart';
import 'utils/header.dart'; // Import header

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Configure Audio Session for video playback sound
  final session = await AudioSession.instance;
  await session.configure(const AudioSessionConfiguration.music());

  // Enable Full Screen / Edge-to-Edge Mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness:
          Brightness.dark, // Changed to dark for light header
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  final prefs = await SharedPreferences.getInstance();
  final bool onboardingDone = prefs.getBool('onboarding_done') ?? false;
  final String? lastRoute = prefs.getString('last_route');

  // Clear current route after reading it so we don't get stuck in a loop
  await prefs.remove('last_route');

  runApp(MyApp(onboardingDone: onboardingDone, lastRoute: lastRoute));
}

class MyApp extends StatelessWidget {
  final bool onboardingDone;
  final String? lastRoute;
  const MyApp({super.key, required this.onboardingDone, this.lastRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimeBuddy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routes: {
        '/home': (context) => const DesignSystemGallery(),
        '/onboarding': (context) => const OnboardScreenManager(),
        '/settings': (context) => const SettingsScreen(),
      },
      home: (lastRoute == 'settings' && onboardingDone)
          ? const SettingsScreen()
          : onboardingDone
          ? const WelcomeVideoScreen()
          : const OnboardScreenManager(),
    );
  }
}

class DesignSystemGallery extends StatefulWidget {
  const DesignSystemGallery({super.key});

  @override
  State<DesignSystemGallery> createState() => _DesignSystemGalleryState();
}

class _DesignSystemGalleryState extends State<DesignSystemGallery> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      extendBody: true,
      body: Column(
        children: [
          // FIXED BRAND HEADER
          const TimeBuddyHeader(),

          // SCROLLABLE CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 20,
                bottom: 120,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Great job!',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your design system is now active.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),

                  // Buddy Widget Showcase
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.tertiaryContainer,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: AppTheme.ambientShadow,
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Text('🤖', style: TextStyle(fontSize: 30)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            "I'm Buddy! I use the tertiary-container color scheme.",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                  Text(
                    'Interactive Components',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),

                  // Card Hierarchy Showcase
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tonal Hierarchy',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'This card uses surface-container-lowest (#FFFFFF) against the warm surface background (#F5F6F7).',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 24),

                          // Gradient Button
                          Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient,
                              borderRadius: BorderRadius.circular(999),
                              boxShadow: AppTheme.ambientShadow,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(999),
                                onTap: () {},
                                child: const Center(
                                  child: Text(
                                    'Complete Task',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Secondary Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Next Task',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                        const Divider(height: 32),
                        Text(
                          'This uses surface-container-low. The divider above is invisible per rules.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: TimeBuddyNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
