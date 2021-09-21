import 'dart:convert';

import 'package:film_catalog_app/core/error/exception.dart';
import 'package:film_catalog_app/feature/data/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_MOVIES_LIST = 'CACHED_MOVIES_LIST';

abstract class MovieLocalDataSource {
  Future<List<MovieModel>> getLastMoviesFromCache();
  Future<void> moviesToCache(List<MovieModel> movies);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final SharedPreferences sharedPreferences;

  MovieLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<MovieModel>> getLastMoviesFromCache() {
    final jsonMoviesList = sharedPreferences.getStringList(CACHED_MOVIES_LIST);
    if (jsonMoviesList != null && jsonMoviesList.isNotEmpty) {
      return Future.value(jsonMoviesList.map((movie) => MovieModel.fromJson(json.decode(movie))).toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> moviesToCache(List<MovieModel> movies) {
    final List<String> jsonMoviesList = movies.map((movie) => json.encode(movie.toJson())).toList();
    sharedPreferences.setStringList(CACHED_MOVIES_LIST, jsonMoviesList);
    print('Movies to write Cache: ${jsonMoviesList.length}');
    return Future.value(jsonMoviesList);
  }
  
}