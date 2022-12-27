part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

//* GetMovies Event
class GetMoviesEvent extends MovieEvent {}

//* SearchMovies Event
class SearchMoviesEvent extends MovieEvent {
  final String title;

  const SearchMoviesEvent(this.title);
}

//* AddMovie Event
class AddMovieEvent extends MovieEvent {
  final MovieModel movieModel;

  const AddMovieEvent(this.movieModel);
}

//* DeleteMovie Event
class DeleteMovieEvent extends MovieEvent {
  final String id;

  const DeleteMovieEvent(this.id);
}

//* GetFavorites Event
class GetFavoritesEvent extends MovieEvent {
  
}
