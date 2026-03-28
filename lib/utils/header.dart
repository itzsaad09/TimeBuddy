import 'package:flutter/material.dart';

class TimeBuddyHeader extends StatelessWidget {
  final bool isSettings;
  const TimeBuddyHeader({super.key, this.isSettings = false});

  @override
  Widget build(BuildContext context) {
    const Color brandBlue = Color(0xFF38B6FF);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 16, 12),
          child: Row(
            children: [
              // Circular Brand Avatar with Blue Accent
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: brandBlue,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  padding: const EdgeInsets.all(1.5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2C2F30),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.face_rounded,
                        color: Color(0xFFFEB700),
                        size: 38,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Brand Text
              Text(
                'TimeBuddy',
                style: TextStyle(
                  color: brandBlue,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const Spacer(),
              // Settings Icon with Selection Indicator
              Container(
                decoration: BoxDecoration(
                  color: isSettings
                      ? brandBlue.withOpacity(0.12)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    if (!isSettings) {
                      Navigator.of(context).pushNamed('/settings');
                    }
                  },
                  icon: Icon(
                    isSettings
                        ? Icons.settings_rounded
                        : Icons.settings_outlined,
                    color: isSettings ? brandBlue : const Color(0xFF8E99A3),
                    size: 26,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
