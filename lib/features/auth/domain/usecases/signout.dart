import 'package:dartz/dartz.dart';
import 'package:docki/features/auth/domain/repository/auth_repository.dart';
import '../../../../core/failures/failure.dart';
import '../../../../core/usecase/usecase.dart';

class Signout extends Usecase<bool, NoParams> {
  final AuthRepository authRepository;

  Signout(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(params) {
    return authRepository.signout();
  }
}
