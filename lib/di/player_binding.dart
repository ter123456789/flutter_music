import 'package:get/get.dart';

import '../feature/player/player_controller.dart';
import '../infrastructure/audio/audio_player_service.dart';

class PlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AudioPlayerService());
    Get.put(PlayerController(Get.find()));
  }
}
