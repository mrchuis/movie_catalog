import 'dart:convert';
import 'package:film_catalog_app/core/error/exception.dart';
import 'package:film_catalog_app/feature/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

abstract class MovieRemoteDataSource {
  ///Calls the https://api.themoviedb.org/3/discover/movie?api_key=6ccd72a2a8fc239b13f209408fc31c33&page=1 endpoint
  Future<List<MovieModel>> getAllMovies(int page);

  /// Calls the https://api.themoviedb.org/3/search/movie?api_key=6ccd72a2a8fc239b13f209408fc31c33&query=Malignant endpoint
  Future<List<MovieModel>> searchMovie(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = '6ccd72a2a8fc239b13f209408fc31c33';

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getAllMovies(int page) =>
      _getMoviesFromUrl('$baseUrl/discover/movie?api_key=$apiKey&page=$page');

  @override
  Future<List<MovieModel>> searchMovie(String query) => _getMoviesFromUrl(
      '$baseUrl/search/movie?api_key=$apiKey&query=$query');
  

  Future<List<MovieModel>> _getMoviesFromUrl(String url) async {
    print(url);
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final movies = json.decode(response.body);
      return (movies['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
