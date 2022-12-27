import 'package:docki/core/cache_manager/cache_manager.dart';
import 'package:docki/features/dashboard/data/models/movie_model.dart';
import '../../domain/usecases/add_movie.dart';
import '../../domain/usecases/delete_movie.dart';

abstract class MoviesLocalSource {
  Future<bool> addMovies(AddMovieParams params);
  Future<bool> deleteMovies(DeleteMovieParams params);
  Future<List<MovieModel>> getFavorites();
}

class MoviesLocalSourceImpl implements MoviesLocalSource {
  @override
  Future<bool> addMovies(AddMovieParams params) async {
    final data = await CachManager.instance.getPref('favs');

    //Get List of movie data from Cache
    final List<MovieModel> list = [];

    for (final item in data) {
      list.add(MovieModel.fromJson(item));
    }

    list.add(params.movie);

    //Cache String list
    await CachManager.instance
        .storePref('favs', list.map((e) => e.toJson).toList());

    return true;
  }

  @override
  Future<bool> deleteMovies(DeleteMovieParams params) async {
    final data = await CachManager.instance.getPref('favs');

    //Get List of movie data from Cache
    final List<String> list = data ?? <String>[];

    //Remove movie data from list where movie id is found
    list.removeWhere((e) {
      final movie = MovieModel.fromJson(e);
      return movie.id == params.id;
    });

    //Cache the resulting String list
    await CachManager.instance.storePref('favs', list);

    return true;
  }

  @override
  Future<List<MovieModel>> getFavorites() async {
    final data = await CachManager.instance.getPref('favs');

    //Get List of movie data from Cache
    final List<MovieModel> list = [];

    for (final item in data) {
      list.add(MovieModel.fromJson(item));
    }

    return list;
  }
}
