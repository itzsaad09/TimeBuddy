import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:video_player/video_player.dart';

class WelcomeVideoScreen extends StatefulWidget {
  final bool onboardingDone;

  const WelcomeVideoScreen({super.key, required this.onboardingDone});

  @override
  State<WelcomeVideoScreen> createState() => _WelcomeVideoScreenState();
}

class _WelcomeVideoScreenState extends State<WelcomeVideoScreen> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/welcome.mp4')
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _initialized = true;
          });
          _controller.setVolume(1.0);
          _controller.setLooping(false);
          _controller.play();
          FlutterNativeSplash.remove();
          // Navigate when video finishes
          _controller.addListener(() {
            if (_controller.value.position >= _controller.value.duration) {
              _onVideoComplete();
            }
          });
        }
      });
  }

  void _onVideoComplete() {
    if (!mounted) return;
    // Replace with the next screen logic
    Navigator.of(
      context,
    ).pushReplacementNamed(widget.onboardingDone ? '/home' : '/onboarding');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _initialized
          ? SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
