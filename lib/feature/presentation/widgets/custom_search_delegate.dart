import 'package:film_catalog_app/feature/domain/entities/movie_entity.dart';
import 'package:film_catalog_app/feature/presentation/bloc/search_movie_bloc/bloc/search_movie_bloc.dart';
import 'package:film_catalog_app/feature/presentation/widgets/movie_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Поиск фильмов');

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_outlined),
        tooltip: 'Back',
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<SearchMovieBloc>(context, listen: false)
      ..add(SearchMovieEv(query));
    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
      builder: (context, state) {
        if (state is SearchMovieLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SearchMovieLoaded) {
          final movies = state.movies;
          if (movies.isEmpty) {
            return _showErrorText(
                'Не удалось обработать ваш запрос. Попробуйте еще раз');
          }
          return Container(
            child: ListView.separated(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                MovieEntity result = movies[index];
                return MovieCard(movie: result);
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    color: Colors.green[400],
                  ),
                );
              },
            ),
          );
        } else if (state is SearchMovieError) {
          return _showErrorText(state.message);
        } else {
          return Center(
            child: Icon(
              Icons.image,
              size: 48,
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  Widget _showErrorText(String errorMessage) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Text(
          errorMessage,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
