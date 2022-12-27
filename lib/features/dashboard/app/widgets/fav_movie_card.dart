import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';

class FavMovieCard extends StatefulWidget {
  final Movie movie;
  final void Function(Movie) onTap;
  final void Function(Movie) onDelete;
  const FavMovieCard({
    Key? key,
    required this.movie,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<FavMovieCard> createState() => _FavMovieCardState();
}

class _FavMovieCardState extends State<FavMovieCard> {
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
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(
                  widget.movie.cover,
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
                          onPressed: () => widget.onDelete(widget.movie),
                          icon: const Icon(Icons.delete),
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
