import 'package:film_catalog_app/common/app_colors.dart';
import 'package:film_catalog_app/feature/presentation/bloc/movies_list_cubit/movies_list_cubit.dart';
import 'package:film_catalog_app/feature/presentation/bloc/search_movie_bloc/bloc/search_movie_bloc.dart';
import 'package:film_catalog_app/feature/presentation/pages/movies_screen.dart';
import 'package:film_catalog_app/locator_service.dart';
import 'package:flutter/material.dart';
import 'package:film_catalog_app/locator_service.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesListCubit>(
            create: (context) => sl<MoviesListCubit>()..loadMovies()),
        BlocProvider<SearchMovieBloc>(
            create: (context) => sl<SearchMovieBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          backgroundColor: AppColors.mainBackground,
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
