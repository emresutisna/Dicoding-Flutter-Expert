part of '../tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvEmpty extends TvDetailState {}

class TvLoading extends TvDetailState {}

class TvError extends TvDetailState {
  final String message;

  TvError(this.message);

  @override
  List<Object> get props => [message];
}

class TvHasData extends TvDetailState {
  final TvDetail result;

  TvHasData(this.result);

  @override
  List<Object> get props => [result];
}
