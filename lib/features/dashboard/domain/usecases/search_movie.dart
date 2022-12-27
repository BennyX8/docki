import 'package:dartz/dartz.dart';
import 'package:docki/features/dashboard/domain/entities/movie.dart';
import 'package:docki/features/dashboard/domain/repository/movies_repository.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/failures/failure.dart';
import '../../../../core/usecase/usecase.dart';

class SearchMovie extends Usecase<List<Movie>, SearchMovieParams> {
  final MoviesRepository moviesRepository;

  SearchMovie(this.moviesRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(params) {
    return moviesRepository.searchMovie(params);
  }
}

class SearchMovieParams extends Equatable {
  final String title;

  const SearchMovieParams(this.title);

  @override
  List<Object?> get props => [];
}
