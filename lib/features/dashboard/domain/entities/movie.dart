import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String id;
  final String title;
  final String description;
  final String cover;
  final String? year;
  final String? crew;
  final String? rating;

  const Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.cover,
    required this.year,
    required this.crew,
    required this.rating,
  });

  @override
  List<Object?> get props => [id, title, description, cover];
}
