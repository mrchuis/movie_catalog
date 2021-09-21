import 'package:film_catalog_app/core/error/failure.dart';
import 'package:film_catalog_app/feature/domain/entities/movie_entity.dart';
import 'package:film_catalog_app/feature/domain/usecases/get_all_movies.dart';
import 'package:film_catalog_app/feature/presentation/bloc/movies_list_cubit/movies_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'CacheFailure';

class MoviesListCubit extends Cubit<MoviesListState> {
  final GetAllMovies getAllMovies;
  MoviesListCubit({required this.getAllMovies}) : super(MoviesListInitial());
  
  int page = 1;

  void loadMovies() async {
    if (state is MoviesListLoading) return;

    final currentState = state;

    var oldMovies = <MovieEntity>[];

    if (currentState is MoviesLoaded) {
      oldMovies = currentState.moviesList;
    }
    emit(MoviesListLoading(oldMovies, isFirstFetch: page == 1));

    final failureOrMovie = await getAllMovies(PageMovieParams(page: page));

    failureOrMovie.fold((error) => emit(MovieError(message: _mapFailureToMessage(error))),
    (movie) {
      page++;
      final movies = (state as MoviesListLoading).oldMoviesList;
      movies.addAll(movie);
      emit(MoviesLoaded(movies));
    });
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