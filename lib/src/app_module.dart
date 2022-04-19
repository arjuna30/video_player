import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:video_player_app/src/component/page_route.dart';
import 'package:video_player_app/src/repository/network/video_service.dart';
import 'package:video_player_app/src/repository/video_repository.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        //factory
        Bind.factory((i) => VideoService(i())),

        //singleton
        Bind.singleton((i) => Dio(_option)),
        Bind.singleton((i) => VideoRepository(i())),
      ];

  @override
  List<ModularRoute> get routes => pageRoutes;
}

var _option = BaseOptions(
  baseUrl: 'https://itunes.apple.com/search?',
  connectTimeout: 10000,
  receiveTimeout: 10000,
);
