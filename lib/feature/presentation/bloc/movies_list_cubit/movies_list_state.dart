import 'package:equatable/equatable.dart';
import 'package:film_catalog_app/feature/domain/entities/movie_entity.dart';

abstract class MoviesListState extends Equatable {
  const MoviesListState();

  @override
  List<Object> get props => [];
}

class MoviesListInitial extends MoviesListState {
  @override
  List<Object> get props => [];
}

class MoviesListLoading extends MoviesListState {
  final List<MovieEntity> oldMoviesList;
  final bool isFirstFetch;

  MoviesListLoading(this.oldMoviesList, {required this.isFirstFetch});

  @override
  List<Object> get props => [oldMoviesList];
}

class MoviesLoaded extends MoviesListState {
  final List<MovieEntity> moviesList;

  MoviesLoaded(this.moviesList);

  @override
  List<Object> get props => [moviesList];
}

class MovieError extends MoviesListState {
  final String message;

  MovieError({required this.message});
  
  @override
  List<Object> get props => [message];
}
