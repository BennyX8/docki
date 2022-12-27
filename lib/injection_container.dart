import 'dart:convert';

import 'package:docki/core/service_runner/json_checker.dart';
import 'package:docki/features/auth/data/repository/repository_impl.dart';
import 'package:docki/features/auth/domain/usecases/signin.dart';
import 'package:docki/features/auth/domain/usecases/signout.dart';
import 'package:docki/features/auth/domain/usecases/signup.dart';
import 'package:docki/features/dashboard/domain/usecases/add_movie.dart';
import 'package:docki/features/dashboard/domain/usecases/delete_movie.dart';
import 'package:docki/features/dashboard/domain/usecases/get_favorites.dart';
import 'package:docki/features/dashboard/domain/usecases/get_movies.dart';
import 'package:docki/features/dashboard/domain/usecases/search_movie.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

import 'core/network_info/network_info.dart';
import 'features/auth/app/bloc/auth_bloc.dart';
import 'features/auth/data/sources/auth_remote_source.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/dashboard/app/bloc/movie_bloc.dart';
import 'features/dashboard/data/repository/movies_repository_impl.dart';
import 'features/dashboard/data/sources/movies_local_source.dart';
import 'features/dashboard/data/sources/movies_remote_source.dart';
import 'features/dashboard/domain/repository/movies_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl()));
  sl.registerFactory(() => MovieBloc(sl(), sl(), sl(), sl(), sl()));

  //Auth Usecases
  sl.registerLazySingleton(() => Signin(sl()));
  sl.registerLazySingleton(() => Signup(sl()));
  sl.registerLazySingleton(() => Signout(sl()));

  //Movie Usecases
  sl.registerLazySingleton(() => GetMovies(sl()));
  sl.registerLazySingleton(() => SearchMovie(sl()));
  sl.registerLazySingleton(() => AddMovie(sl()));
  sl.registerLazySingleton(() => DeleteMovie(sl()));
  sl.registerLazySingleton(() => GetFavorites(sl()));

  //Auth Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl()));

  //Movie Repository
  sl.registerLazySingleton<MoviesRepository>(
      () => MoviesRepositoryImpl(sl(), sl(), sl()));

  //Auth Data Source
  sl.registerLazySingleton<AuthRemoteSource>(() => AuthRemoteSourceImpl(sl()));

  //Movie Data Source
  sl.registerLazySingleton<MoviesRemoteSource>(
      () => MoviesRemoteSourceImpl(sl(), sl()));
  sl.registerLazySingleton<MoviesLocalSource>(
    () => MoviesLocalSourceImpl(),
  );

  //!Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<JsonChecker>(() => JsonCheckerImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => json);
}
