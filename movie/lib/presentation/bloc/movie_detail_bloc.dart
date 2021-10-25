import 'package:core/domain/entities/movie_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'events/movie_detail_event.dart';
part 'states/movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(MovieEmpty());

  @override
  Stream<MovieDetailState> mapEventToState(
    MovieDetailEvent event,
  ) async* {
    if (event is FetchMovieDetail) {
      yield MovieLoading();
      final result = await _getMovieDetail.execute(event.id);
      yield* result.fold(
        (failure) async* {
          yield MovieError(failure.message);
        },
        (data) async* {
          yield MovieHasData(data);
        },
      );
    }
  }

  // Future<void> addWatchlist(MovieDetail movie) async {
  //   final result = await _saveWatchlist.execute(movie);

  //   await result.fold(
  //     (failure) async {
  //       _watchlistMessage = failure.message;
  //     },
  //     (successMessage) async {
  //       _watchlistMessage = successMessage;
  //     },
  //   );

  //   await loadWatchlistStatus(movie.id);
  // }

  // Future<void> removeFromWatchlist(MovieDetail movie) async {
  //   final result = await _removeWatchlist.execute(movie);

  //   await result.fold(
  //     (failure) async {
  //       _watchlistMessage = failure.message;
  //     },
  //     (successMessage) async {
  //       _watchlistMessage = successMessage;
  //     },
  //   );

  //   await loadWatchlistStatus(movie.id);
  // }

  // Future<void> loadWatchlistStatus(int id) async {
  //   final result = await _getWatchListStatus.execute(id);
  //   _isAddedtoWatchlist = result;
  // }
}
