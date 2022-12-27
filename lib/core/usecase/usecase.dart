/*
* File : usecase
* Version : 1.0.0
* */

import 'package:dartz/dartz.dart';
import '../failures/failure.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
