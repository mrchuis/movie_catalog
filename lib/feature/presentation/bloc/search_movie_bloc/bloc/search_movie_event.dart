part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class SearchMovieEv extends SearchMovieEvent {
  final String movieQuery;

  SearchMovieEv(this.movieQuery);
}
