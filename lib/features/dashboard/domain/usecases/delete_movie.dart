import 'package:dartz/dartz.dart';
import 'package:docki/features/dashboard/domain/repository/movies_repository.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/failures/failure.dart';
import '../../../../core/usecase/usecase.dart';

class DeleteMovie extends Usecase<bool, DeleteMovieParams> {
  final MoviesRepository moviesRepository;

  DeleteMovie(this.moviesRepository);

  @override
  Future<Either<Failure, bool>> call(params) {
    return moviesRepository.deleteMovie(params);
  }
}

class DeleteMovieParams extends Equatable {
  final String id;

  const DeleteMovieParams(this.id);

  @override
  List<Object?> get props => [];
}
