import 'package:dartz/dartz.dart';
import 'package:docki/features/auth/domain/entities/auth_user.dart';
import 'package:docki/features/auth/domain/repository/auth_repository.dart';
import '../../../../core/failures/failure.dart';
import '../../../../core/usecase/usecase.dart';

class VerifyPhone extends Usecase<AuthUser, VerifyPhoneParams> {
  final AuthRepository authRepository;

  VerifyPhone(this.authRepository);

  @override
  Future<Either<Failure, AuthUser>> call(params) {
    return authRepository.verifyPhone(params);
  }
}

class VerifyPhoneParams {
  final String phone;
  final String otp;

  const VerifyPhoneParams(this.phone, this.otp);
}
