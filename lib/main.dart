import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_media_kit/just_audio_media_kit.dart';

import 'di/player_binding.dart';
import 'feature/player/player_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (Platform.isLinux || Platform.isWindows)) {
    JustAudioMediaKit.ensureInitialized();
  }
  runApp(const FlutterMusicApp());
}

class FlutterMusicApp extends StatelessWidget {
  const FlutterMusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PlayerPage(),
      initialBinding: PlayerBinding(),
    );
  }
}
