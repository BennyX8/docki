import 'dart:convert';

import 'package:docki/core/api/api_endpoints.dart';
import 'package:docki/core/exceptions/exception.dart';
import 'package:docki/core/service_runner/json_checker.dart';
import 'package:docki/features/dashboard/data/models/movie_model.dart';
import 'package:docki/features/dashboard/domain/usecases/get_movies.dart';
import '../../domain/usecases/search_movie.dart';
import 'package:http/http.dart' as http;

abstract class MoviesRemoteSource {
  Future<List<MovieModel>> getMovies(GetMoviesParams params);
  Future<List<MovieModel>> searchMovie(SearchMovieParams params);
}

class MoviesRemoteSourceImpl implements MoviesRemoteSource {
  final http.Client client;
  final JsonChecker jsonChecker;

  MoviesRemoteSourceImpl(this.client, this.jsonChecker);

  @override
  Future<List<MovieModel>> getMovies(GetMoviesParams params) async {
    final response = await client.get(Uri.parse(moviesGet));

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        List<MovieModel> movies = [];

        for (final item in data['items']) {
          movies.add(MovieModel.fromMap(item));
        }

        return movies;
      } else {
        throw ServerException(data['errorMessage']);
      }
    } else {
      throw const FormatException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovie(SearchMovieParams params) async {
    final response =
        await client.get(Uri.parse('$moviesSearch${params.title}'));

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        List<MovieModel> movies = [];

        for (final item in data['results']) {
          movies.add(MovieModel.fromMap(item));
        }

        return movies;
      } else {
        throw ServerException(data['errorMessage']);
      }
    } else {
      throw const FormatException();
    }
  }
}
