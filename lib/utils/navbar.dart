import 'package:flutter/material.dart';
import 'dart:ui';

class TimeBuddyNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const TimeBuddyNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color brandBlue = Color(0xFF38B6FF);

    return Container(
      height: 90,
      margin: const EdgeInsets.only(bottom: 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            decoration: BoxDecoration(
              color: brandBlue.withOpacity(0.85),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: brandBlue.withOpacity(0.3),
                  blurRadius: 30,
                  offset: const Offset(0, -10),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    _NavBarItem(
                      icon: Icons.home_rounded,
                      label: 'Home',
                      isSelected: currentIndex == 0,
                      onTap: () => onTap(0),
                    ),
                    _NavBarItem(
                      icon: Icons.checklist_rounded,
                      label: 'Tasks',
                      isSelected: currentIndex == 1,
                      onTap: () => onTap(1),
                    ),
                    _NavBarItem(
                      icon: Icons.castle_rounded,
                      label: 'World',
                      isSelected: currentIndex == 2,
                      onTap: () => onTap(2),
                    ),
                    _NavBarItem(
                      icon: Icons.face_rounded,
                      label: 'Buddy',
                      isSelected: currentIndex == 3,
                      onTap: () => onTap(3),
                    ),
                    _NavBarItem(
                      icon: Icons.bar_chart_rounded,
                      label: 'Stats',
                      isSelected: currentIndex == 4,
                      onTap: () => onTap(4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOutQuart,
            // Drastically reduced horizontal padding for 5-button layout safety
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: isSelected
                  ? Colors.white.withOpacity(0.2)
                  : Colors.transparent,
              border: Border.all(
                color: isSelected
                    ? Colors.white.withOpacity(0.1)
                    : Colors.transparent,
                width: 1,
              ),
            ),
            // FittedBox ensures literal zero chance of overflow error lines
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedScale(
                    scale: isSelected ? 1.05 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(icon, color: Colors.white, size: 24),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOutQuart,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isSelected) const SizedBox(width: 4),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 400),
                          opacity: isSelected ? 1.0 : 0.0,
                          child: !isSelected
                              ? const SizedBox.shrink()
                              : Text(
                                  label,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        12, // Smaller font for high-density bar
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.2, // Tightened tracking
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
