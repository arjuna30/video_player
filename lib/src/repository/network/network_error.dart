import 'package:video_player_app/src/repository/error_repository.dart';

class NetworkException extends RepositoryException {
  NetworkException(String message, StackTrace stackTrace)
      : super(message, stackTrace);
}
