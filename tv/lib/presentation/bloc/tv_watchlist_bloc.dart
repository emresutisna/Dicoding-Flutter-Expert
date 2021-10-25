import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:watchlist/watchlist.dart';

part 'events/tv_watchlist_event.dart';
part 'states/tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchListTvStatus _getWatchListStatus;
  final SaveTvWatchlist _saveWatchlist;
  final RemoveTvWatchlist _removeWatchlist;

  TvWatchlistBloc(
      this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist)
      : super(WatchlistInitial());

  @override
  Stream<TvWatchlistState> mapEventToState(
    TvWatchlistEvent event,
  ) async* {
    if (event is AddToWatchList) {
      final result = await _saveWatchlist.execute(event.tv);
      yield* result.fold(
        (failure) async* {
          yield WatchlistError(failure.message);
        },
        (data) async* {
          yield WatchlistStatusChanged(true);
        },
      );
    } else if (event is RemoveWatchList) {
      final result = await _removeWatchlist.execute(event.tv);
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
