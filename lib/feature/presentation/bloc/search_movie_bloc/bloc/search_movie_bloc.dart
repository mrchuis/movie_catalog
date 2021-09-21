import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:film_catalog_app/core/error/failure.dart';
import 'package:film_catalog_app/feature/domain/entities/movie_entity.dart';
import 'package:film_catalog_app/feature/domain/usecases/seatch_movie.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'CacheFailure';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovie searchMovie;
  SearchMovieBloc({required this.searchMovie}) : super(SearchMovieInitial());

  @override
  Stream<SearchMovieState> mapEventToState(
    SearchMovieEvent event,
  ) async* {
    if (event is SearchMovieEv) {
      yield* _mapFetchMovieToState(event.movieQuery);
    }
  }

  Stream<SearchMovieState> _mapFetchMovieToState(String movieQuery) async* {
    yield SearchMovieLoading();

    final failureOrMovie =
        await searchMovie(SearchMovieParams(query: movieQuery));

    yield failureOrMovie.fold(
      (failure) => SearchMovieError(message: _mapFailureToMessage(failure)),
      (movie) => SearchMovieLoaded(movies: movie),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
