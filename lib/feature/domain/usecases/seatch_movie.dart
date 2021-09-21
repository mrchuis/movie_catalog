import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:film_catalog_app/core/error/failure.dart';
import 'package:film_catalog_app/core/usecases/usecase.dart';
import 'package:film_catalog_app/feature/domain/entities/movie_entity.dart';
import 'package:film_catalog_app/feature/domain/repositories/movie_repository.dart';

class SearchMovie extends UseCase<List<MovieEntity>, SearchMovieParams>{
  final MovieRepository movieRepository;

  SearchMovie(this.movieRepository);
  
  Future<Either<Failure, List<MovieEntity>>> call(SearchMovieParams params) async {
    return await movieRepository.searchMovies(params.query);
  }
}

class SearchMovieParams extends Equatable {
  final String query;

  SearchMovieParams({required this.query});
  
  @override
  List<Object?> get props => [query];
}