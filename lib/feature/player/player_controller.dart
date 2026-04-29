import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../core/models/position_data.dart';
import '../../infrastructure/audio/audio_player_service.dart';

class PlayerController extends GetxController with WidgetsBindingObserver {
  final AudioPlayerService _service;

  PlayerController(this._service);

  AudioPlayer get player => _service.player;
  Stream<PositionData> get positionDataStream => _service.positionDataStream;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black),
    );
    _service.init();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _service.dispose();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      player.stop();
    }
  }
}
