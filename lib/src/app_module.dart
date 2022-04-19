import 'package:flutter_modular/flutter_modular.dart';
import 'package:video_player/src/component/page_route.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => pageRoutes;
}
