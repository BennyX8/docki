import 'package:dartz/dartz.dart';
import 'package:docki/features/dashboard/domain/entities/movie.dart';
import 'package:docki/features/dashboard/domain/repository/movies_repository.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/failures/failure.dart';
import '../../../../core/usecase/usecase.dart';

class GetMovies extends Usecase<List<Movie>, GetMoviesParams> {
  final MoviesRepository moviesRepository;

  GetMovies(this.moviesRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(params) {
    return moviesRepository.getMovies(params);
  }
}

class GetMoviesParams extends Equatable {
  @override
  List<Object?> get props => [];
}
