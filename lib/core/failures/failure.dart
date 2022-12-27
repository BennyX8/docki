// ignore_for_file: annotate_overrides, overridden_fields

/*
* File : failure
* Version : 1.0.0
* */
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String title;
  final String message;

  const Failure(this.title, this.message);

  @override
  List<Object> get props => [title, message];
}

class ServerFailure extends Failure {
  final String title;
  final String message;

  const ServerFailure(this.title, this.message) : super(title, message);
}

class CacheFailure extends Failure {
  final String title;
  final String message;

  const CacheFailure(this.title, this.message) : super(title, message);
}

class CommonFailure extends Failure {
  const CommonFailure(final String title, final String message)
      : super(title, message);
}

class InternetFailure extends Failure {
  const InternetFailure(final String title, final String message)
      : super(title, message);
}

class ProcessFailure extends Failure {
  const ProcessFailure(String title, String message) : super(title, message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String title, String message) : super(title, message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(String title) : super(title, '');
}
