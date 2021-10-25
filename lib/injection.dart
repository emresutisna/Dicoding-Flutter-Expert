import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_local_data_source.dart';
import 'package:core/data/datasources/tv_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:movie/presentation/bloc/now_playing_movie_bloc.dart';
import 'package:movie/presentation/bloc/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_recomendation_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_bloc.dart';

import 'package:tv/presentation/bloc/now_playing_tv_bloc.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_recomendation_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc.dart';

import 'package:search/presentation/bloc/tv_search_bloc.dart';
import 'package:watchlist/watchlist.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:search/search.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // Bloc
  locator.registerFactory(
    () => NowPlayingMovieBloc(locator()),
  );

  locator.registerFactory(
    () => PopularMovieBloc(locator()),
  );

  locator.registerFactory(
    () => TopRatedMovieBloc(locator()),
  );

  locator.registerFactory(
    () => MovieDetailBloc(locator()),
  );

  locator.registerFactory(
    () => MovieRecomendationBloc(locator()),
  );

  locator.registerFactory(
    () => WatchlistBloc(locator(), locator(), locator()),
  );

  locator.registerFactory(
    () => NowPlayingTvBloc(locator()),
  );

  locator.registerFactory(
    () => PopularTvBloc(locator()),
  );

  locator.registerFactory(
    () => TopRatedTvBloc(locator()),
  );

  locator.registerFactory(
    () => TvDetailBloc(locator()),
  );

  locator.registerFactory(
    () => TvRecomendationBloc(locator()),
  );

  locator.registerFactory(
    () => TvWatchlistBloc(locator(), locator(), locator()),
  );

  locator.registerFactory(
    () => SearchBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvSearchBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistMovieBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistTvBloc(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvs(locator()));
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetWatchListTvStatus(locator()));
  locator.registerLazySingleton(() => SaveTvWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
