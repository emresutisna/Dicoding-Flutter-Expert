import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'events/top_rated_movie_event.dart';
part 'states/top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMovieBloc(this.getTopRatedMovies) : super(TopRatedMovieEmpty());

  @override
  Stream<TopRatedMovieState> mapEventToState(
    TopRatedMovieEvent event,
  ) async* {
    if (event is FetchTopRatedMovies) {
      yield TopRatedMovieLoading();
      final result = await getTopRatedMovies.execute();
      yield* result.fold(
        (failure) async* {
          yield TopRatedMovieError(failure.message);
        },
        (data) async* {
          yield TopRatedMovieHasData(data);
        },
      );
    }
  }
}
