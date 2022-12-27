import 'package:dartz/dartz.dart';
import 'package:docki/core/failures/failure.dart';
import 'package:docki/features/auth/domain/entities/auth_user.dart';
import 'package:docki/features/auth/domain/usecases/send_sms_otp.dart';

import '../usecases/signin.dart';
import '../usecases/signup.dart';
import '../usecases/verify_phone.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUser>> signin(SigninParams params);
  Future<Either<Failure, AuthUser>> signup(SignupParams params);
  Future<Either<Failure, bool>> signout();
  Future<Either<Failure, AuthUser>> verifyPhone(VerifyPhoneParams params);
  Future<Either<Failure, bool>> sendSmsOtp(SendSmsOtpParams params);
}
