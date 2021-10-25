import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:watchlist/watchlist.dart';

part 'events/watchlist_tv_event.dart';
part 'states/watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTvs getWatchlistTvs;

  WatchlistTvBloc(this.getWatchlistTvs) : super(WatchlistTvEmpty());

  @override
  Stream<WatchlistTvState> mapEventToState(
    WatchlistTvEvent event,
  ) async* {
    if (event is FetchWatchlistTvs) {
      yield WatchlistTvLoading();
      final result = await getWatchlistTvs.execute();
      yield* result.fold(
        (failure) async* {
          yield WatchlistTvError(failure.message);
        },
        (data) async* {
          yield WatchlistTvHasData(data);
        },
      );
    }
  }
}
