part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

//* GetMovies States
class GetMoviesLoaded extends MovieState {
  final List<Movie> movies;
  const GetMoviesLoaded(this.movies);
}

class GetMoviesLoading extends MovieState {}

class GetMoviesError extends MovieState {
  final Failure failure;
  const GetMoviesError(this.failure);
}

//* SearchMovies States
class SearchMoviesLoaded extends MovieState {
  final List<Movie> movies;
  const SearchMoviesLoaded(this.movies);
}

class SearchMoviesLoading extends MovieState {}

class SearchMoviesError extends MovieState {
  final Failure failure;
  const SearchMoviesError(this.failure);
}

//* AddMovie States
class AddMovieLoaded extends MovieState {
  final bool status;
  const AddMovieLoaded(this.status);
}

class AddMovieLoading extends MovieState {}

class AddMovieError extends MovieState {
  final Failure failure;
  const AddMovieError(this.failure);
}

//* DeleteMovie States
class DeleteMovieLoaded extends MovieState {
  final bool status;
  const DeleteMovieLoaded(this.status);
}

class DeleteMovieLoading extends MovieState {}

class DeleteMovieError extends MovieState {
  final Failure failure;
  const DeleteMovieError(this.failure);
}

//* GetFavorites States
class GetFavoritesLoaded extends MovieState {
  final List<Movie> movies;
  const GetFavoritesLoaded(this.movies);
}

class GetFavoritesLoading extends MovieState {}

class GetFavoritesError extends MovieState {
  final Failure failure;
  const GetFavoritesError(this.failure);
}
