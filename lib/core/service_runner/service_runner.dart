import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../exceptions/exception.dart';
import '../failures/failure.dart';
import '../network_info/network_info.dart';

class ServiceRunner<Type> {
  final NetworkInfo networkInfo;
  final Future<bool> Function(Type)? cacheTask;

  ServiceRunner({required this.networkInfo, this.cacheTask});

  Future<Either<Failure, Type>> runTask(
      Future<Type> Function() task) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await task.call();

        //Run Cache Task
        if (cacheTask != null) {
          cacheTask!(result);
        }

        //Return the Right side of the either type
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure('serverFailure', e.message));
      } on CacheException catch (e) {
        return Left(CacheFailure('cacheFailure', e.message));
      } on HandshakeException {
        return  const Left(CommonFailure('networkFailure', 'networkError'));
      } on SocketException {
        return const Left(InternetFailure('networkFailure', 'noInternet'));
      } on FormatException {
        return const Left(ProcessFailure('processFailure', 'formatError'));
      } on TimeoutException {
        return const Left(InternetFailure('networkFailure', 'timeoutError'));
      } on CommonException catch (e) {
        return Left(CommonFailure('Process Failure', e.message));
      } on Exception {
        return const Left(UnknownFailure('unknownError'));
      }
    } else {
      return const Left(InternetFailure('networkFailure', 'noInternet'));
    }
  }


}
