import 'package:dartz/dartz.dart';
import 'package:film_catalog_app/core/error/exception.dart';
import 'package:film_catalog_app/core/error/failure.dart';
import 'package:film_catalog_app/core/platform/network_info.dart';
import 'package:film_catalog_app/feature/data/datasources/movie_local_data_source.dart';
import 'package:film_catalog_app/feature/data/datasources/movie_remote_data_source.dart';
import 'package:film_catalog_app/feature/data/models/movie_model.dart';
import 'package:film_catalog_app/feature/domain/entities/movie_entity.dart';
import 'package:film_catalog_app/feature/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<MovieEntity>>> getAllMovies(int page) async {
    return await _getMovies(() {
      return remoteDataSource.getAllMovies(page);
    });
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> searchMovies(String query) async {
    return await _getMovies(() {
      return remoteDataSource.searchMovie(query);
    });
  }

  Future<Either<Failure, List<MovieEntity>>> _getMovies(
      Future<List<MovieModel>> Function() getMovies) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMovies = await getMovies();
        localDataSource.moviesToCache(remoteMovies);
        return Right(remoteMovies);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationMovie = await localDataSource.getLastMoviesFromCache();
        return Right(locationMovie);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
