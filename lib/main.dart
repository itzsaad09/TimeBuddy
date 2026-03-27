import 'package:flutter/material.dart';
import 'constants/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimeBuddy Design System',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const DesignSystemGallery(),
    );
  }
}

class DesignSystemGallery extends StatelessWidget {
  const DesignSystemGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
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
                  borderRadius: BorderRadius.circular(48), // xl
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
                          borderRadius: BorderRadius.circular(999), // full
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

              // Secondary Card ( surface-container-low)
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
                    const Divider(height: 32), // Should be transparent by theme
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
