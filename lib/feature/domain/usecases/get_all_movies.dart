import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:film_catalog_app/core/error/failure.dart';
import 'package:film_catalog_app/core/usecases/usecase.dart';
import 'package:film_catalog_app/feature/domain/entities/movie_entity.dart';
import 'package:film_catalog_app/feature/domain/repositories/movie_repository.dart';

class GetAllMovies extends UseCase<List<MovieEntity>, PageMovieParams>{
  final MovieRepository movieRepository;

  GetAllMovies(this.movieRepository);
  
  Future<Either<Failure, List<MovieEntity>>> call(PageMovieParams params) async {
    return await movieRepository.getAllMovies(params.page);
  }
}

class PageMovieParams extends Equatable {
  final int page;

  PageMovieParams({required this.page});
  
  @override
  List<Object?> get props => [page];
}