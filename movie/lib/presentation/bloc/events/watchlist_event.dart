part of '../watchlist_bloc.dart';

@immutable
abstract class WatchlistEvent {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class AddToWatchList extends WatchlistEvent {
  final MovieDetail movie;

  AddToWatchList(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveWatchList extends WatchlistEvent {
  final MovieDetail movie;

  RemoveWatchList(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadWatchListStatus extends WatchlistEvent {
  final int id;

  LoadWatchListStatus(this.id);

  @override
  List<Object> get props => [id];
}
