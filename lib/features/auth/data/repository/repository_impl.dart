import 'package:docki/core/cache_manager/cache_manager.dart';
import 'package:docki/core/network_info/network_info.dart';
import 'package:docki/core/service_runner/service_runner.dart';
import 'package:docki/features/auth/data/model/auth_user_model.dart';
import 'package:docki/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:docki/features/auth/domain/repository/auth_repository.dart';
import 'package:docki/features/auth/domain/usecases/send_sms_otp.dart';
import 'package:docki/features/auth/domain/usecases/verify_phone.dart';
import 'package:docki/features/auth/domain/usecases/signup.dart';
import 'package:docki/features/auth/domain/usecases/signin.dart';

import '../sources/auth_remote_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteSource authRemoteSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(this.authRemoteSource, this.networkInfo);

  @override
  Future<Either<Failure, AuthUserModel>> signin(SigninParams params) async {
    return ServiceRunner<AuthUserModel>(
      networkInfo: networkInfo,
      cacheTask: (authUser) =>
          CachManager.instance.storePref('auth_user', authUser.toJson),
    ).runTask(() => authRemoteSource.signin(params));
  }

  @override
  Future<Either<Failure, bool>> signout() async {
    return ServiceRunner<bool>(
      networkInfo: networkInfo,
      cacheTask: (status) => CachManager.instance.clearPref('auth_user'),
    ).runTask(() => authRemoteSource.signout());
  }

  @override
  Future<Either<Failure, AuthUserModel>> signup(SignupParams params) async {
    return ServiceRunner<AuthUserModel>(
      networkInfo: networkInfo,
      cacheTask: (authUser) =>
          CachManager.instance.storePref('auth_user', authUser.toJson),
    ).runTask(() => authRemoteSource.signup(params));
  }

  @override
  Future<Either<Failure, AuthUserModel>> verifyPhone(
      VerifyPhoneParams params) async {
    return ServiceRunner<AuthUserModel>(
      networkInfo: networkInfo,
      cacheTask: (authUser) =>
          CachManager.instance.storePref('auth_user', authUser.toJson),
    ).runTask(() => authRemoteSource.verifyPhone(params));
  }

  @override
  Future<Either<Failure, bool>> sendSmsOtp(SendSmsOtpParams params) {
    return ServiceRunner<bool>(
      networkInfo: networkInfo,
    ).runTask(() => authRemoteSource.sendSmsOtp(params));
  }
}
