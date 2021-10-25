part of '../now_playing_movie_bloc.dart';

abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object> get props => [];
}

class MovieEmpty extends NowPlayingMovieState {}

class MovieLoading extends NowPlayingMovieState {}

class MovieError extends NowPlayingMovieState {
  final String message;

  MovieError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieHasData extends NowPlayingMovieState {
  final List<Movie> result;

  MovieHasData(this.result);

  @override
  List<Object> get props => [result];
}
