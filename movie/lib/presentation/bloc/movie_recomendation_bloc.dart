import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';

part 'events/movie_recomendation_event.dart';
part 'states/movie_recomendation_state.dart';

class MovieRecomendationBloc
    extends Bloc<MovieRecomendationEvent, MovieRecomendationState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecomendationBloc(this._getMovieRecommendations)
      : super(MovieRecomendationInitial());

  @override
  Stream<MovieRecomendationState> mapEventToState(
    MovieRecomendationEvent event,
  ) async* {
    if (event is FetchMovieRecomendation) {
      yield MovieRecommendationLoading();
      final result = await _getMovieRecommendations.execute(event.id);

      yield* result.fold(
        (failure) async* {
          yield MovieRecommendationError(failure.message);
        },
        (data) async* {
          yield MovieRecomendationsHasData(data);
        },
      );
    }
  }
}
