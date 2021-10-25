import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'events/now_playing_movie_event.dart';
part 'states/now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMovieBloc(this.getNowPlayingMovies) : super(MovieEmpty());

  @override
  Stream<NowPlayingMovieState> mapEventToState(
    NowPlayingMovieEvent event,
  ) async* {
    if (event is FetchNowPlayingMovies) {
      yield MovieLoading();
      final result = await getNowPlayingMovies.execute();
      yield* result.fold(
        (failure) async* {
          yield MovieError(failure.message);
        },
        (data) async* {
          yield MovieHasData(data);
        },
      );
    }
  }
}
