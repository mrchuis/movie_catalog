import 'package:film_catalog_app/feature/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required id,
    required originalTitle,
    required overview,
    required posterPath,
    required releaseDate,
    like = false,
  }) : super(
          id: id,
          originalTitle: originalTitle,
          overview: overview,
          posterPath: posterPath,
          releaseDate: releaseDate,
          like: like,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'like': like,
    };
  }
}
