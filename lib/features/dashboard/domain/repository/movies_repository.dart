import 'package:dartz/dartz.dart';
import 'package:docki/core/failures/failure.dart';
import 'package:docki/features/dashboard/domain/entities/movie.dart';

import '../usecases/add_movie.dart';
import '../usecases/delete_movie.dart';
import '../usecases/get_movies.dart';
import '../usecases/search_movie.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<Movie>>> getMovies(GetMoviesParams params);
  Future<Either<Failure, List<Movie>>> searchMovie(SearchMovieParams params);
  Future<Either<Failure, bool>> addMovie(AddMovieParams params);
  Future<Either<Failure, bool>> deleteMovie(DeleteMovieParams params);
  Future<Either<Failure, List<Movie>>> getFavorites();
}
