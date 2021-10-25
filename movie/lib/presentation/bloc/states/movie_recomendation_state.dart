part of '../movie_recomendation_bloc.dart';

@immutable
abstract class MovieRecomendationState extends Equatable {
  const MovieRecomendationState();

  @override
  List<Object> get props => [];
}

class MovieRecomendationInitial extends MovieRecomendationState {}

class MovieRecommendationLoading extends MovieRecomendationState {}

class MovieRecommendationError extends MovieRecomendationState {
  final String message;

  MovieRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecomendationsHasData extends MovieRecomendationState {
  final List<Movie> result;

  MovieRecomendationsHasData(this.result);

  @override
  List<Object> get props => [result];
}
