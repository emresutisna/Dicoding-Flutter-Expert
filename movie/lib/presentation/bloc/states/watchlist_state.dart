part of '../watchlist_bloc.dart';

@immutable
abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistError extends WatchlistState {
  final String message;

  WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistStatusChanged extends WatchlistState {
  final bool result;

  WatchlistStatusChanged(this.result);

  @override
  List<Object> get props => [result];
}
