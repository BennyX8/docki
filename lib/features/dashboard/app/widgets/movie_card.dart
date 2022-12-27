import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  final bool isFav;
  final void Function(Movie) onTap;
  final void Function(Movie, bool) onFav;
  const MovieCard({
    Key? key,
    required this.movie,
    required this.isFav,
    required this.onTap,
    required this.onFav,
  }) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();

    isFav = widget.isFav;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(widget.movie),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                width: 120.0,
                height: 120.0,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.movie.cover,
                  ),
                ),
              ),
            ),

            //* Horizontal Spacer
            const SizedBox(width: 15),

            Expanded(
              child: SizedBox(
                height: 120.0,
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
                        fontSize: 16.0,
                      ),
                    ),

                    //* Vertical Spacer
                    const SizedBox(height: 10.0),

                    Expanded(
                      child: Text(
                        widget.movie.description,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    //* Vertical Spacer
                    const SizedBox(height: 10.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          splashRadius: 25.0,
                          onPressed: () {
                            setState(() {
                              isFav = !isFav;
                            });

                            widget.onFav(widget.movie, isFav);
                          },
                          icon: !isFav
                              ? const Icon(
                                  Icons.favorite_border,
                                )
                              : const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                        ),
                        IconButton(
                          splashRadius: 25.0,
                          onPressed: () => widget.onTap(widget.movie),
                          icon: const Icon(Icons.view_sidebar),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
