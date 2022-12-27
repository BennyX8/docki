import 'package:dartz/dartz.dart';
import 'package:docki/features/dashboard/domain/entities/movie.dart';
import 'package:docki/features/dashboard/domain/repository/movies_repository.dart';
import '../../../../core/failures/failure.dart';
import '../../../../core/usecase/usecase.dart';

class GetFavorites extends Usecase<List<Movie>, NoParams> {
  final MoviesRepository moviesRepository;

  GetFavorites(this.moviesRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(params) {
    return moviesRepository.getFavorites();
  }
}
