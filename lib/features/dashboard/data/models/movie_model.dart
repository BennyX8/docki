// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';

import 'package:docki/features/dashboard/domain/entities/movie.dart';

class MovieModel extends Movie {
  final String id;
  final String title;
  final String description;
  final String cover;
  final String? year;
  final String? crew;
  final String? rating;

  const MovieModel({
    required this.id,
    required this.title,
    required this.description,
    required this.cover,
    required this.year,
    required this.crew,
    required this.rating,
  }) : super(
          id: id,
          title: title,
          description: description,
          cover: cover,
          year: year,
          rating: rating,
          crew: crew,
        );

  factory MovieModel.fromMap(Map<String, dynamic> data) {
    return MovieModel(
      id: data['id'],
      title: data['title'],
      description: data['fullTitle']?? data['description'],
      cover: data['image'],
      year: data['year'],
      crew: data['crew'],
      rating: data['imDbRating'],
    );
  }

  factory MovieModel.fromJson(String source) {
    final data = json.decode(source);

    return MovieModel(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      cover: data['cover'],
      year: data['year'],
      crew: data['crew'],
      rating: data['rating'],
    );
  }

  String get toJson {
    return json.encode({
      'id': id,
      'title': title,
      'description': description,
      'cover': cover,
      'year': year,
      'crew': year,
      'rating': rating,
    });
  }
}
