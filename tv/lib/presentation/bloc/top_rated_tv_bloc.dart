import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'events/top_rated_tv_event.dart';
part 'states/top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTvs getTopRatedTvs;

  TopRatedTvBloc(this.getTopRatedTvs) : super(TopRatedTvEmpty());

  @override
  Stream<TopRatedTvState> mapEventToState(
    TopRatedTvEvent event,
  ) async* {
    if (event is FetchTopRatedTvs) {
      yield TopRatedTvLoading();
      final result = await getTopRatedTvs.execute();
      yield* result.fold(
        (failure) async* {
          yield TopRatedTvError(failure.message);
        },
        (data) async* {
          yield TopRatedTvHasData(data);
        },
      );
    }
  }
}
