import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';

part 'events/tv_recomendation_event.dart';
part 'states/tv_recomendation_state.dart';

class TvRecomendationBloc
    extends Bloc<TvRecomendationEvent, TvRecomendationState> {
  final GetTvRecommendations _getTvRecommendations;

  TvRecomendationBloc(this._getTvRecommendations)
      : super(TvRecomendationInitial());

  @override
  Stream<TvRecomendationState> mapEventToState(
    TvRecomendationEvent event,
  ) async* {
    if (event is FetchTvRecomendation) {
      yield TvRecommendationLoading();
      final result = await _getTvRecommendations.execute(event.id);

      yield* result.fold(
        (failure) async* {
          yield TvRecommendationError(failure.message);
        },
        (data) async* {
          yield TvRecomendationsHasData(data);
        },
      );
    }
  }
}
