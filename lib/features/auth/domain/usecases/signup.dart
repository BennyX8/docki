import 'package:dartz/dartz.dart';
import 'package:docki/features/auth/domain/entities/auth_user.dart';
import 'package:docki/features/auth/domain/repository/auth_repository.dart';
import '../../../../core/failures/failure.dart';
import '../../../../core/usecase/usecase.dart';

class Signup extends Usecase<AuthUser, SignupParams> {
  final AuthRepository authRepository;

  Signup(this.authRepository);

  @override
  Future<Either<Failure, AuthUser>> call(params) {
    return authRepository.signup(params);
  }
}

class SignupParams {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String interest;

  const SignupParams({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.interest,
  });
}
