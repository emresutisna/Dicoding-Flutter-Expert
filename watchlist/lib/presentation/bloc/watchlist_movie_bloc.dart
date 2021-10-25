import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:watchlist/watchlist.dart';

part 'events/watchlist_movie_event.dart';
part 'states/watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc(this.getWatchlistMovies) : super(WatchlistMovieEmpty());

  @override
  Stream<WatchlistMovieState> mapEventToState(
    WatchlistMovieEvent event,
  ) async* {
    if (event is FetchWatchlistMovies) {
      yield WatchlistMovieLoading();
      final result = await getWatchlistMovies.execute();
      yield* result.fold(
        (failure) async* {
          yield WatchlistMovieError(failure.message);
        },
        (data) async* {
          yield WatchlistMovieHasData(data);
        },
      );
    }
  }
}
