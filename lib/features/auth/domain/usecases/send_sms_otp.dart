import 'package:dartz/dartz.dart';
import 'package:docki/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/failures/failure.dart';
import '../../../../core/usecase/usecase.dart';

class SendSmsOtp extends Usecase<bool, SendSmsOtpParams> {
  final AuthRepository authRepository;

  SendSmsOtp(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(params) {
    return authRepository.sendSmsOtp(params);
  }
}

class SendSmsOtpParams extends Equatable {
  final String phone;

  const SendSmsOtpParams(this.phone);

  @override
  List<Object?> get props => [];
}
