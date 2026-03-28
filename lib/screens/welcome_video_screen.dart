import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:video_player/video_player.dart';

class WelcomeVideoScreen extends StatefulWidget {
  final bool shouldSkip;
  const WelcomeVideoScreen({super.key, this.shouldSkip = false});

  @override
  State<WelcomeVideoScreen> createState() => _WelcomeVideoScreenState();
}

class _WelcomeVideoScreenState extends State<WelcomeVideoScreen> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.shouldSkip) {
      // If we are recovering from a crash/restart, skip the heavy media engine
      _skipDirectly();
    } else {
      _initializeVideo();
    }
  }

  void _skipDirectly() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
      _onVideoComplete();
    });
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
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void dispose() {
    if (_initialized) _controller.dispose();
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
