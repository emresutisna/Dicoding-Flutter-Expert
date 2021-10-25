import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'events/popular_movie_event.dart';
part 'states/popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;

  PopularMovieBloc(this.getPopularMovies) : super(PopularMovieEmpty());

  @override
  Stream<PopularMovieState> mapEventToState(
    PopularMovieEvent event,
  ) async* {
    if (event is FetchPopularMovies) {
      yield PopularMovieLoading();
      final result = await getPopularMovies.execute();
      yield* result.fold(
        (failure) async* {
          yield PopularMovieError(failure.message);
        },
        (data) async* {
          yield PopularMovieHasData(data);
        },
      );
    }
  }
}
