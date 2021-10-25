part of '../tv_watchlist_bloc.dart';

@immutable
abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistInitial extends TvWatchlistState {}

class WatchlistLoading extends TvWatchlistState {}

class WatchlistError extends TvWatchlistState {
  final String message;

  WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistStatusChanged extends TvWatchlistState {
  final bool result;

  WatchlistStatusChanged(this.result);

  @override
  List<Object> get props => [result];
}
