import 'package:docki/features/dashboard/app/bloc/movie_bloc.dart';
import 'package:docki/features/dashboard/data/models/movie_model.dart';
import 'package:docki/features/dashboard/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class ViewMoviePage extends StatefulWidget {
  final Movie movie;
  const ViewMoviePage({Key? key, required this.movie}) : super(key: key);

  @override
  State<ViewMoviePage> createState() => _ViewMoviePageState();
}

class _ViewMoviePageState extends State<ViewMoviePage> {
  bool isFav = false;
  final movieBloc = sl<MovieBloc>();

  List<Movie> favorites = [];
  List<String> favoriteIds = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: BlocProvider(
        create: (context) => movieBloc..add(GetFavoritesEvent()),
        child: BlocListener<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is GetFavoritesLoaded) {
              setState(() {
                favorites = state.movies;
                favoriteIds = state.movies.map((e) => e.id).toList();

                isFav = favoriteIds.contains(widget.movie.id);
              });
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.movie.cover),
                  ),
                ),

                //* Vertical Spacer
                const SizedBox(height: 12.0),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //* Vertical Spacer
                      const SizedBox(height: 12.0),

                      Text(
                        widget.movie.title,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),

                      //* Vertical Spacer
                      const SizedBox(height: 15.0),

                      Text(
                        widget.movie.crew ?? 'No Crew information',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),

                      //* Vertical Spacer
                      const SizedBox(height: 30.0),

                      Row(
                        children: [
                          SizedBox(
                            height: 40.0,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              onPressed: () {
                                setState(() {
                                  isFav = !isFav;
                                });

                                if (isFav) {
                                  movieBloc.add(
                                    AddMovieEvent(
                                      MovieModel(
                                        id: widget.movie.id,
                                        title: widget.movie.title,
                                        description: widget.movie.description,
                                        cover: widget.movie.cover,
                                        year: widget.movie.year,
                                        crew: widget.movie.crew,
                                        rating: widget.movie.rating,
                                      ),
                                    ),
                                  );
                                } else {
                                  movieBloc
                                      .add(DeleteMovieEvent(widget.movie.id));
                                }
                              },
                              child: Row(
                                children: [
                                  !isFav
                                      ? const Icon(
                                          Icons.favorite_border,
                                        )
                                      : const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),

                                  //* Horizontal Spacer
                                  const SizedBox(width: 10),

                                  const Text('Favorite')
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      //* Vertical Spacer
                      const SizedBox(height: 50.0),

                      Text(
                        widget.movie.description,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),

                      //* Vertical Spacer
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
