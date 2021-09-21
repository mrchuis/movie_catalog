import 'package:dartz/dartz.dart';
import 'package:film_catalog_app/core/error/failure.dart';
import 'package:film_catalog_app/feature/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future <Either<Failure, List<MovieEntity>>> getAllMovies(int page);
  Future <Either<Failure, List<MovieEntity>>> searchMovies(String query);
}