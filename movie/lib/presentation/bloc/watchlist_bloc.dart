import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:watchlist/watchlist.dart';

part 'events/watchlist_event.dart';
part 'states/watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  WatchlistBloc(
      this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist)
      : super(WatchlistInitial());

  @override
  Stream<WatchlistState> mapEventToState(
    WatchlistEvent event,
  ) async* {
    if (event is AddToWatchList) {
      final result = await _saveWatchlist.execute(event.movie);
      yield* result.fold(
        (failure) async* {
          yield WatchlistError(failure.message);
        },
        (data) async* {
          yield WatchlistStatusChanged(true);
        },
      );
    } else if (event is RemoveWatchList) {
      final result = await _removeWatchlist.execute(event.movie);
      yield* result.fold(
        (failure) async* {
          yield WatchlistError(failure.message);
        },
        (data) async* {
          yield WatchlistStatusChanged(false);
        },
      );
    } else if (event is LoadWatchListStatus) {
      final result = await _getWatchListStatus.execute(event.id);
      yield WatchlistStatusChanged(result);
    }
  }
}
