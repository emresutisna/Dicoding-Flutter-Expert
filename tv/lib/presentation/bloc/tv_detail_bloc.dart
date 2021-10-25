import 'package:core/domain/entities/tv_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'events/tv_detail_event.dart';
part 'states/tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail _getTvDetail;

  TvDetailBloc(this._getTvDetail) : super(TvEmpty());

  @override
  Stream<TvDetailState> mapEventToState(
    TvDetailEvent event,
  ) async* {
    if (event is FetchTvDetail) {
      yield TvLoading();
      final result = await _getTvDetail.execute(event.id);
      yield* result.fold(
        (failure) async* {
          yield TvError(failure.message);
        },
        (data) async* {
          yield TvHasData(data);
        },
      );
    }
  }
}
