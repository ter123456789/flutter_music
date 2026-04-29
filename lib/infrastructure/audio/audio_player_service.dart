import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/models/position_data.dart';

class AudioPlayerService {
  static const _demoUrl =
      'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3';

  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.positionStream,
        _player.bufferedPositionStream,
        _player.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  Future<void> init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    _player.errorStream.listen((e) {
      debugPrint('A stream error occurred: $e');
    });
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(_demoUrl)));
    } on PlayerException catch (e) {
      debugPrint('Error loading audio source: $e');
    }
  }

  void dispose() => _player.dispose();
}
