import 'package:dartz/dartz.dart';
import '../../../../core/failures/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_user.dart';
import '../repository/auth_repository.dart';

class Signin extends Usecase<AuthUser, SigninParams> {
  final AuthRepository authRepository;

  Signin(this.authRepository);

  @override
  Future<Either<Failure, AuthUser>> call(params) {
    return authRepository.signin(params);
  }
}

class SigninParams {
  final String email;
  final String password;

  const SigninParams(this.email, this.password);
  
}
