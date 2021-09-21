import 'dart:async';

import 'package:film_catalog_app/feature/domain/entities/movie_entity.dart';
import 'package:film_catalog_app/feature/presentation/bloc/movies_list_cubit/movies_list_cubit.dart';
import 'package:film_catalog_app/feature/presentation/bloc/movies_list_cubit/movies_list_state.dart';
import 'package:film_catalog_app/feature/presentation/widgets/movie_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesList extends StatelessWidget {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _setupScrollController(context);

    var movies = <MovieEntity>[];
    var isLoading = false;
    return BlocBuilder<MoviesListCubit, MoviesListState>(
      builder: (context, state) {
        if (state is MoviesListLoading && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is MoviesListLoading) {
          movies = state.oldMoviesList;
          isLoading = true;
        } else if (state is MoviesLoaded) {
          movies = state.moviesList;
        } else if (state is MovieError) {
          return Text(
            state.message,
            style: TextStyle(color: Colors.white, fontSize: 25),
          );
        }
        return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < movies.length) {
              return MovieCard(movie: movies[index]);
            } else {
              Timer(Duration(milliseconds: 30), () {
                scrollController.jumpTo(scrollController.position.maxScrollExtent);
              });
              return _loadingIndicator();
            }
          },
          separatorBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(
                color: Colors.green[400],
              ),
            );
          },
          itemCount: movies.length + (isLoading ? 1 : 0),
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<MoviesListCubit>().loadMovies();
        }
      }
    });
  }
}
