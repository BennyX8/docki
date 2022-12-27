/*
* File : exception
* Version : 1.0.0
* */

class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class CommonException implements Exception {
  final String message;

  CommonException(this.message);
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);
}

class NoInternetException implements Exception {
  final String message;

  NoInternetException(this.message);
}

//Authentication Error
class AuthenticationException implements Exception {
  final String message;

  AuthenticationException(this.message);

  @override
  String toString() {
    return message;
  }
}

class CompanyException implements Exception {
  final String message;

  CompanyException(this.message);

  @override
  String toString() => message;
}
