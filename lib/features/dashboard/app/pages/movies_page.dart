import 'package:docki/core/cache_manager/cache_manager.dart';
import 'package:docki/core/widgets/custom_loader.dart';
import 'package:docki/core/widgets/custom_route.dart';
import 'package:docki/core/widgets/empty_list_widget.dart';
import 'package:docki/features/auth/app/bloc/auth_bloc.dart';
import 'package:docki/features/dashboard/app/pages/view_movie_page.dart';
import 'package:docki/features/dashboard/data/models/movie_model.dart';
import 'package:docki/features/dashboard/domain/entities/movie.dart';
import 'package:docki/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_bloc.dart';
import '../widgets/movie_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final movieBloc = sl<MovieBloc>();
  final authBloc = sl<AuthBloc>();
  List<Movie> movies = [];
  List<Movie> favorites = [];
  List<String> favoriteIds = [];
  bool loadingMovies = false;
  String message = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authBloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignoutLoaded) {
            setState(() {
              CachManager.instance.clearPref('auth_user');
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: const Text('Movies'),
            actions: const [],
          ),
          body: BlocProvider(
            create: (context) => movieBloc
              ..add(GetMoviesEvent())
              ..add(GetFavoritesEvent()),
            child: BlocListener<MovieBloc, MovieState>(
              listener: (context, state) {

                if (state is GetMoviesLoaded) {
                  setState(() {
                    movies = state.movies;
                    loadingMovies = false;
                  });
                } else if (state is GetMoviesLoading) {
                  setState(() {
                    loadingMovies = true;
                  });
                } else if (state is GetMoviesError) {
                  setState(() {
                    loadingMovies = false;
                    message = state.failure.message;
                  });
                }
                if (state is GetFavoritesLoaded) {
                  setState(() {
                    favorites = state.movies;
                    favoriteIds = state.movies.map((e) => e.id).toList();
                  });
                }
              },
              child: movies.isEmpty
                  ? loadingMovies
                      ? const CustomLoader(
                          message: 'Loading Movies',
                        )
                      : const Center(
                          child: Center(
                            child: EmptyListWidget(text: 'No movies available'),
                          ),
                        )
                  : ListView.builder(
                      itemCount: movies.length,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 15.0,
                      ),
                      itemBuilder: (context, index) {
                        return MovieCard(
                          movie: movies[index],
                          isFav: favoriteIds.contains(movies[index].id),
                          onFav: (movie, add) {
                            final movieModel = MovieModel(
                              id: movie.id,
                              title: movie.title,
                              description: movie.description,
                              cover: movie.cover,
                              year: movie.year,
                              crew: movie.crew,
                              rating: movie.rating,
                            );

                            if (add) {
                              movieBloc.add(AddMovieEvent(movieModel));
                            } else {
                              movieBloc.add(DeleteMovieEvent(movieModel.id));
                            }

                            setState(() {});
                          },
                          onTap: (movie) async {
                            await Navigator.push(
                              context,
                              CustomRoute(
                                child: ViewMoviePage(movie: movie),
                              ),
                            );

                            movieBloc.add(GetFavoritesEvent());
                          },
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
