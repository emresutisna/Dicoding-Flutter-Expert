import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'events/now_playing_tv_event.dart';
part 'states/now_playing_tv_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetNowPlayingTvs getNowPlayingTvs;

  NowPlayingTvBloc(this.getNowPlayingTvs) : super(NowPlayingTvEmpty());

  @override
  Stream<NowPlayingTvState> mapEventToState(
    NowPlayingTvEvent event,
  ) async* {
    if (event is FetchNowPlayingTvs) {
      yield NowPlayingTvLoading();
      final result = await getNowPlayingTvs.execute();
      yield* result.fold(
        (failure) async* {
          yield NowPlayingTvError(failure.message);
        },
        (data) async* {
          yield NowPlayingTvHasData(data);
        },
      );
    }
  }
}
