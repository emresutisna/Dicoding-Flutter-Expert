part of '../tv_recomendation_bloc.dart';

@immutable
abstract class TvRecomendationEvent {
  const TvRecomendationEvent();

  @override
  List<Object> get props => [];
}

class FetchTvRecomendation extends TvRecomendationEvent {
  final int id;

  FetchTvRecomendation(this.id);

  @override
  List<Object> get props => [id];
}
