import 'package:docki/core/widgets/custom_textfield.dart';
import 'package:docki/features/dashboard/app/pages/view_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_loader.dart';
import '../../../../core/widgets/custom_route.dart';
import '../../../../core/widgets/empty_list_widget.dart';
import '../../../../injection_container.dart';
import '../../data/models/movie_model.dart';
import '../../domain/entities/movie.dart';
import '../bloc/movie_bloc.dart';
import '../widgets/movie_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final movieBloc = sl<MovieBloc>();
  List<Movie> movies = [];
  List<Movie> favorites = [];
  List<String> favoriteIds = [];
  bool loadingMovies = false;
  String message = '';
  String query = '';

  final searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Movies'),
      ),
      body: Column(
        children: [
          SizedBox(
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    autoCorrect: false,
                    obscureText: false,
                    controller: searchFieldController,
                    fieldName: '',
                    hintText: 'Search Movies',
                    action: TextInputAction.search,
                    onChanged: (text) {
                      query = text;
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                    movieBloc.add(SearchMoviesEvent(query));
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocProvider(
              create: (context) => movieBloc..add(GetFavoritesEvent()),
              child: BlocListener<MovieBloc, MovieState>(
                listener: (context, state) {

                  if (state is SearchMoviesLoaded) {
                    setState(() {
                      movies = state.movies;
                      loadingMovies = false;
                    });
                  } else if (state is SearchMoviesLoading) {
                    setState(() {
                      loadingMovies = true;
                    });
                  } else if (state is SearchMoviesError) {
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
                            message: 'Searching Movies',
                          )
                        : const Center(
                            child: Center(
                              child:
                                  EmptyListWidget(text: 'No movies available'),
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
                            },
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
