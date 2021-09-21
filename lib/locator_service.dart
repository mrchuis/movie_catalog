import 'package:film_catalog_app/core/platform/network_info.dart';
import 'package:film_catalog_app/feature/data/datasources/movie_local_data_source.dart';
import 'package:film_catalog_app/feature/data/datasources/movie_remote_data_source.dart';
import 'package:film_catalog_app/feature/data/repositories/movie_repository_impl.dart';
import 'package:film_catalog_app/feature/domain/repositories/movie_repository.dart';
import 'package:film_catalog_app/feature/domain/usecases/get_all_movies.dart';
import 'package:film_catalog_app/feature/domain/usecases/seatch_movie.dart';
import 'package:film_catalog_app/feature/presentation/bloc/movies_list_cubit/movies_list_cubit.dart';
import 'package:film_catalog_app/feature/presentation/bloc/search_movie_bloc/bloc/search_movie_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //BloC / Cubit
  sl.registerFactory(() => MoviesListCubit(getAllMovies: sl()));
  sl.registerFactory(() => SearchMovieBloc(searchMovie: sl()));
  
  //Usecases
  sl.registerLazySingleton(() => GetAllMovies(sl()));
  sl.registerLazySingleton(() => SearchMovie(sl()));
  
  //Reposotory
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: sl())
  );

  sl.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(sharedPreferences: sl())
  );

  //Cores
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}