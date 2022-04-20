import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:video_player_app/src/component/page_route.dart';
import 'package:video_player_app/src/repository/network/network_error.dart';
import 'package:video_player_app/src/repository/network/video_service.dart';
import 'package:video_player_app/src/repository/video_repository.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        //factory
        Bind.factory((i) => VideoService(i())),

        //singleton
        Bind.singleton(
            (i) => Dio(_option)..interceptors.add(_CustomInterceptor())),
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

class _CustomInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.type == DioErrorType.other) {
      throw NetworkException('No Internet Connection', StackTrace.current);
    }
    throw NetworkException(err.message, StackTrace.current);
  }
}
