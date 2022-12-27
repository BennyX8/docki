import 'package:bloc/bloc.dart';
import 'package:docki/core/usecase/usecase.dart';
import 'package:docki/features/dashboard/data/models/movie_model.dart';
import 'package:docki/features/dashboard/domain/entities/movie.dart';
import 'package:docki/features/dashboard/domain/usecases/add_movie.dart';
import 'package:docki/features/dashboard/domain/usecases/delete_movie.dart';
import 'package:docki/features/dashboard/domain/usecases/get_movies.dart';
import 'package:docki/features/dashboard/domain/usecases/search_movie.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/failures/failure.dart';
import '../../domain/usecases/get_favorites.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovies getMovies;
  final SearchMovie searchMovie;
  final AddMovie addMovie;
  final DeleteMovie deleteMovie;
  final GetFavorites getFavorites;

  MovieBloc(
    this.getMovies,
    this.searchMovie,
    this.addMovie,
    this.deleteMovie,
    this.getFavorites,
  ) : super(MovieInitial()) {
    on<MovieEvent>((event, emit) async {
      if (event is GetMoviesEvent) {
        emit(GetMoviesLoading());

        final result = await getMovies(
          GetMoviesParams(),
        );

        emit(result.fold(
          (failure) => GetMoviesError(failure),
          (movies) => GetMoviesLoaded(movies),
        ));
      } else if (event is SearchMoviesEvent) {
        emit(SearchMoviesLoading());

        final result = await searchMovie(SearchMovieParams(event.title));

        emit(result.fold(
          (failure) => SearchMoviesError(failure),
          (movies) => SearchMoviesLoaded(movies),
        ));
      } else if (event is AddMovieEvent) {
        emit(AddMovieLoading());

        final result = await addMovie(AddMovieParams(event.movieModel));

        emit(result.fold(
          (failure) => AddMovieError(failure),
          (status) => AddMovieLoaded(status),
        ));
      } else if (event is DeleteMovieEvent) {
        emit(DeleteMovieLoading());

        final result = await deleteMovie(DeleteMovieParams(event.id));

        emit(result.fold(
          (failure) => DeleteMovieError(failure),
          (status) => DeleteMovieLoaded(status),
        ));
      }
      if (event is GetFavoritesEvent) {
        emit(GetFavoritesLoading());

        final result = await getFavorites(NoParams());

        emit(result.fold(
          (failure) => GetFavoritesError(failure),
          (movies) => GetFavoritesLoaded(movies),
        ));
      }
    });
  }
}
