part of '../movie_recomendation_bloc.dart';

@immutable
abstract class MovieRecomendationEvent {
  const MovieRecomendationEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieRecomendation extends MovieRecomendationEvent {
  final int id;

  FetchMovieRecomendation(this.id);

  @override
  List<Object> get props => [id];
}
