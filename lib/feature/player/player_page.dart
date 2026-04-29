import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/models/position_data.dart';
import '../../core/widgets/seek_bar.dart';
import 'control_buttons.dart';
import 'player_controller.dart';

class PlayerPage extends GetView<PlayerController> {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ControlButtons(controller.player),
            StreamBuilder<PositionData>(
              stream: controller.positionDataStream,
              builder: (context, snapshot) {
                final pd = snapshot.data;
                return SeekBar(
                  duration: pd?.duration ?? Duration.zero,
                  position: pd?.position ?? Duration.zero,
                  bufferedPosition: pd?.bufferedPosition ?? Duration.zero,
                  onChangeEnd: controller.player.seek,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
