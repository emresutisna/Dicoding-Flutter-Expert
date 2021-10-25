import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'events/popular_tv_event.dart';
part 'states/popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTvs getPopularTvs;

  PopularTvBloc(this.getPopularTvs) : super(PopularTvEmpty());

  @override
  Stream<PopularTvState> mapEventToState(
    PopularTvEvent event,
  ) async* {
    if (event is FetchPopularTvs) {
      yield PopularTvLoading();
      final result = await getPopularTvs.execute();
      yield* result.fold(
        (failure) async* {
          yield PopularTvError(failure.message);
        },
        (data) async* {
          yield PopularTvHasData(data);
        },
      );
    }
  }
}
