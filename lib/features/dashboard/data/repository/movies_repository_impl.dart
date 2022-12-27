import 'package:docki/core/network_info/network_info.dart';
import 'package:docki/core/service_runner/service_runner.dart';
import 'package:docki/features/dashboard/data/models/movie_model.dart';
import 'package:docki/features/dashboard/data/sources/movies_local_source.dart';
import 'package:docki/features/dashboard/data/sources/movies_remote_source.dart';
import 'package:docki/features/dashboard/domain/usecases/search_movie.dart';
import 'package:docki/features/dashboard/domain/usecases/get_movies.dart';
import 'package:docki/features/dashboard/domain/usecases/delete_movie.dart';
import 'package:docki/features/dashboard/domain/usecases/add_movie.dart';
import 'package:docki/features/dashboard/domain/entities/movie.dart';
import 'package:docki/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteSource moviesRemoteSource;
  final MoviesLocalSource moviesLocalSource;
  final NetworkInfo networkInfo;

  MoviesRepositoryImpl(
      this.moviesRemoteSource, this.moviesLocalSource, this.networkInfo);

  @override
  Future<Either<Failure, bool>> addMovie(AddMovieParams params) {
    return ServiceRunner<bool>(networkInfo: networkInfo).runTask(
      () => moviesLocalSource.addMovies(params),
    );
  }

  @override
  Future<Either<Failure, bool>> deleteMovie(DeleteMovieParams params) {
    return ServiceRunner<bool>(networkInfo: networkInfo).runTask(
      () => moviesLocalSource.deleteMovies(params),
    );
  }

  @override
  Future<Either<Failure, List<Movie>>> getMovies(GetMoviesParams params) {
    return ServiceRunner<List<MovieModel>>(networkInfo: networkInfo).runTask(
      () => moviesRemoteSource.getMovies(params),
    );
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovie(SearchMovieParams params) {
    return ServiceRunner<List<MovieModel>>(networkInfo: networkInfo).runTask(
      () => moviesRemoteSource.searchMovie(params),
    );
  }

  @override
  Future<Either<Failure, List<Movie>>> getFavorites() {
    return ServiceRunner<List<MovieModel>>(networkInfo: networkInfo)
        .runTask(() => moviesLocalSource.getFavorites());
  }
}
