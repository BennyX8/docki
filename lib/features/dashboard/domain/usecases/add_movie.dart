import 'package:dartz/dartz.dart';
import 'package:docki/features/dashboard/data/models/movie_model.dart';
import 'package:docki/features/dashboard/domain/repository/movies_repository.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/failures/failure.dart';
import '../../../../core/usecase/usecase.dart';

class AddMovie extends Usecase<bool, AddMovieParams> {
  final MoviesRepository moviesRepository;

  AddMovie(this.moviesRepository);

  @override
  Future<Either<Failure, bool>> call(params) {
    return moviesRepository.addMovie(params);
  }
}

class AddMovieParams extends Equatable {
  final MovieModel movie;

  const AddMovieParams(this.movie);
  @override
  List<Object?> get props => [];
}
