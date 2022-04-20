import 'dart:io';

class RepositoryException implements IOException {
  final String message;
  final StackTrace stackTrace;

  RepositoryException(this.message, this.stackTrace);

  @override
  String toString() => 'RepositoryException: $message.\n$stackTrace';
}
