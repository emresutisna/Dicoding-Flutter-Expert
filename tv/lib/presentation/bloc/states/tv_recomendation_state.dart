part of '../tv_recomendation_bloc.dart';

@immutable
abstract class TvRecomendationState extends Equatable {
  const TvRecomendationState();

  @override
  List<Object> get props => [];
}

class TvRecomendationInitial extends TvRecomendationState {}

class TvRecommendationLoading extends TvRecomendationState {}

class TvRecommendationError extends TvRecomendationState {
  final String message;

  TvRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class TvRecomendationsHasData extends TvRecomendationState {
  final List<Tv> result;

  TvRecomendationsHasData(this.result);

  @override
  List<Object> get props => [result];
}
