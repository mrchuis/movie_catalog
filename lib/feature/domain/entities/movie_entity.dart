import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String originalTitle;
  final String overview;
  final String? posterPath;
  final String releaseDate;
  final bool like;

  MovieEntity({
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.like,
  });

  @override
  List<Object?> get props => [
        id,
        originalTitle,
        overview,
        posterPath,
        releaseDate,
        like,
      ];
}
