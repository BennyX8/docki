import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_loader.dart';
import '../../../../core/widgets/custom_route.dart';
import '../../../../core/widgets/empty_list_widget.dart';
import '../../../../injection_container.dart';
import '../bloc/movie_bloc.dart';
import 'view_movie_page.dart';
import '../widgets/fav_movie_card.dart';
import '../../domain/entities/movie.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final movieBloc = sl<MovieBloc>();
  Set<Movie> movies = {};
  bool loadingMovies = false;
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Favorite Movies'),
      ),
      body: BlocProvider(
        create: (context) => movieBloc..add(GetFavoritesEvent()),
        child: BlocListener<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is GetFavoritesLoaded) {
              setState(() {
                movies = state.movies.toSet();
                loadingMovies = false;
              });
            } else if (state is GetFavoritesLoading) {
              setState(() {
                loadingMovies = true;
              });
            } else if (state is GetFavoritesError) {
              setState(() {
                loadingMovies = false;
              });
            }
            if (state is DeleteMovieLoaded) {
              movieBloc.add(GetFavoritesEvent());
              setState(() {});
            } else if (state is DeleteMovieLoading) {
              setState(() {});
            } else if (state is DeleteMovieError) {
              setState(() {});
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
                    return FavMovieCard(
                      movie: movies.toList()[index],
                      onTap: (movie) async {
                        await Navigator.push(
                          context,
                          CustomRoute(
                            child: ViewMoviePage(movie: movie),
                          ),
                        );
                      },
                      onDelete: (movie) {
                        movieBloc.add(DeleteMovieEvent(movie.id));
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
