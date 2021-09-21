part of 'search_movie_bloc.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

class SearchMovieInitial extends SearchMovieState {}

class SearchMovieLoading extends SearchMovieState {}

class SearchMovieLoaded extends SearchMovieState {
  final List<MovieEntity> movies;

  SearchMovieLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class SearchMovieError extends SearchMovieState {
  final String message;

  SearchMovieError({required this.message});

  @override
  List<Object> get props => [message]; 
}
