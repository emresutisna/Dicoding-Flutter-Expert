part of '../movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieEmpty extends MovieDetailState {}

class MovieLoading extends MovieDetailState {}

class MovieError extends MovieDetailState {
  final String message;

  MovieError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieHasData extends MovieDetailState {
  final MovieDetail result;

  MovieHasData(this.result);

  @override
  List<Object> get props => [result];
}
