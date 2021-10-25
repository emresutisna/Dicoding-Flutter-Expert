part of '../tv_watchlist_bloc.dart';

@immutable
abstract class TvWatchlistEvent {
  const TvWatchlistEvent();

  @override
  List<Object> get props => [];
}

class AddToWatchList extends TvWatchlistEvent {
  final TvDetail tv;

  AddToWatchList(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveWatchList extends TvWatchlistEvent {
  final TvDetail tv;

  RemoveWatchList(this.tv);

  @override
  List<Object> get props => [tv];
}

class LoadWatchListStatus extends TvWatchlistEvent {
  final int id;

  LoadWatchListStatus(this.id);

  @override
  List<Object> get props => [id];
}
