import 'package:flutter_music/core/router/router.dart';
import 'package:flutter_music/feature/list_music/list_music_page.dart';
import 'package:flutter_music/feature/player/player_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final route = [
    GetPage(name: Router.list_music, page: () => ListMusicPage()),
    GetPage(name: Router.player, page: () => PlayerPage()),
  ];
}
