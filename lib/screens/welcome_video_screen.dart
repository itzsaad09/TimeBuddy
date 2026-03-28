import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:video_player/video_player.dart';

class WelcomeVideoScreen extends StatefulWidget {
  const WelcomeVideoScreen({super.key});

  @override
  State<WelcomeVideoScreen> createState() => _WelcomeVideoScreenState();
}

class _WelcomeVideoScreenState extends State<WelcomeVideoScreen> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.asset('assets/welcome.mp4');
      await _controller.initialize();

      if (!mounted) return;

      setState(() {
        _initialized = true;
      });

      _controller.setVolume(1.0);
      _controller.setLooping(false);
      _controller.play();
      FlutterNativeSplash.remove();

      _controller.addListener(_videoListener);
    } catch (e) {
      debugPrint("Video Init Error: $e");
      // If video fails, don't crash the app, just go to home
      FlutterNativeSplash.remove();
      _onVideoComplete();
    }
  }

  void _videoListener() {
    if (_controller.value.position >= _controller.value.duration) {
      _onVideoComplete();
    }
  }

  void _onVideoComplete() {
    if (!mounted) return;
    // Always navigate to the home screen after welcome video
    Navigator.of(context).pushReplacementNamed('/home');
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
