import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../constants/app_theme.dart';
import '../../utils/header.dart';
import '../../utils/navbar.dart';
import 'info/about_screen.dart';
import 'info/privacy_safety_screen.dart';
import 'widgets/settings_tile.dart';
import 'widgets/settings_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with WidgetsBindingObserver {
  bool _pushNotifications = false;
  bool _buddyVoiceAlerts = true;
  bool _micPermission = false;
  bool _storagePermission = false;
  bool _isChecking = false;
  String _studentName = "Alex Explorer";
  String _studentClass = "Level 12 Guardian";
  String? _profilePicPath;
  String _appVersion = "1.0.0";

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    WidgetsBinding.instance.addObserver(this);
    _checkAllPermissions();
    _loadProfileData();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = "v${info.version}+${info.buildNumber}";
    });
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _studentName = prefs.getString('student_name') ?? "Alex Explorer";
      _studentClass = prefs.getString('student_class') ?? "Level 12 Guardian";
      _profilePicPath = prefs.getString('student_profile_pic');
    });
  }

  Future<void> _armRecovery() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_route', 'settings');
    await prefs.setBool('is_permission_restart', true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Small settle-down delay for OS transitions
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) _checkAllPermissions();
      });
    }
  }

  Future<void> _checkAllPermissions() async {
    if (_isChecking || !mounted) return;

    _isChecking = true;
    try {
      final n = await Permission.notification.status;
      final m = await Permission.microphone.status;
      final s = await Permission.storage.status;
      final p = await Permission.photos.status;
      final v = await Permission.videos.status;

      if (!mounted) return;

      setState(() {
        _pushNotifications = n.isGranted;
        _micPermission = m.isGranted;
        _storagePermission = s.isGranted || p.isGranted || v.isGranted;
      });
    } catch (e) {
      debugPrint("Sync Error: $e");
    } finally {
      _isChecking = false;
    }
  }

  Future<void> _handlePermissionStep(
    Permission permission,
    bool toggleOn,
  ) async {
    // Only arm recovery when the user actually interacts with a permission
    await _armRecovery();

    try {
      if (toggleOn) {
        // Show dialog
        await permission.request();
      } else {
        // Force manual revoke to avoid process-kill issues
        await openAppSettings();
      }
    } catch (e) {
      debugPrint("Permission Error: $e");
    }
    _checkAllPermissions();
  }

  Future<void> _handleStoragePermission(bool toggleOn) async {
    try {
      if (toggleOn) {
        await [
          Permission.storage,
          Permission.photos,
          Permission.videos,
        ].request();
      } else {
        await openAppSettings();
      }
    } catch (e) {
      debugPrint("Storage Error: $e");
    }
    _checkAllPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      extendBody: true,
      body: Column(
        children: [
          const TimeBuddyHeader(isSettings: true),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 24,
                bottom: 120,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Settings',
                    style: Theme.of(
                      context,
                    ).textTheme.displayLarge?.copyWith(fontSize: 32),
                  ),
                  const SizedBox(height: 16),

                  SettingsInfoCard(
                    icon: Icons.person_outline_rounded,
                    iconBg: const Color(0xFF64FFDA),
                    iconColor: const Color(0xFF2C2F30),
                    title: _studentName,
                    subtitle: _studentClass,
                    imagePath: _profilePicPath,
                    actionText: 'View Profile ›',
                    onTap: () async {
                      await Navigator.pushNamed(context, '/profile');
                      _loadProfileData();
                    },
                  ),
                  const SizedBox(height: 16),
                  ParentModePortalCard(),

                  const SizedBox(height: 32),
                  _buildSectionHeader('SYSTEM PERMISSIONS'),
                  SettingsToggleTile(
                    icon: Icons.mic_none_rounded,
                    iconBg: const Color(0xFFF3E5F5),
                    iconColor: Colors.purple[400]!,
                    title: 'Microphone Access',
                    subtitle: 'Required for Buddy Voice AI',
                    value: _micPermission,
                    onChanged: (v) =>
                        _handlePermissionStep(Permission.microphone, v),
                  ),
                  const SizedBox(height: 12),
                  SettingsToggleTile(
                    icon: Icons.folder_open_rounded,
                    iconBg: const Color(0xFFE8F5E9),
                    iconColor: Colors.green[400]!,
                    title: 'Storage & Media',
                    subtitle: 'Save assets and recordings',
                    value: _storagePermission,
                    onChanged: _handleStoragePermission,
                  ),
                  const SizedBox(height: 12),
                  SettingsToggleTile(
                    icon: Icons.notifications_none_rounded,
                    iconBg: const Color(0xFFFFF4E0),
                    iconColor: const Color(0xFFD4A017),
                    title: 'Push Notifications',
                    subtitle: 'Reminders and alerts',
                    value: _pushNotifications,
                    onChanged: (v) =>
                        _handlePermissionStep(Permission.notification, v),
                  ),

                  const SizedBox(height: 32),
                  _buildSectionHeader('AUDIO & VISUAL'),
                  SettingsToggleTile(
                    icon: Icons.record_voice_over_outlined,
                    iconBg: const Color(0xFFE0F7F1),
                    iconColor: const Color(0xFF00BFA5),
                    title: 'Buddy Voice Alerts',
                    subtitle: "Hear Buddy's tips out loud",
                    value: _buddyVoiceAlerts,
                    onChanged: (v) => setState(() => _buddyVoiceAlerts = v),
                  ),
                  const SizedBox(height: 12),
                  SettingsNavigationTile(
                    icon: Icons.volume_up_outlined,
                    iconBg: const Color(0xFFE1F5FE),
                    iconColor: AppTheme.primary,
                    title: 'Buddy Voice & Sound',
                  ),

                  const SizedBox(height: 32),
                  _buildSectionHeader('SAFETY & INFO'),
                  SettingsNavigationTile(
                    icon: Icons.lock_outline_rounded,
                    iconBg: const Color(0xFFF5F5F5),
                    iconColor: Colors.black87,
                    title: 'Privacy & Safety',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacySafetyScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SettingsNavigationTile(
                    icon: Icons.info_outline_rounded,
                    iconBg: const Color(0xFFF5F5F5),
                    iconColor: Colors.black87,
                    title: 'About TimeBuddy',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutScreen(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),
                  _buildLogoutButton(),
                  const SizedBox(height: 24),
                  _buildVersionText(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: TimeBuddyNavBar(
        currentIndex: -1,
        onTap: (index) {
          if (index == 0) Navigator.of(context).pushReplacementNamed('/home');
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.grey[400],
          fontWeight: FontWeight.bold,
          fontSize: 11,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          'LOGOUT',
          style: TextStyle(
            color: const Color(0xFFD32F2F),
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildVersionText() {
    return Center(
      child: Text(
        _appVersion.toUpperCase(),
        style: TextStyle(
          color: Color(0xFFBDC3C7),
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
